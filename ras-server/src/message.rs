use serde::{Deserialize, Serialize};
use serde_json::{Result, Value};

#[derive(Serialize, Deserialize, Debug)]
#[serde(tag = "t")]
pub enum RasMessage {
    #[serde(rename = "vc")]
    VideoCodec {
        #[serde(rename = "c")]
        name: String,
    },

    #[serde(rename = "vf")]
    VideoFrame {
        #[serde(rename = "w")]
        width: usize,
        #[serde(rename = "h")]
        height: usize,
        #[serde(rename = "n")]
        chunks: usize,
    },

    #[serde(rename = "mm")]
    MouseMove { x: i32, y: i32 },

    #[serde(rename = "mmr")]
    MouseMoveRelative { x: i32, y: i32 },

    #[serde(rename = "mu")]
    MouseUp {
        #[serde(rename = "b")]
        button: String,
    },

    #[serde(rename = "md")]
    MouseDown {
        #[serde(rename = "b")]
        button: String,
    },

    #[serde(rename = "mc")]
    MouseClick {
        #[serde(rename = "b")]
        button: String,
    },

    #[serde(rename = "ms")]
    MouseScroll {
        #[serde(rename = "x")]
        offset_x: i32,
        #[serde(rename = "y")]
        offset_y: i32,
    },

    #[serde(rename = "kcu")]
    KeyCharUp {
        #[serde(rename = "c")]
        char: u32,
    },

    #[serde(rename = "kcd")]
    KeyCharDown {
        #[serde(rename = "c")]
        char: u32,
    },
}

impl RasMessage {
    pub fn from_str<'a>(s: &'a str) -> RasMessage {
        serde_json::from_str(s).unwrap()
    }

    pub fn encode(&self) -> String {
        serde_json::to_string(self).unwrap()
    }
}

impl Into<String> for RasMessage {
    fn into(self) -> String {
        self.encode()
    }
}
