use std::{
    borrow::Cow,
    path::Path,
    process::exit,
    rc::Rc,
    sync::{Arc, Mutex},
    thread,
    time::Duration,
};

use dcv_color_primitives::{convert_image, ColorSpace, ImageFormat, PixelFormat};
// use libvpx::decoder::VP9Decoder;
use nativeshell::{
    codec::{MethodCall, MethodCallReply, Value},
    shell::{
        Context, EngineHandle, MethodCallHandler, MethodChannel, PixelBuffer, RunLoopSender,
        Texture,
    },
    util::Capsule,
};

use crate::vp9::Vp9Decoder;

pub struct FramePlayer {
    context: Context,
    decoder: Vp9Decoder,
    framebuffer: Vec<u8>,
    runloop: RunLoopSender,
    texture: Option<Texture<PixelBuffer>>,
}

impl FramePlayer {
    pub fn new(context: Context, run_loop: RunLoopSender) -> Self {
        let decoder = Vp9Decoder::new();
        let framebuffer = Vec::with_capacity(1024 * 1024);
        // let mut framebuffer = BytesMut::with_capacity(1024 * 1024);

        Self {
            context,
            decoder,
            framebuffer,
            runloop: run_loop,
            texture: None,
        }
    }

    pub fn register(self) -> MethodChannel {
        MethodChannel::new(self.context.clone(), "frameplayer_channel", self)
    }
}

impl MethodCallHandler for FramePlayer {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        reply: MethodCallReply<Value>,
        engine: EngineHandle,
    ) {
        match call.method.as_str() {
            "echo" => {
                reply.send_ok(call.args);
            }
            "init" => {
                let context_copy = self.context.clone();
                let texture = Texture::<PixelBuffer>::new(context_copy, engine).unwrap();
                let texture_id = texture.id();
                self.texture = Some(texture);

                reply.send_ok(Value::I64(texture_id));
            }
            "upload" => {
                let input = call.args;

                if let Value::U8List(data) = input {
                    self.decoder.decode(&data);

                    while let Some(frame) = self.decoder.get_frame() {
                        let plane0 = &frame.planes[0][..];
                        let plane1 = &frame.planes[1][..];
                        let plane2 = &frame.planes[2][..];

                        // dbg!(plane0.len());
                        // dbg!(plane1.len());
                        // dbg!(plane2.len());

                        let frame_size = frame.width * frame.height * 4;
                        self.framebuffer.resize(frame_size, 0);

                        {
                            let src = &[plane0, plane1, plane2];
                            let dst: &mut [&mut [u8]] = &mut [&mut self.framebuffer[..]];
                            convert(frame.width, frame.height, src, &frame.strides[..], dst);
                        }

                        {
                            // y_to_bgra(WIDTH, HEIGHT, &plane0[..], &mut self.framebuffer[..]);
                            // u_to_bgra(WIDTH, HEIGHT, plane1, &mut self.framebuffer[..]);
                        }

                        // {
                        //     let frame_size = plane0.len() * 4;
                        //     self.framebuffer.resize(frame_size, 0);
                        //     y_to_bgra_simple(&plane0[..], &mut self.framebuffer[..]);
                        // }

                        // let slice = &self.framebuffer[0..1000];
                        // dbg!(slice);
                        // exit(0);

                        // let slice = &self.framebuffer[0..10];
                        // dbg!(slice);

                        let payload = PixelBuffer {
                            // width: (plane0.len() / frame.height) as _,
                            width: frame.width as _,
                            height: frame.height as _,
                            data: self.framebuffer.clone(),
                        };

                        if let Some(texture) = &self.texture {
                            texture.update(payload);
                        } else {
                            println!("texture not initlized!!!");
                        }
                    }

                    reply.send_ok(Value::Bool(true));
                } else {
                    reply.send_error("-100", Some("bad input"), input);
                }
            }
            "texture" => {
                let context_copy = self.context.clone();
                let texture = Texture::<PixelBuffer>::new(context_copy, engine).unwrap();
                let texture_id = texture.id();
                self.texture = Some(texture);
                reply.send_ok(Value::I64(texture_id));

                // let runloop = self.runloop.clone();
                // let texture = Texture::<PixelBuffer>::new(self.context.clone(), engine).unwrap();
                // let texture = Capsule::new_with_sender(texture, runloop);
                // let texture = Arc::new(Mutex::new(texture));

                // let runloop = self.runloop.clone();
                // thread::spawn(move || {
                //     async fn async_main() {
                //         const WIDTH: usize = 668;
                //         const HEIGHT: usize = 678;

                //         let mut buf: Vec<u8> = vec![0; WIDTH * HEIGHT * 4];
                //         let dst: &mut [&mut [u8]] = &mut [&mut buf[..]];

                //         loop {
                //             let payload = PixelBuffer {
                //                 width: 1,
                //                 height: 1,
                //                 data: vec![],
                //             };

                //             let texture = texture.clone();
                //             runloop.send(move || {
                //                 let texture = texture.lock().unwrap();
                //                 texture.get_ref().unwrap().update(payload);
                //             });
                //         }
                //     }

                //     System::new().block_on(async_main());

                // });
            }
            "update" => {
                // let im = image::open(&Path::new("./test.jpeg")).unwrap();
                // let im = im.resize(640, 1280, FilterType::Nearest);

                // let im = im.into_rgba8();

                // dbg!(im.width());
                // dbg!(im.height());

                // let payload = PixelBuffer {
                //     width: im.width() as i32,
                //     height: im.height() as i32,
                //     data: im.into_raw(),
                // };

                // if let Some(texture) = &self.texture {
                //     texture.update(payload);
                // }

                // reply.send_ok(Value::Null);
            }
            _ => {
                println!("call: {:?}", &call.args);
                reply.send_ok(Value::Null);
            }
        }
    }

    // optionally you can get notifications when an engine gets destroyed, which
    // might be useful for clean-up
    fn on_engine_destroyed(&mut self, _engine: EngineHandle) {}
}

fn convert(
    width: usize,
    height: usize,
    src: &[&[u8]],
    src_strides: &[usize],
    dst: &mut [&mut [u8]],
) {
    let src_format = ImageFormat {
        pixel_format: PixelFormat::I420,
        color_space: ColorSpace::Bt601,
        num_planes: 3,
    };

    let dst_format = ImageFormat {
        pixel_format: PixelFormat::Bgra,
        color_space: ColorSpace::Lrgb,
        num_planes: 1,
    };

    // let src_strides0 = src[0].len() / height - width;
    // let src_strides1 = src[1].len() / height * 4 - width;
    // let src_strides2 = src[2].len() / height * 4 - width;
    // let src_strides = [src_strides0, src_strides1, src_strides2];

    convert_image(
        width as u32,
        height as u32,
        &src_format,
        Some(src_strides),
        src,
        &dst_format,
        Some(&[0]),
        dst,
    )
    .unwrap();
}

fn y_to_bgra(width: usize, height: usize, src: &[u8], dst: &mut [u8]) {
    let stride = src.len() / height;

    for y in 0..height {
        for x in 0..width {
            let index = y * stride + x;
            let pixel = src[index];

            let index = y * width * 4 + x * 4;
            dst[index + 0] = pixel;
            dst[index + 1] = pixel;
            dst[index + 2] = pixel;
            dst[index + 3] = 255;
        }
    }
}

fn y_to_bgra_simple(src: &[u8], dst: &mut [u8]) {
    for i in 0..src.len() {
        let pixel = src[i];
        dst[i * 4 + 0] = pixel;
        dst[i * 4 + 1] = pixel;
        dst[i * 4 + 2] = pixel;
        dst[i * 4 + 3] = 255;
    }
}

fn u_to_bgra(width: usize, height: usize, src: &[u8], dst: &mut [u8]) {
    let stride = src.len() / (height / 4);

    for y in 0..height {
        for x in 0..width {
            let index = y / 4 * stride + x / 4;
            let pixel = src[index];

            let index = (y * width + x) * 4;
            for i in 0..4 {
                dst[index + i] = pixel;
            }
        }
    }
}
