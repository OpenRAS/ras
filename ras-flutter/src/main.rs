mod player_264;
mod player_vp9;
mod vp9;

use nativeshell::{
    codec::Value,
    shell::{exec_bundle, register_observatory_listener, Context, ContextOptions, EngineHandle},
};
use player_264::FramePlayer264;
use player_vp9::FramePlayerVp9;

nativeshell::include_flutter_plugins!();

fn main() {
    dcv_color_primitives::initialize();

    exec_bundle();
    register_observatory_listener("app_template".into());

    env_logger::builder().format_timestamp(None).init();

    let context = Context::new(ContextOptions {
        app_namespace: "AppTemplate".into(),
        flutter_plugins: flutter_get_plugins(),
        ..Default::default()
    });

    let context = context.unwrap();

    let player_vp9 = FramePlayerVp9::new(context.weak(), context.run_loop.borrow().new_sender());
    let _player_vp9_channel = player_vp9.register();

    let player_264 = FramePlayer264::new(context.weak(), context.run_loop.borrow().new_sender());
    let _player_264_channel = player_264.register();

    context
        .window_manager
        .borrow_mut()
        .create_window(Value::Null, None)
        .unwrap();

    let context_copy = context.weak().clone();
    context
        .run_loop
        .borrow()
        .schedule_now(move || {
            let _a = context_copy.clone();
        })
        .detach();

    context.run_loop.borrow().run();
}
