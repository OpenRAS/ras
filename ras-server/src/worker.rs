use std::{sync::mpsc, thread, time::Instant};

use codec::VpxEncoder;
use tokio::sync::oneshot;

pub struct CaptureWorker {
    sender: mpsc::Sender<CaptureJob>,
}

impl CaptureWorker {
    pub fn new() -> CaptureWorker {
        let (tx, rx) = mpsc::channel::<CaptureJob>();

        thread::spawn(move || {
            capture_worker(rx);
        });

        CaptureWorker { sender: tx }
    }

    pub fn submit(&self) -> oneshot::Receiver<CaptureResult> {
        let (tx, rx) = oneshot::channel();
        let job = CaptureJob { tx };
        self.sender.send(job).unwrap();
        rx
    }
}

struct CaptureJob {
    tx: oneshot::Sender<CaptureResult>,
}

impl CaptureJob {
    fn compelete(self, result: CaptureResult) {
        self.tx.send(result).unwrap_or_default();
    }
}

// fn capture_worker(rx: mpsc::Receiver<CaptureJob>) {
//     let start_time = Instant::now();
//     let display = scrap::Display::primary().unwrap();

//     let encode_config = codec::VpxConfig {
//         width: display.width() as _,
//         height: display.height() as _,
//         timebase: [1, 1000],
//         bitrate: 2000,
//         codec: codec::VpxCodec::VP9,
//         rc_min_quantizer: 4,
//         rc_max_quantizer: 63,
//         speed: 8,
//         num_threads: 0,
//     };

//     let mut encoder = VpxEncoder::new(&encode_config).unwrap();

//     let mut yuv_buffer = Vec::new();

//     let width = display.width();
//     let height = display.height();
//     let mut capturer = scrap::Capturer::new(display).unwrap();

//     while let Ok(job) = rx.recv() {
//         if let Ok(frame) = capturer.frame() {
//             let pts = start_time.elapsed().as_millis();
//             codec::bgra_to_i420(width, height, &frame, &mut yuv_buffer);

//             let mut result = Vec::new();

//             let frames = encoder.encode_i420(pts as _, &yuv_buffer).unwrap();
//             for frame in frames {
//                 result.push(frame.data.to_vec());
//             }

//             let frames = encoder.flush().unwrap();
//             for frame in frames {
//                 result.push(frame.data.to_vec());
//             }

//             let result = CaptureResult {
//                 width,
//                 height,
//                 frames: result,
//             };
//             job.compelete(result);
//         }
//     }
// }

fn capture_worker(rx: mpsc::Receiver<CaptureJob>) {
    let display = scrap::Display::primary().unwrap();

    let encoder_config = codec::Openh264Config {
        width: display.width() as _,
        height: display.height() as _,
        fps: 30.0,
        bitrate: 1000_000,
    };

    let mut encoder = codec::Openh264Encoder::new(encoder_config).unwrap();

    let mut y = Vec::new();
    let mut u = Vec::new();
    let mut v = Vec::new();

    let width = display.width();
    let height = display.height();
    let mut capturer = scrap::Capturer::new(display).unwrap();

    while let Ok(job) = rx.recv() {
        if let Ok(frame) = capturer.frame() {
            y.resize(width * height, 0);
            u.resize(width * height / 4, 0);
            v.resize(width * height / 4, 0);

            unsafe {
                codec::ARGBToI420(
                    frame.as_ptr(),
                    (frame.len() / height) as _,
                    y.as_mut_ptr(),
                    width as _,
                    u.as_mut_ptr(),
                    (width / 2) as _,
                    v.as_mut_ptr(),
                    (width / 2) as _,
                    width as _,
                    height as _,
                );
            }

            let frame = encoder.encode(&mut y[..], &mut u[..], &mut v[..]).unwrap();

            let result = CaptureResult {
                width,
                height,
                frames: vec![frame],
            };
            job.compelete(result);
        }
    }
}

pub struct CaptureResult {
    pub width: usize,
    pub height: usize,
    pub frames: Vec<Vec<u8>>,
}
