// mod message;
mod proto;
mod worker;

use std::{sync::mpsc, thread, time::Duration};

use enigo::{Enigo, KeyboardControllable, MouseControllable};
use futures::{stream::SplitSink, FutureExt, SinkExt, StreamExt};

use prost::{
    bytes::{BufMut, Bytes},
    Message,
};
use tokio::time;

use warp::{ws, Filter};
use worker::CaptureWorker;

// use crate::message::RasMessage;

fn main() {
    tokio::runtime::Builder::new_current_thread()
        .enable_all()
        .build()
        .unwrap()
        .block_on(async_main())

    // tokio::runtime::Runtime::new()
    //     .unwrap()
    //     .block_on(async_main())
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

    let (enigo_tx, enigo_rx) = mpsc::channel::<proto::Message>();
    let enigo = Enigo::new();

    thread::spawn(move || enigo_thread(enigo, enigo_rx));

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
                    enigo_tx.send(message).unwrap();
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

fn map_button_type(button: i32) -> Option<enigo::MouseButton> {
    match proto::MouseButton::from_i32(button).unwrap() {
        proto::MouseButton::Left => Some(enigo::MouseButton::Left),
        proto::MouseButton::Middle => Some(enigo::MouseButton::Middle),
        proto::MouseButton::Right => Some(enigo::MouseButton::Right),
        proto::MouseButton::ScrollDown => Some(enigo::MouseButton::ScrollDown),
        proto::MouseButton::ScrollUp => Some(enigo::MouseButton::ScrollUp),
        proto::MouseButton::ScrollLeft => Some(enigo::MouseButton::ScrollLeft),
        proto::MouseButton::ScrollRight => Some(enigo::MouseButton::ScrollRight),
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

fn enigo_thread(mut enigo: enigo::Enigo, rx: mpsc::Receiver<proto::Message>) {
    use proto::message;
    use proto::key_up;
    use proto::key_down;

    // let mut enigo = Enigo::new();

    while let Ok(message) = rx.recv() {
        let union = message.union.unwrap();
        match union {
            message::Union::MouseMove(message) => {
                enigo.mouse_move_to(message.x as _, message.y as _);
            }
            message::Union::MouseUp(message) => {
                if let Some(button) = map_button_type(message.button) {
                    enigo.mouse_up(button);
                }
            }
            message::Union::MouseDown(message) => {
                if let Some(button) = map_button_type(message.button) {
                    enigo.mouse_down(button);
                }
            }
            message::Union::MouseClick(message) => {
                if let Some(button) = map_button_type(message.button) {
                    enigo.mouse_click(button);
                }
            }
            message::Union::MouseScroll(message) => {
                if message.dx != 0 {
                    enigo.mouse_scroll_x(message.dx);
                }

                if message.dy != 0 {
                    enigo.mouse_scroll_y(message.dy);
                }
            }
            message::Union::KeyUp(message) => match message.union.unwrap() {
                key_up::Union::Char(char) => {
                    if let Some(char) = char::from_u32(char) {
                        enigo.key_up(enigo::Key::Layout(char));
                    }
                }
                key_up::Union::Key(key) => {
                    if let Some(key) = proto::Key::from_i32(key) {
                        if let Some(key) = map_key_type(key) {
                            enigo.key_up(key);
                        }
                    }
                }
            },
            message::Union::KeyDown(message) => match message.union.unwrap() {
                key_down::Union::Char(char) => {
                    if let Some(char) = char::from_u32(char) {
                        enigo.key_down(enigo::Key::Layout(char));
                    }
                }
                key_down::Union::Key(key) => {
                    if let Some(key) = proto::Key::from_i32(key) {
                        if let Some(key) = map_key_type(key) {
                            dbg!(key);
                            enigo.key_down(key);
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

fn map_key_type(key: proto::Key) -> Option<enigo::Key> {
    match key {
        proto::Key::Alt => Some(enigo::Key::Alt),
        proto::Key::Backspace => Some(enigo::Key::Backspace),
        proto::Key::CapsLock => Some(enigo::Key::CapsLock),
        proto::Key::Control => Some(enigo::Key::Control),
        proto::Key::Delete => Some(enigo::Key::Delete),
        proto::Key::DownArrow => Some(enigo::Key::DownArrow),
        proto::Key::End => Some(enigo::Key::End),
        proto::Key::Escape => Some(enigo::Key::Escape),
        proto::Key::F1 => Some(enigo::Key::F1),
        proto::Key::F10 => Some(enigo::Key::F10),
        proto::Key::F11 => Some(enigo::Key::F11),
        proto::Key::F12 => Some(enigo::Key::F12),
        proto::Key::F2 => Some(enigo::Key::F2),
        proto::Key::F3 => Some(enigo::Key::F3),
        proto::Key::F4 => Some(enigo::Key::F4),
        proto::Key::F5 => Some(enigo::Key::F5),
        proto::Key::F6 => Some(enigo::Key::F6),
        proto::Key::F7 => Some(enigo::Key::F7),
        proto::Key::F8 => Some(enigo::Key::F8),
        proto::Key::F9 => Some(enigo::Key::F9),
        proto::Key::Home => Some(enigo::Key::Home),
        proto::Key::LeftArrow => Some(enigo::Key::LeftArrow),
        proto::Key::Meta => Some(enigo::Key::Meta),
        proto::Key::Option => Some(enigo::Key::Option),
        proto::Key::PageDown => Some(enigo::Key::PageDown),
        proto::Key::PageUp => Some(enigo::Key::PageUp),
        proto::Key::Return => Some(enigo::Key::Return),
        proto::Key::RightArrow => Some(enigo::Key::RightArrow),
        proto::Key::Shift => Some(enigo::Key::Shift),
        proto::Key::Space => Some(enigo::Key::Space),
        proto::Key::Tab => Some(enigo::Key::Tab),
        proto::Key::UpArrow => Some(enigo::Key::UpArrow),
        _ => None,
    }
}
