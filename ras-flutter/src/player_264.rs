

// use libvpx::decoder::VP9Decoder;
use nativeshell::{
    codec::{MethodCall, MethodCallReply, Value},
    shell::{
        Context, EngineHandle, MethodCallHandler, MethodChannel, PixelBuffer, RunLoopSender,
        Texture,
    },
};

pub struct FramePlayer264 {
    context: Context,
    decoder: codec::Openh264Decoder,
    framebuffer: Vec<u8>,
    runloop: RunLoopSender,
    texture: Option<Texture<PixelBuffer>>,
}

impl FramePlayer264 {
    pub fn new(context: Context, run_loop: RunLoopSender) -> Self {
        let decoder = codec::Openh264Decoder::new().unwrap();
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
        MethodChannel::new(self.context.clone(), "frameplayer_264_channel", self)
    }
}

impl MethodCallHandler for FramePlayer264 {
    fn on_method_call(
        &mut self,
        call: MethodCall<Value>,
        reply: MethodCallReply<Value>,
        engine: EngineHandle,
    ) {
        match call.method.as_str() {
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
                    let frame = self.decoder.decode_to_argb(&data[..]).unwrap();

                    if let Some(frame) = frame {
                        let payload = PixelBuffer {
                            // width: (plane0.len() / frame.height) as _,
                            width: frame.width as _,
                            height: frame.height as _,
                            data: frame.data,
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
            }

            _ => {
                println!("bad call: {:?}", &call.args);
                reply.send_ok(Value::Null);
            }
        }
    }

    // optionally you can get notifications when an engine gets destroyed, which
    // might be useful for clean-up
    fn on_engine_destroyed(&mut self, _engine: EngineHandle) {}
}
