use openh264_sys::*;
use std::os::raw::{c_int, c_void};
use std::ptr::{null, null_mut};
use std::slice::from_raw_parts;

#[derive(Debug)]
pub enum Openh264Error {
    FailedCall(String),
    BadPtr(String),
}

impl std::fmt::Display for Openh264Error {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::result::Result<(), std::fmt::Error> {
        write!(f, "{:?}", self)
    }
}

impl std::error::Error for Openh264Error {}

pub type Openh264Result<T> = std::result::Result<T, Openh264Error>;

macro_rules! call_264 {
    ($x:expr) => {{
        let result = unsafe { $x }; // original expression
        // let result_int = unsafe { std::mem::transmute::<_, i32>(result) };
        if result != 0 {
            return Err(Openh264Error::FailedCall(format!(
                "errcode={} {}:{}:{}:{}",
                result,
                module_path!(),
                file!(),
                line!(),
                column!()
            ))
            .into());
        }
        result
    }};
}

#[derive(Clone, Copy, Debug)]
pub struct Openh264Config {
    /// The width (in pixels).
    pub width: i32,
    /// The height (in pixels).
    pub height: i32,
    /// The target bitrate (in bits per second).
    pub bitrate: i32,
    /// The target fps.
    pub fps: f32,
}

pub struct Openh264Encoder {
    config: Openh264Config,
    encoder: *mut *const ISVCEncoderVtbl,
}

impl Openh264Encoder {
    pub fn new(config: Openh264Config) -> Openh264Result<Openh264Encoder> {
        let mut encoder = null_mut();
        call_264!(WelsCreateSVCEncoder(&mut encoder));

        let mut param = SEncParamExt::default();
        call_264!((**encoder).GetDefaultParams.unwrap()(encoder, &mut param));

        param.iUsageType = CAMERA_VIDEO_REAL_TIME;
        param.fMaxFrameRate = config.fps;
        param.iMaxBitrate = UNSPECIFIED_BIT_RATE as i32;
        param.iSpatialLayerNum = 1;
        param.sSpatialLayers[0].uiProfileIdc = PRO_BASELINE;
        param.sSpatialLayers[0].iVideoWidth = config.width;
        param.sSpatialLayers[0].iVideoHeight = config.height;
        param.sSpatialLayers[0].fFrameRate = config.fps;
        param.sSpatialLayers[0].iSpatialBitrate = config.bitrate;
        param.sSpatialLayers[0].iMaxSpatialBitrate = UNSPECIFIED_BIT_RATE as i32;
        param.sSpatialLayers[0].sSliceArgument.uiSliceMode = SM_FIXEDSLCNUM_SLICE;
        param.sSpatialLayers[0].sSliceArgument.uiSliceNum = 4;
        param.iPicWidth = config.width;
        param.iPicHeight = config.height;
        param.iTargetBitrate = config.bitrate;

        call_264!((**encoder).InitializeExt.unwrap()(encoder, &mut param));

        let mut video_format = videoFormatI420 as c_int;
        call_264!((**encoder).SetOption.unwrap()(
            encoder,
            ENCODER_OPTION_DATAFORMAT,
            &mut video_format as *mut c_int as *mut c_void,
        ));

        let mut rc_frame_skip = 0 as c_int;
        call_264!((**encoder).SetOption.unwrap()(
            encoder,
            ENCODER_OPTION_RC_FRAME_SKIP,
            &mut rc_frame_skip as *mut c_int as *mut c_void,
        ));

        Ok(Openh264Encoder { config, encoder })
    }

    pub fn encode(&mut self, y: &mut [u8], u: &mut [u8], v: &mut [u8]) -> Openh264Result<Vec<u8>> {
        assert!(y.len() >= (self.config.width * self.config.height) as usize);
        assert!(u.len() >= (self.config.width * self.config.height) as usize / 4);
        assert!(v.len() >= (self.config.width * self.config.height) as usize / 4);

        let mut picture = SSourcePicture::default();
        picture.iPicWidth = self.config.width as i32;
        picture.iPicHeight = self.config.height as i32;
        picture.iColorFormat = videoFormatI420 as i32;
        picture.iStride[0] = (y.len() / self.config.height as usize) as _;
        picture.iStride[1] = (u.len() / (self.config.height / 2) as usize) as _;
        picture.iStride[2] = (v.len() / (self.config.height / 2) as usize) as _;
        picture.pData[0] = y.as_mut_ptr();
        picture.pData[1] = u.as_mut_ptr();
        picture.pData[2] = v.as_mut_ptr();

        let mut frame_info = SFrameBSInfo::default();
        call_264!((**self.encoder).EncodeFrame.unwrap()(
            self.encoder,
            &mut picture,
            &mut frame_info
        ));

        let mut output = Vec::new();

        for layer in 0..frame_info.iLayerNum {
            let layer = frame_info.sLayerInfo[layer as usize];

            let mut layer_size = 0;
            for nal in 0..layer.iNalCount {
                let nal_size = unsafe { *(layer.pNalLengthInByte.offset(nal as _)) };
                layer_size += nal_size;
            }

            let layer_data = unsafe { from_raw_parts(layer.pBsBuf, layer_size as _) };
            output.extend_from_slice(layer_data);
        }

        Ok(output)
    }
}

impl Drop for Openh264Encoder {
    fn drop(&mut self) {
        unsafe {
            WelsDestroySVCEncoder(self.encoder);
        }
    }
}

pub struct Openh264Decoder {
    decoder: *mut *const ISVCDecoderVtbl,
}

impl Openh264Decoder {
    pub fn new() -> Openh264Result<Openh264Decoder> {
        let mut decoder = null_mut();
        call_264!(WelsCreateDecoder(&mut decoder));
        assert!(!decoder.is_null());

        let param = SDecodingParam::default();
        call_264!((**decoder).Initialize.unwrap()(decoder, &param));

        Ok(Openh264Decoder { decoder })
    }

    pub fn decode(&mut self, data: &[u8]) -> Openh264Result<Option<Openh264Frame>> {
        let mut buf_info = SBufferInfo::default();
        let mut output = [null_mut() as *mut u8; 3];

        call_264!((**self.decoder).DecodeFrameNoDelay.unwrap()(
            self.decoder,
            data.as_ptr(),
            data.len() as _,
            output.as_mut_ptr(),
            &mut buf_info,
        ));

        if buf_info.iBufferStatus == 0 {
            return Ok(None);
        }

        let info = unsafe { buf_info.UsrData.sSystemBuffer };
        dbg!(info);

        let width = info.iWidth;
        let height = info.iHeight;
        let y_stride = info.iStride[0];
        let u_stride = info.iStride[1];
        let v_stride = info.iStride[1];
        let y = unsafe { from_raw_parts(output[0], (y_stride * info.iHeight) as _) };
        let u = unsafe { from_raw_parts(output[1], (u_stride * info.iHeight / 2) as _) };
        let v = unsafe { from_raw_parts(output[2], (v_stride * info.iHeight / 2) as _) };

        Ok(Some(Openh264Frame {
            width,
            height,
            y_stride,
            u_stride,
            v_stride,
            y: y.to_vec(),
            u: u.to_vec(),
            v: v.to_vec(),
        }))
    }
}

impl Drop for Openh264Decoder {
    fn drop(&mut self) {
        unsafe {
            (**self.decoder).Uninitialize.unwrap()(self.decoder);
            WelsDestroyDecoder(self.decoder);
        }
    }
}

#[derive(Debug)]
pub struct Openh264Frame {
    pub width: i32,
    pub height: i32,
    pub y: Vec<u8>,
    pub u: Vec<u8>,
    pub v: Vec<u8>,
    pub y_stride: i32,
    pub u_stride: i32,
    pub v_stride: i32,
}
