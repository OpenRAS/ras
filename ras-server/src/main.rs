mod message;
mod worker;

use std::time::Duration;

use enigo::{Enigo, MouseControllable};
use futures::{stream::SplitSink, FutureExt, SinkExt, StreamExt};

use tokio::time;

use warp::{ws, Filter};
use worker::CaptureWorker;

use crate::message::RasMessage;

fn main() {
    tokio::runtime::Runtime::new()
        .unwrap()
        .block_on(async_main())
}

async fn async_main() {
    let index_route = warp::path::end().map(|| "OpenRAS");

    let echo_route = warp::path("desktop")
        .and(warp::ws())
        .map(|ws: ws::Ws| ws.on_upgrade(|ws| on_connect_desktop(ws)));

    let routes = index_route.or(echo_route);
    warp::serve(routes).run(([127, 0, 0, 1], 3030)).await;
}

async fn on_connect_desktop(socket: ws::WebSocket) {
    let (ws_tx, mut ws_rx) = socket.split();

    let capture_task = tokio::spawn(desktop_capture_task(ws_tx));

    let mut enigo = Enigo::new();

    while let Some(message) = ws_rx.next().await {
        dbg!(&message);

        match message {
            Ok(message) => {
                if message.is_close() {
                    capture_task.abort();
                }

                if message.is_text() {
                    let message = RasMessage::from_str(message.to_str().unwrap());
                    match message {
                        RasMessage::MouseMove { x, y } => {
                            enigo.mouse_move_to(x, y);
                        }
                        RasMessage::MouseUp { button } => {
                            if let Some(button) = map_button_type(button) {
                                enigo.mouse_up(button);
                            }
                        }
                        RasMessage::MouseDown { button } => {
                            if let Some(button) = map_button_type(button) {
                                enigo.mouse_down(button);
                            }
                        }
                        RasMessage::MouseClick { button } => {
                            if let Some(button) = map_button_type(button) {
                                enigo.mouse_click(button);
                            }
                        }
                        RasMessage::MouseScrollX { offset } => {
                            enigo.mouse_scroll_x(offset);
                        }
                        RasMessage::MouseScrollY { offset } => {
                            enigo.mouse_scroll_y(offset);
                        }
                        _ => {
                            eprintln!("bad message: {:?}", message);
                        }
                    }
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

fn map_button_type(button: String) -> Option<enigo::MouseButton> {
    match button.as_str() {
        "l" => Some(enigo::MouseButton::Left),
        "m" => Some(enigo::MouseButton::Middle),
        "r" => Some(enigo::MouseButton::Right),
        "sd" => Some(enigo::MouseButton::ScrollDown),
        "su" => Some(enigo::MouseButton::ScrollUp),
        "sl" => Some(enigo::MouseButton::ScrollLeft),
        "sr" => Some(enigo::MouseButton::ScrollRight),
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
                let chunk_size = 65536;
                let chunks = frame.chunks(chunk_size);

                let vf = RasMessage::VideoFrame {
                    width: result.width,
                    height: result.height,
                    chunks: chunks.len(),
                };
                tx.send(ws::Message::text(vf.encode())).await.unwrap();

                for chunk in chunks {
                    tx.send(ws::Message::binary(chunk)).await.unwrap();
                }
            }
        }
    }
}
