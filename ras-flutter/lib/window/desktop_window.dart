import 'dart:typed_data';

import 'package:app_template/message/message.pb.dart' as proto;
import 'package:app_template/vp9_player.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nativeshell/nativeshell.dart';
import 'package:web_socket_channel/io.dart';

class DesktopWindowState extends WindowState {
  DesktopWindowState(this.url);

  final String url;

  static DesktopWindowState? fromInitData(dynamic initData) {
    if (initData is Map && initData['class'] == 'desktopWindow') {
      final url = initData['url'] as String;
      return DesktopWindowState(url);
    }
    return null;
  }

  static dynamic toInitData(String url) => {
        'class': 'desktopWindow',
        'url': url,
      };

  @override
  WindowSizingMode get windowSizingMode =>
      WindowSizingMode.atLeastIntrinsicSize;

  @override
  Future<void> initializeWindow(Size contentSize) async {
    await window.setTitle('Desktop - $url');
    return await super.initializeWindow(contentSize);
  }

  @override
  Widget build(BuildContext context) {
    return DesktopWindow(
      url: Uri.parse(url),
    );
  }
}

class DesktopWindow extends StatefulWidget {
  const DesktopWindow({Key? key, required this.url}) : super(key: key);

  final Uri url;

  @override
  _DesktopWindowState createState() => _DesktopWindowState();
}

class _DesktopWindowState extends State<DesktopWindow> {
  late Vp9Player player;
  late DesktopConnection connection;

  @override
  void initState() {
    player = Vp9Player();
    player.init();

    final handler = DesktopMessageHandler(
      player: player,
      onSize: onSize,
    );

    connection = DesktopConnection(
      url: widget.url,
      onData: handler.onData,
    );

    super.initState();
  }

  Size? _remoteSize;

  void onSize(int width, int height) async {
    final size = Size(width.toDouble(), height.toDouble());
    if (_remoteSize != size) {
      _remoteSize = size;
      await WindowState.of(context).updateWindowSize(size);
    }
  }

  @override
  Widget build(BuildContext context) {
    // RawKeyboardListener
    return LayoutBuilder(builder: (context, contrains) {
      return Focus(
        autofocus: true,
        onKeyEvent: (focus, event) {
          if (event is KeyUpEvent) onKeyUp(event);
          if (event is KeyDownEvent) onKeyDown(event);
          return KeyEventResult.handled;
        },
        child: Listener(
          child: Vp9PlayerView(player: player),
          onPointerMove: (event) {
            onPointerMove(event.position, contrains.biggest);
          },
          onPointerHover: (event) {
            onPointerMove(event.position, contrains.biggest);
          },
          onPointerUp: (event) {
            onPointerUp(event.buttons);
          },
          onPointerDown: (event) {
            onPointerDown(event.buttons);
          },
          onPointerSignal: (event) {
            if (event is PointerScrollEvent) {
              onPointerScroll(event.scrollDelta);
            }
          },
        ),
      );
    });
  }

  Offset getRemoteOffset(Offset localOffset, Size localSize, Size remoteSize) {
    final x = localOffset.dx / localSize.width * remoteSize.width;
    final y = localOffset.dy / localSize.height * remoteSize.height;
    return Offset(x, y);
  }

  void onPointerMove(Offset localOffset, Size localSize) {
    final remoteSize = _remoteSize;
    if (remoteSize == null) {
      return;
    }

    final offset = getRemoteOffset(localOffset, localSize, remoteSize);

    final message = proto.Message.create()
      ..mouseMove = proto.MouseMove(
        x: offset.dx.round(),
        y: offset.dy.round(),
      );

    connection.sendMessage(message);
  }

  void onPointerUp(int buttonId) {
    final button = mapButtonType(buttonId);
    final message = proto.Message.create()
      ..mouseUp = proto.MouseUp(button: button);
    connection.sendMessage(message);
  }

  void onPointerDown(int buttonId) {
    final button = mapButtonType(buttonId);
    final message = proto.Message.create()
      ..mouseDown = proto.MouseDown(button: button);
    connection.sendMessage(message);
  }

  void onPointerScroll(Offset delta) {
    final message = proto.Message.create()
      ..mouseScroll = proto.MouseScroll(
        dx: (delta.dx / 2).round(),
        dy: (delta.dy / 2).round(),
      );
    connection.sendMessage(message);
  }

  void onKeyUp(KeyUpEvent event) {
    final key = mapKey(event.logicalKey);
    if (key != null) {
      print('key-up $key');
      final message = proto.Message.create()..keyUp = proto.KeyUp(key: key);
      connection.sendMessage(message);
      return;
    }

    final char = event.logicalKey.keyLabel;
    if (char.length == 1) {
      print('char-up $char');
      final message = proto.Message.create()
        ..keyUp = proto.KeyUp(char: char.codeUnitAt(0));
      connection.sendMessage(message);
    }
  }

  void onKeyDown(KeyDownEvent event) {
    final key = mapKey(event.logicalKey);
    if (key != null) {
      print('key-down $key');
      final message = proto.Message.create()..keyDown = proto.KeyDown(key: key);
      connection.sendMessage(message);
      return;
    }

    final char = event.logicalKey.keyLabel;
    if (char.length == 1) {
      print('char-down $char');
      final message = proto.Message.create()
        ..keyDown = proto.KeyDown(char: char.codeUnitAt(0));
      connection.sendMessage(message);
    }
  }
}

final keyMap = {
  LogicalKeyboardKey.alt: proto.Key.Alt,
  LogicalKeyboardKey.altLeft: proto.Key.Alt,
  LogicalKeyboardKey.altRight: proto.Key.Alt,
  LogicalKeyboardKey.backspace: proto.Key.Backspace,
  LogicalKeyboardKey.capsLock: proto.Key.CapsLock,
  LogicalKeyboardKey.control: proto.Key.Control,
  LogicalKeyboardKey.controlLeft: proto.Key.Control,
  LogicalKeyboardKey.controlRight: proto.Key.Control,
  LogicalKeyboardKey.delete: proto.Key.Delete,
  LogicalKeyboardKey.end: proto.Key.End,
  LogicalKeyboardKey.escape: proto.Key.Escape,
  LogicalKeyboardKey.f1: proto.Key.F1,
  LogicalKeyboardKey.f2: proto.Key.F2,
  LogicalKeyboardKey.f3: proto.Key.F3,
  LogicalKeyboardKey.f4: proto.Key.F4,
  LogicalKeyboardKey.f5: proto.Key.F5,
  LogicalKeyboardKey.f6: proto.Key.F6,
  LogicalKeyboardKey.f7: proto.Key.F7,
  LogicalKeyboardKey.f8: proto.Key.F8,
  LogicalKeyboardKey.f9: proto.Key.F9,
  LogicalKeyboardKey.f10: proto.Key.F10,
  LogicalKeyboardKey.f11: proto.Key.F11,
  LogicalKeyboardKey.f12: proto.Key.F12,
  LogicalKeyboardKey.home: proto.Key.Home,
  LogicalKeyboardKey.meta: proto.Key.Meta,
  LogicalKeyboardKey.metaLeft: proto.Key.Meta,
  LogicalKeyboardKey.metaRight: proto.Key.Meta,
  // LogicalKeyboardKey.alt: proto.Key.Option,
  LogicalKeyboardKey.pageDown: proto.Key.PageDown,
  LogicalKeyboardKey.pageUp: proto.Key.PageUp,
  LogicalKeyboardKey.enter: proto.Key.Return,
  LogicalKeyboardKey.shift: proto.Key.Shift,
  LogicalKeyboardKey.shiftLeft: proto.Key.Shift,
  LogicalKeyboardKey.shiftRight: proto.Key.Shift,
  LogicalKeyboardKey.space: proto.Key.Space,
  LogicalKeyboardKey.tab: proto.Key.Tab,
  LogicalKeyboardKey.arrowUp: proto.Key.UpArrow,
  LogicalKeyboardKey.arrowDown: proto.Key.DownArrow,
  LogicalKeyboardKey.arrowLeft: proto.Key.LeftArrow,
  LogicalKeyboardKey.arrowRight: proto.Key.RightArrow,
};

proto.Key? mapKey(LogicalKeyboardKey key) {
  return keyMap[key];
}

proto.MouseButton mapButtonType(int button) {
  switch (button) {
    case kPrimaryButton:
      return proto.MouseButton.LEFT;
    case kSecondaryButton:
      return proto.MouseButton.RIGHT;
    case kMiddleMouseButton:
      return proto.MouseButton.MIDDLE;
    default:
      return proto.MouseButton.LEFT;
  }
}

class DesktopMessageHandler {
  DesktopMessageHandler({
    required this.player,
    required this.onSize,
  });

  final Vp9Player player;
  final void Function(int, int) onSize;

  void onData(data) {
    if (data is Uint8List) {
      handleMessage(data);
    }
  }

  void handleMessage(Uint8List data) {
    final message = proto.Message.fromBuffer(data);

    if (message.hasVideoFrame()) {
      final frame = message.videoFrame;
      player.upload(frame.data as Uint8List);
      onSize(frame.width, frame.height);
    }
  }

  // void handleBinary(Uint8List data) {
  //   if (_pendingChunks == null) {
  //     return;
  //   }

  //   if (_pendingChunks! > 0) {
  //     _buffer.add(data);
  //     _pendingChunks = _pendingChunks! - 1;
  //   }

  //   if (_pendingChunks! <= 0) {
  //     final frame = _buffer.takeBytes();
  //     player.upload(frame);
  //     _pendingChunks = null;
  //   }
  // }
}

class DesktopConnection {
  DesktopConnection({
    required this.url,
    required this.onData,
  }) {
    channel = IOWebSocketChannel.connect(url);
    channel.stream.listen(_onData, onError: _onError);
  }

  final Uri url;

  final void Function(dynamic) onData;

  final state = ValueNotifier(DesktopConnectionState.connecting);

  late IOWebSocketChannel channel;

  void _onData(data) {
    onData(data);
  }

  void _onError(error) {
    print('_onError $error');
    state.value = DesktopConnectionState.aborted;
  }

  void sendMessage(proto.Message message) {
    channel.sink.add(message.writeToBuffer());
  }
}

enum DesktopConnectionState {
  connecting,
  connected,
  aborted,
}
