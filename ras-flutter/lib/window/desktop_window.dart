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
    return LayoutBuilder(builder: (context, contrains) {
      return Focus(
        autofocus: true,
        onKey: (focus, event) {
          if (event is RawKeyUpEvent) onKeyUp(event);
          if (event is RawKeyDownEvent) onKeyDown(event);
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

    final message = proto.MouseMove(
      x: offset.dx.round(),
      y: offset.dy.round(),
    );

    connection.sendMessage(message.writeToBuffer());
  }

  void onPointerUp(int buttonId) {
    final button = mapButtonType(buttonId);
    final message = proto.MouseUp(button: button);
    connection.sendMessage(message.writeToBuffer());
  }

  void onPointerDown(int buttonId) {
    final button = mapButtonType(buttonId);
    final message = proto.MouseDown(button: button);
    connection.sendMessage(message.writeToBuffer());
  }

  void onPointerScroll(Offset delta) {
    final message = proto.MouseScroll(
      dx: (delta.dx / 2).round(),
      dy: (delta.dy / 2).round(),
    );
    connection.sendMessage(message.writeToBuffer());
  }

  void onKeyUp(RawKeyUpEvent event) {
    final char = event.character;
    if (char != null) {
      final message = proto.KeyUp(char: char.codeUnitAt(0));
      connection.sendMessage(message.writeToBuffer());
    }
  }

  void onKeyDown(RawKeyDownEvent event) {
    final char = event.character;
    if (char != null) {
      final message = proto.KeyDown(char: char.codeUnitAt(0));
      connection.sendMessage(message.writeToBuffer());
    }
  }
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

  void sendMessage(Uint8List message) {
    channel.sink.add(message);
  }
}

enum DesktopConnectionState {
  connecting,
  connected,
  aborted,
}
