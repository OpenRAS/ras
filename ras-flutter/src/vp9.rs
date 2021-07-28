use std::{
    mem::MaybeUninit,
    ptr::{self, null},
};

use vpx_sys as vpx;

pub struct Vp9Decoder {
    ctx: vpx::vpx_codec_ctx,
    iter: vpx::vpx_codec_iter_t,
}

impl Vp9Decoder {
    pub fn new() -> Vp9Decoder {
        let mut ctx = MaybeUninit::uninit();
        let cfg = MaybeUninit::zeroed();

        let ret = unsafe {
            vpx::vpx_codec_dec_init_ver(
                ctx.as_mut_ptr(),
                vpx::vpx_codec_vp9_dx(),
                cfg.as_ptr(),
                0,
                vpx::VPX_DECODER_ABI_VERSION as i32,
            )
        };

        if ret != vpx::VPX_CODEC_OK {
            panic!("vp9 init failed");
        }

        let ctx = unsafe { ctx.assume_init() };
        let iter = ptr::null();
        Vp9Decoder { ctx, iter }
    }

    pub fn decode(&mut self, frame: &[u8]) {
        let ret = unsafe {
            vpx::vpx_codec_decode(
                &mut self.ctx,
                frame.as_ptr(),
                frame.len() as u32,
                ptr::null_mut(),
                0,
            )
        };

        if ret != vpx::VPX_CODEC_OK {
            panic!("vp9 init failed");
        }
    }

    pub fn flush(&mut self) {
        let ret =
            unsafe { vpx::vpx_codec_decode(&mut self.ctx, ptr::null(), 0, ptr::null_mut(), 0) };

        if ret != vpx::VPX_CODEC_OK {
            panic!("vp9 init failed");
        }
    }

    pub fn get_frame(&mut self) -> Option<Vp9Frame> {
        let image = unsafe { vpx::vpx_codec_get_frame(&mut self.ctx, &mut self.iter) };

        if image.is_null() {
            return None;
        }

        let image = unsafe { *image };
        let stride = image.stride;

        let planes = image.planes;
        let planes = unsafe {
            &[
                std::slice::from_raw_parts(planes[0], (stride[0] * image.d_h as i32) as usize).to_vec(),
                std::slice::from_raw_parts(planes[1], (stride[1] * image.d_h as i32) as usize / 2).to_vec(),
                std::slice::from_raw_parts(planes[2], (stride[2] * image.d_h as i32) as usize / 2).to_vec(),
            ]
        };

        // let planes = image
        //     .planes
        //     .iter()
        //     .zip(stride)
        //     .map(|(plane, stride)| unsafe {
        //         std::slice::from_raw_parts(*plane as *const u8, stride * image.d_h as usize)
        //     });

        // let planes: Vec<_> = planes.collect();
        let stride: Vec<usize> = stride.iter().map(|s| *s as usize).collect();

        let frame = Vp9Frame {
            width: image.d_w as _,
            height: image.d_h as _,
            planes: planes.to_vec(),
            strides: stride.to_vec(),
        };

        Some(frame)
    }
}

pub struct Vp9Frame {
    pub width: usize,
    pub height: usize,
    pub planes: Vec<Vec<u8>>,
    pub strides: Vec<usize>,
}
