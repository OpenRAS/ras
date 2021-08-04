use std::{ffi::c_void, os::raw::{c_char, c_int, c_uchar, c_uint, c_ulong, c_ushort}};

use core_graphics::display::CFIndex;

pub type CFDataRef = *const c_void;


#[repr(C)]
pub struct __TISInputSource;
pub type TISInputSourceRef = *const __TISInputSource;

#[repr(C)]
#[derive(Debug, Copy, Clone)]
pub struct __CFString([u8; 0]);
pub type CFStringRef = *const __CFString;
pub type Boolean = c_uchar;
pub type UInt8 = c_uchar;
pub type SInt32 = c_int;
pub type UInt16 = c_ushort;
pub type UInt32 = c_uint;
pub type UniChar = UInt16;
pub type UniCharCount = c_ulong;

pub type OptionBits = UInt32;
pub type OSStatus = SInt32;

pub type CFStringEncoding = UInt32;

pub const TRUE: c_uint = 1;

#[allow(non_upper_case_globals)]
pub const kUCKeyActionDisplay: _bindgen_ty_702 = _bindgen_ty_702::kUCKeyActionDisplay;

#[allow(non_camel_case_types)]
#[repr(u32)]
#[derive(Debug, Copy, Clone, PartialEq, Eq, Hash)]
pub enum _bindgen_ty_702 {
    // kUCKeyActionDown = 0,
    // kUCKeyActionUp = 1,
    // kUCKeyActionAutoKey = 2,
    kUCKeyActionDisplay = 3,
}

#[allow(non_snake_case)]
#[repr(C)]
#[derive(Debug, Clone, Copy)]
pub struct UCKeyboardTypeHeader {
    pub keyboardTypeFirst: UInt32,
    pub keyboardTypeLast: UInt32,
    pub keyModifiersToTableNumOffset: UInt32,
    pub keyToCharTableIndexOffset: UInt32,
    pub keyStateRecordsIndexOffset: UInt32,
    pub keyStateTerminatorsOffset: UInt32,
    pub keySequenceDataIndexOffset: UInt32,
}

#[allow(non_snake_case)]
#[repr(C)]
#[derive(Debug, Clone, Copy)]
pub struct UCKeyboardLayout {
    pub keyLayoutHeaderFormat: UInt16,
    pub keyLayoutDataVersion: UInt16,
    pub keyLayoutFeatureInfoOffset: UInt32,
    pub keyboardTypeCount: UInt32,
    pub keyboardTypeList: [UCKeyboardTypeHeader; 1usize],
}

#[allow(non_upper_case_globals)]
pub const kUCKeyTranslateNoDeadKeysBit: _bindgen_ty_703 =
    _bindgen_ty_703::kUCKeyTranslateNoDeadKeysBit;

#[allow(non_camel_case_types)]
#[repr(u32)]
#[derive(Debug, Copy, Clone, PartialEq, Eq, Hash)]
pub enum _bindgen_ty_703 {
    kUCKeyTranslateNoDeadKeysBit = 0,
}

#[repr(C)]
#[derive(Debug, Copy, Clone)]
pub struct __CFAllocator([u8; 0]);
pub type CFAllocatorRef = *const __CFAllocator;

// #[repr(u32)]
// #[derive(Debug, Copy, Clone, PartialEq, Eq, Hash)]
// pub enum _bindgen_ty_15 {
//     kCFStringEncodingMacRoman = 0,
//     kCFStringEncodingWindowsLatin1 = 1280,
//     kCFStringEncodingISOLatin1 = 513,
//     kCFStringEncodingNextStepLatin = 2817,
//     kCFStringEncodingASCII = 1536,
//     kCFStringEncodingUnicode = 256,
//     kCFStringEncodingUTF8 = 134217984,
//     kCFStringEncodingNonLossyASCII = 3071,
//     kCFStringEncodingUTF16BE = 268435712,
//     kCFStringEncodingUTF16LE = 335544576,
//     kCFStringEncodingUTF32 = 201326848,
//     kCFStringEncodingUTF32BE = 402653440,
//     kCFStringEncodingUTF32LE = 469762304,
// }

#[allow(non_upper_case_globals)]
pub const kCFStringEncodingUTF8: u32 = 134_217_984;

#[allow(improper_ctypes)]
#[link(name = "Carbon", kind = "framework")]
extern "C" {
    pub fn TISCopyCurrentKeyboardInputSource() -> TISInputSourceRef;

    //     extern void *
    // TISGetInputSourceProperty(
    //   TISInputSourceRef   inputSource,
    //   CFStringRef         propertyKey)

    #[allow(non_upper_case_globals)]
    #[link_name = "kTISPropertyUnicodeKeyLayoutData"]
    pub static kTISPropertyUnicodeKeyLayoutData: CFStringRef;

    #[allow(non_snake_case)]
    pub fn TISGetInputSourceProperty(
        inputSource: TISInputSourceRef,
        propertyKey: CFStringRef,
    ) -> *mut c_void;

    #[allow(non_snake_case)]
    pub fn CFDataGetBytePtr(theData: CFDataRef) -> *const UInt8;

    #[allow(non_snake_case)]
    pub fn UCKeyTranslate(
        keyLayoutPtr: *const UInt8, //*const UCKeyboardLayout,
        virtualKeyCode: UInt16,
        keyAction: UInt16,
        modifierKeyState: UInt32,
        keyboardType: UInt32,
        keyTranslateOptions: OptionBits,
        deadKeyState: *mut UInt32,
        maxStringLength: UniCharCount,
        actualStringLength: *mut UniCharCount,
        unicodeString: *mut UniChar,
    ) -> OSStatus;

    pub fn LMGetKbdType() -> UInt8;

    #[allow(non_snake_case)]
    pub fn CFStringCreateWithCharacters(
        alloc: CFAllocatorRef,
        chars: *const UniChar,
        numChars: CFIndex,
    ) -> CFStringRef;

    #[allow(non_upper_case_globals)]
    #[link_name = "kCFAllocatorDefault"]
    pub static kCFAllocatorDefault: CFAllocatorRef;

    #[allow(non_snake_case)]
    pub fn CFStringGetLength(theString: CFStringRef) -> CFIndex;

    #[allow(non_snake_case)]
    pub fn CFStringGetCString(
        theString: CFStringRef,
        buffer: *mut c_char,
        bufferSize: CFIndex,
        encoding: CFStringEncoding,
    ) -> Boolean;
}