extern crate prost_build;

fn main() {
    prost_build::compile_protos(&["../ras-proto/message.proto"], &["../ras-proto/"]).unwrap();
}
