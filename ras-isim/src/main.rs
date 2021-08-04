use std::{thread::sleep, time::Duration};

use isim::{ISim, Key, char_to_keycode};

fn main() {
    dbg!(char_to_keycode("=".to_string()));
    dbg!(char_to_keycode("+".to_string()));
}