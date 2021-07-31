# NativeShell Application Template

This is a template for minimal NativeShell application.

## Prerequisites

1. [Install Rust](https://www.rust-lang.org/tools/install)
2. [Install Flutter](https://flutter.dev/docs/get-started/install)
3. [Enable Flutter desktop support](https://flutter.dev/desktop#set-up)
4. Switch to Fluttter Master (`flutter channel master; flutter upgrade`)

## Getting Started

Launch it with `cargo run`.

To debug or hot reload dart code, start the `Flutter: Attach to Process` configuration once the application runs.

For more information go to [nativeshell.dev](https://nativeshell.dev).


## Build

```
git submodule update --remote --recursive
```

```
protoc -I=ras-proto --dart_out=ras-flutter/lib/message ./ras-proto/message.proto
```
## References

- [THE GIT SUBMODULE CHEAT SHEET](https://www.devroom.io/2020/03/09/the-git-submodule-cheat-sheet/)