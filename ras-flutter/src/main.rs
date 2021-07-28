mod player;
mod vp9;

use nativeshell::{
    codec::Value,
    shell::{exec_bundle, register_observatory_listener, Context, ContextOptions, EngineHandle},
};

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

    let channels =
        player::FramePlayer::new(context.weak(), context.run_loop.borrow().new_sender());
    let _channel = channels.register();

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
