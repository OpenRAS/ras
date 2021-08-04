mod ffi;
mod vk;

use cocoa::{appkit::NSEvent, base::nil};
use core_graphics::{
    display::{CGDisplayPixelsHigh, CGDisplayPixelsWide, CGMainDisplayID, CGPoint},
    event::{CGEvent, CGEventTapLocation, CGEventType, CGKeyCode, CGMouseButton},
    event_source::{CGEventSource, CGEventSourceStateID},
};

use crate::key::Key;

use self::ffi::{
    kCFAllocatorDefault, kCFStringEncodingUTF8, kTISPropertyUnicodeKeyLayoutData,
    kUCKeyActionDisplay, kUCKeyTranslateNoDeadKeysBit, CFDataGetBytePtr,
    CFStringCreateWithCharacters, CFStringGetCString, CFStringGetLength, CFStringRef, LMGetKbdType,
    TISCopyCurrentKeyboardInputSource, TISGetInputSourceProperty, UCKeyTranslate, UInt32,
    UniCharCount, TRUE,
};

#[derive(Clone, Copy)]
pub enum MouseButton {
    Left,
    Middle,
    Right,
    ScrollUp,
    ScrollDown,
    ScrollLeft,
    ScrollRight,
}

#[derive(Debug)]
#[allow(dead_code)]
enum PressedMouseButton {
    None,
    Left,
    Right,
    Other,
}

impl PressedMouseButton {
    pub fn current() -> PressedMouseButton {
        let button_mask = unsafe { NSEvent::pressedMouseButtons(nil) };
        match button_mask {
            0 => Self::None,
            1 => Self::Left,
            2 => Self::Right,
            _ => Self::None,
        }
    }
}

pub struct ISim {
    event_source: CGEventSource,
}

unsafe impl Send for ISim {}

impl ISim {
    pub fn new() -> Self {
        Self {
            event_source: CGEventSource::new(CGEventSourceStateID::CombinedSessionState).unwrap(),
        }
    }

    pub fn mouse_move(&mut self, x: i32, y: i32) {
        let mouse_type = match PressedMouseButton::current() {
            PressedMouseButton::None => CGEventType::MouseMoved,
            PressedMouseButton::Left => CGEventType::LeftMouseDragged,
            PressedMouseButton::Right => CGEventType::RightMouseDragged,
            PressedMouseButton::Other => CGEventType::OtherMouseDragged,
        };

        let mouse_cursor_position = CGPoint::new(x as _, y as _);
        let mouse_event = CGEvent::new_mouse_event(
            self.event_source.clone(),
            mouse_type,
            mouse_cursor_position,
            CGMouseButton::Left,
        )
        .unwrap();

        mouse_event.post(CGEventTapLocation::HID);
    }

    pub fn mouse_down(&mut self, button: MouseButton) {
        let (x, y) = mouse_location();
        self.mouse_down_at(x, y, button);
    }

    pub fn mouse_down_at(&mut self, x: i32, y: i32, button: MouseButton) {
        let (mouse_button, mouse_type) = match button {
            MouseButton::Left => (CGMouseButton::Left, CGEventType::LeftMouseDown),
            MouseButton::Middle => (CGMouseButton::Center, CGEventType::OtherMouseDown),
            MouseButton::Right => (CGMouseButton::Right, CGEventType::RightMouseDown),
            _ => unimplemented!(),
        };
        let mouse_cursor_position = CGPoint::new(x as _, y as _);
        CGEvent::new_mouse_event(
            self.event_source.clone(),
            mouse_type,
            mouse_cursor_position,
            mouse_button,
        )
        .unwrap()
        .post(CGEventTapLocation::HID);
    }

    pub fn mouse_up(&mut self, button: MouseButton) {
        let (x, y) = mouse_location();
        self.mouse_up_at(x, y, button);
    }

    pub fn mouse_up_at(&mut self, x: i32, y: i32, button: MouseButton) {
        let (mouse_button, mouse_type) = match button {
            MouseButton::Left => (CGMouseButton::Left, CGEventType::LeftMouseUp),
            MouseButton::Middle => (CGMouseButton::Center, CGEventType::OtherMouseUp),
            MouseButton::Right => (CGMouseButton::Right, CGEventType::RightMouseUp),
            _ => unimplemented!(),
        };
        let mouse_cursor_position = CGPoint::new(x as _, y as _);
        CGEvent::new_mouse_event(
            self.event_source.clone(),
            mouse_type,
            mouse_cursor_position,
            mouse_button,
        )
        .unwrap()
        .post(CGEventTapLocation::HID);
    }

    pub fn mouse_scroll(&mut self, dx: i32, dy: i32) {
        CGEvent::new_scroll_event(
            self.event_source.clone(),
            0, // pixels
            2,
            -dy,
            -dx,
            0,
        )
        .unwrap()
        .post(CGEventTapLocation::HID);
    }

    pub fn key_up(&mut self, key: Key) {
        CGEvent::new_keyboard_event(self.event_source.clone(), key_to_keycode(key), false)
            .unwrap()
            .post(CGEventTapLocation::HID);
    }

    pub fn key_down(&mut self, key: Key) {
        CGEvent::new_keyboard_event(self.event_source.clone(), key_to_keycode(key), true)
            .unwrap()
            .post(CGEventTapLocation::HID);
    }
}

fn display_size() -> (usize, usize) {
    let display_id = unsafe { CGMainDisplayID() };
    let display_width = unsafe { CGDisplayPixelsWide(display_id) };
    let display_height = unsafe { CGDisplayPixelsHigh(display_id) };
    (display_width, display_height)
}

fn mouse_location() -> (i32, i32) {
    let (_, display_height) = display_size();
    let location = unsafe { NSEvent::mouseLocation(nil) };
    (location.x as _, (display_height - location.y as usize) as _)
}

fn key_to_keycode(key: Key) -> CGKeyCode {
    match key {
        Key::Alt => vk::Option,
        Key::Backspace => vk::Delete,
        Key::CapsLock => vk::CapsLock,
        Key::Control => vk::Control,
        Key::Delete => vk::ForwardDelete,
        Key::DownArrow => vk::DownArrow,
        Key::End => vk::End,
        Key::Escape => vk::Escape,
        Key::F1 => vk::F1,
        Key::F2 => vk::F2,
        Key::F3 => vk::F3,
        Key::F4 => vk::F4,
        Key::F5 => vk::F5,
        Key::F6 => vk::F6,
        Key::F7 => vk::F7,
        Key::F8 => vk::F8,
        Key::F9 => vk::F9,
        Key::F10 => vk::F10,
        Key::F11 => vk::F11,
        Key::F12 => vk::F12,
        Key::Home => vk::Home,
        Key::LeftArrow => vk::LeftArrow,
        Key::Option => vk::Option,
        Key::PageDown => vk::PageDown,
        Key::PageUp => vk::PageUp,
        Key::Return => vk::Return,
        Key::RightArrow => vk::RightArrow,
        Key::Shift => vk::Shift,
        Key::Space => vk::Space,
        Key::Tab => vk::Tab,
        Key::UpArrow => vk::UpArrow,
        // Key::Numpad0 => vk::ANSI_Keypad0,
        // Key::Numpad1 => vk::ANSI_Keypad1,
        // Key::Numpad2 => vk::ANSI_Keypad2,
        // Key::Numpad3 => vk::ANSI_Keypad3,
        // Key::Numpad4 => vk::ANSI_Keypad4,
        // Key::Numpad5 => vk::ANSI_Keypad5,
        // Key::Numpad6 => vk::ANSI_Keypad6,
        // Key::Numpad7 => vk::ANSI_Keypad7,
        // Key::Numpad8 => vk::ANSI_Keypad8,
        // Key::Numpad9 => vk::ANSI_Keypad9,
        // Key::Mute => vk::Mute,
        // Key::VolumeDown => vk::VolumeUp,
        // Key::VolumeUp => vk::VolumeDown,
        // Key::Help => vk::Help,
        // Key::Snapshot => vk::F13,
        // Key::Clear => vk::ANSI_KeypadClear,
        // Key::Decimal => vk::ANSI_KeypadDecimal,
        // Key::Multiply => vk::ANSI_KeypadMultiply,
        // Key::Add => vk::ANSI_KeypadPlus,
        // Key::Divide => vk::ANSI_KeypadDivide,
        // Key::NumpadEnter => vk::ANSI_KeypadEnter,
        // Key::Subtract => vk::ANSI_KeypadMinus,
        // Key::Equals => vk::ANSI_KeypadEquals,
        // Key::NumLock => vk::ANSI_KeypadClear,
        // Key::RWin => vk::RIGHT_COMMAND,
        // Key::RightShift => vk::RightShift,
        // Key::RightControl => vk::RightControl,
        // Key::RightAlt => vk::RightOption,
        Key::Meta => vk::Command,
        Key::Char(c) => char_to_keycode(c.to_string()),
    }
}

pub fn char_to_keycode(string: String) -> CGKeyCode {
    let mut pressed_keycode = 0;

    // loop through every keycode (0 - 127)
    for keycode in 0..128 {
        // no modifier
        if let Some(key_string) = keycode_to_string(keycode, 0x100) {
            // println!("{:?}", string);
            if string == key_string {
                pressed_keycode = keycode;
            }
        }

        // shift modifier
        if let Some(key_string) = keycode_to_string(keycode, 0x20102) {
            // println!("{:?}", string);
            if string == key_string {
                pressed_keycode = keycode;
            }
        }

        // alt modifier
        // if let Some(string) = self.keycode_to_string(keycode, 0x80120) {
        //     println!("{:?}", string);
        // }
        // alt + shift modifier
        // if let Some(string) = self.keycode_to_string(keycode, 0xa0122) {
        //     println!("{:?}", string);
        // }
    }

    pressed_keycode
}

fn keycode_to_string(keycode: u16, modifier: u32) -> Option<String> {
    let cf_string = create_string_for_key(keycode, modifier);
    let buffer_size = unsafe { CFStringGetLength(cf_string) + 1 };
    let mut buffer: i8 = std::i8::MAX;
    let success =
        unsafe { CFStringGetCString(cf_string, &mut buffer, buffer_size, kCFStringEncodingUTF8) };
    if success == TRUE as u8 {
        let rust_string = String::from_utf8(vec![buffer as u8]).unwrap();
        return Some(rust_string);
    }

    None
}

fn create_string_for_key(keycode: u16, modifier: u32) -> CFStringRef {
    let current_keyboard = unsafe { TISCopyCurrentKeyboardInputSource() };
    let layout_data =
        unsafe { TISGetInputSourceProperty(current_keyboard, kTISPropertyUnicodeKeyLayoutData) };
    let keyboard_layout = unsafe { CFDataGetBytePtr(layout_data) };

    let mut keys_down: UInt32 = 0;
    // let mut chars: *mut c_void;//[UniChar; 4];
    let mut chars: u16 = 0;
    let mut real_length: UniCharCount = 0;
    unsafe {
        UCKeyTranslate(
            keyboard_layout,
            keycode,
            kUCKeyActionDisplay as u16,
            modifier,
            LMGetKbdType() as u32,
            kUCKeyTranslateNoDeadKeysBit as u32,
            &mut keys_down,
            8, // sizeof(chars) / sizeof(chars[0]),
            &mut real_length,
            &mut chars,
        );
    }

    unsafe { CFStringCreateWithCharacters(kCFAllocatorDefault, &chars, 1) }
}
