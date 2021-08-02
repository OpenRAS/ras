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

    // 20 fps
    let mut interval = time::interval(Duration::from_millis(50));
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
                proto::key_up::Union::Char(char) => {
                    if let Some(char) = char::from_u32(char) {
                        enigo.key_up(enigo::Key::Layout(char));
                    }
                }
                _ => {}
            },
            message::Union::KeyDown(message) => match message.union.unwrap() {
                proto::key_down::Union::Char(char) => {
                    if let Some(char) = char::from_u32(char) {
                        enigo.key_down(enigo::Key::Layout(char));
                    }
                }
                _ => {}
            },
            _ => {
                eprintln!("bad message: {:?}", union);
            }
        }
    }
}
