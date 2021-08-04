// mod message;
mod proto;
mod worker;

use std::{time::Duration};

use futures::{stream::SplitSink, FutureExt, SinkExt, StreamExt};

use isim::ISim;
use prost::{
    Message,
};
use tokio::{sync::mpsc, time};

use warp::{ws, Filter};
use worker::CaptureWorker;

fn main() {
    tokio::runtime::Builder::new_current_thread()
        .enable_all()
        .build()
        .unwrap()
        .block_on(async_main());
}

async fn async_main() {
    let index_route = warp::path::end().map(|| "OpenRAS");

    let echo_route = warp::path("desktop")
        .and(warp::ws())
        .map(|ws: ws::Ws| ws.on_upgrade(|ws| on_connect_desktop(ws)));

    let routes = index_route.or(echo_route);
    warp::serve(routes).run(([0, 0, 0, 0], 3030)).await;
}

async fn on_connect_desktop(socket: ws::WebSocket) {
    let (ws_tx, mut ws_rx) = socket.split();
    let capture_task = tokio::spawn(desktop_capture_task(ws_tx));

    let (isim_tx, isim_rx) = mpsc::unbounded_channel::<proto::Message>();
    tokio::spawn(message_process_task(isim_rx));

    while let Some(message) = ws_rx.next().await {
        // dbg!(&message);

        match message {
            Ok(message) => {
                if message.is_close() {
                    capture_task.abort();
                    break;
                }

                if message.is_binary() {
                    let message = proto::Message::decode(message.as_bytes()).unwrap();
                    isim_tx.send(message).unwrap();
                }
            }
            Err(e) => {
                eprintln!("websocket error: {}", e);
                capture_task.abort();
                break;
            }
        }
    }
}

fn map_button_type(button: i32) -> Option<isim::MouseButton> {
    match proto::MouseButton::from_i32(button).unwrap() {
        proto::MouseButton::Left => Some(isim::MouseButton::Left),
        proto::MouseButton::Middle => Some(isim::MouseButton::Middle),
        proto::MouseButton::Right => Some(isim::MouseButton::Right),
        proto::MouseButton::ScrollDown => Some(isim::MouseButton::ScrollDown),
        proto::MouseButton::ScrollUp => Some(isim::MouseButton::ScrollUp),
        proto::MouseButton::ScrollLeft => Some(isim::MouseButton::ScrollLeft),
        proto::MouseButton::ScrollRight => Some(isim::MouseButton::ScrollRight),
        _ => None,
    }
}

async fn desktop_capture_task(mut tx: SplitSink<ws::WebSocket, ws::Message>) {
    let capture_worker = CaptureWorker::new();

    let fps = 30;
    let spf = Duration::from_millis(1000 / fps);
    // 20 fps
    let mut interval = time::interval(spf);
    interval.set_missed_tick_behavior(time::MissedTickBehavior::Skip);

    loop {
        interval.tick().await;

        let result = capture_worker.submit();
        let result = result.await;
        if let Ok(result) = result {
            for frame in result.frames {
                // let chunk_size = 65536;
                // let chunks = frame.chunks(chunk_size);

                let vf = proto::message::Union::VideoFrame(proto::VideoFrame {
                    width: result.width as _,
                    height: result.height as _,
                    data: frame,
                });

                // ::VideoFrame {
                // };
                tx.send(ws::Message::binary(message(vf))).await.unwrap();
            }
        }
    }
}

fn message(union: proto::message::Union) -> Vec<u8> {
    let message = proto::Message { union: Some(union) };
    let mut buffer = Vec::with_capacity(message.encoded_len());
    message.encode(&mut buffer).unwrap();
    buffer
}

async fn message_process_task(mut rx: mpsc::UnboundedReceiver<proto::Message>) {
    use proto::key_down;
    use proto::key_up;
    use proto::message;

    // let mut isim = isim::new();
    let mut isim = ISim::new();

    while let Some(message) = rx.recv().await {
        let union = message.union.unwrap();
        match union {
            message::Union::MouseMove(message) => {
                isim.mouse_move(message.x as _, message.y as _);
            }
            message::Union::MouseUp(message) => {
                if let Some(button) = map_button_type(message.button) {
                    isim.mouse_up(button);
                }
            }
            message::Union::MouseDown(message) => {
                if let Some(button) = map_button_type(message.button) {
                    isim.mouse_down(button);
                }
            }
            message::Union::MouseClick(message) => {
                if let Some(button) = map_button_type(message.button) {
                    isim.mouse_down(button);
                    isim.mouse_up(button);
                }
            }
            message::Union::MouseScroll(message) => {
                isim.mouse_scroll(message.dx, message.dy);
            }
            message::Union::KeyUp(message) => match message.union.unwrap() {
                key_up::Union::Char(char) => {
                    if let Some(char) = char::from_u32(char) {
                        isim.key_up(isim::Key::Char(char));
                    }
                }
                key_up::Union::Key(key) => {
                    if let Some(key) = proto::Key::from_i32(key) {
                        if let Some(key) = map_key_type(key) {
                            isim.key_up(key);
                        }
                    }
                }
            },
            message::Union::KeyDown(message) => match message.union.unwrap() {
                key_down::Union::Char(char) => {
                    if let Some(char) = char::from_u32(char) {
                        isim.key_down(isim::Key::Char(char));
                    }
                }
                key_down::Union::Key(key) => {
                    if let Some(key) = proto::Key::from_i32(key) {
                        if let Some(key) = map_key_type(key) {
                            dbg!(key);
                            isim.key_down(key);
                        }
                    }
                }
            },
            _ => {
                eprintln!("bad message: {:?}", union);
            }
        }
    }
}

fn map_key_type(key: proto::Key) -> Option<isim::Key> {
    match key {
        proto::Key::Alt => Some(isim::Key::Alt),
        proto::Key::Backspace => Some(isim::Key::Backspace),
        proto::Key::CapsLock => Some(isim::Key::CapsLock),
        proto::Key::Control => Some(isim::Key::Control),
        proto::Key::Delete => Some(isim::Key::Delete),
        proto::Key::DownArrow => Some(isim::Key::DownArrow),
        proto::Key::End => Some(isim::Key::End),
        proto::Key::Escape => Some(isim::Key::Escape),
        proto::Key::F1 => Some(isim::Key::F1),
        proto::Key::F10 => Some(isim::Key::F10),
        proto::Key::F11 => Some(isim::Key::F11),
        proto::Key::F12 => Some(isim::Key::F12),
        proto::Key::F2 => Some(isim::Key::F2),
        proto::Key::F3 => Some(isim::Key::F3),
        proto::Key::F4 => Some(isim::Key::F4),
        proto::Key::F5 => Some(isim::Key::F5),
        proto::Key::F6 => Some(isim::Key::F6),
        proto::Key::F7 => Some(isim::Key::F7),
        proto::Key::F8 => Some(isim::Key::F8),
        proto::Key::F9 => Some(isim::Key::F9),
        proto::Key::Home => Some(isim::Key::Home),
        proto::Key::LeftArrow => Some(isim::Key::LeftArrow),
        proto::Key::Meta => Some(isim::Key::Meta),
        proto::Key::Option => Some(isim::Key::Option),
        proto::Key::PageDown => Some(isim::Key::PageDown),
        proto::Key::PageUp => Some(isim::Key::PageUp),
        proto::Key::Return => Some(isim::Key::Return),
        proto::Key::RightArrow => Some(isim::Key::RightArrow),
        proto::Key::Shift => Some(isim::Key::Shift),
        proto::Key::Space => Some(isim::Key::Space),
        proto::Key::Tab => Some(isim::Key::Tab),
        proto::Key::UpArrow => Some(isim::Key::UpArrow),
        _ => None,
    }
}
