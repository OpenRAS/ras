use std::time::{Instant, SystemTime, UNIX_EPOCH};

use codec::{Openh264Config, Openh264Decoder, Openh264Encoder};

fn main() {
    let width = 32;
    let height = 32;

    let config = Openh264Config {
        width,
        height,
        bitrate: 1000_000,
        fps: 30.0,
    };

    let mut encoder = Openh264Encoder::new(config).unwrap();

    let mut y = Vec::new();
    let mut u = Vec::new();
    let mut v = Vec::new();

    y.resize((width * height) as _, 33);
    u.resize((width * height / 4) as _, 33);
    v.resize((width * height / 4) as _, 33);

    let frame = encoder.encode(&mut y[..], &mut u[..], &mut v[..]).unwrap();

    let mut decoder = Openh264Decoder::new().unwrap();
    let frame = decoder.decode(&frame[..]).unwrap().unwrap();
    dbg!(frame);

    // let start = Instant::now();

    // let frames = 200;
    // let mut size = 0;
    // for i in 0..frames {
    //     randomize(&mut y);
    //     randomize(&mut u);
    //     randomize(&mut v);
    //     let frame = encoder.encode(&mut y[..], &mut u[..], &mut v[..]).unwrap();
    //     size += frame.len();
    // }

    // let fps = frames as f64 / start.elapsed().as_millis() as f64 * 1000.0;
    // dbg!(fps);

    // let kb = size as f64 / 1024 as f64;
    // dbg!(kb);

    // encoder.encode(&mut y[..], &mut u[..], &mut v[..]).unwrap();
}

fn randomize(s: &mut [u8]) {
    let step = 1;
    let r = epoch_ms() as u8;
    for i in 0..(s.len() / step) {
        s[i * step] = r;
    }
}

fn epoch_ms() -> u128 {
    SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap()
        .as_millis()
}
