import 'package:app_template/window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nativeshell/nativeshell.dart';

// final controller = Vp9PlayerController();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final i = await MethodChannel('texture_channel').invokeMethod<int>('texture');
  // textureId = i!;
  // await MethodChannel('texture_channel').invokeMethod<int>('update');
  // print('textureId $textureId');

  // await controller.init();

  // final handler = MessageHandler(
  //   controller: controller,
  // );
  // final channel =
  //     IOWebSocketChannel.connect(Uri.parse('ws://localhost:3030/desktop'));
  // channel.stream.listen(handler.onData);

  runApp(MyApp());
}

// class MessageHandler {
//   MessageHandler({
//     required this.controller,
//   });

//   final Vp9PlayerController controller;

//   final _buffer = BytesBuilder(copy: false);
//   int? _pendingChunks;

//   void onData(data) {
//     if (data is Uint8List) {
//       handleBinary(data);
//     } else if (data is String) {
//       handleMessage(data);
//     } else {
//       print('bad data: $data');
//     }
//   }

//   void handleMessage(String data) {
//     final message = RasMessage.parse(json.decode(data));

//     if (message is VideoFrame) {
//       controller.updateSize(message.width, message.height);
//       _pendingChunks = message.chunks;
//     }
//   }

//   void handleBinary(Uint8List data) {
//     if (_pendingChunks == null) {
//       return;
//     }

//     if (_pendingChunks! > 0) {
//       _buffer.add(data);
//       _pendingChunks = _pendingChunks! - 1;
//     }

//     if (_pendingChunks! <= 0) {
//       final frame = _buffer.takeBytes();
//       controller.upload(frame);
//       _pendingChunks = null;
//     }
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTextStyle(
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        child: Container(
          color: Colors.black,
          child: WindowWidget(
            onCreateState: (initData) {
              WindowState? state;
              state ??= DesktopWindowState.fromInitData(initData);
              state ??= MainWindowState();
              return state;
            },
          ),
        ),
      ),
    );
  }
}

class MainWindowState extends WindowState {
  @override
  WindowSizingMode get windowSizingMode =>
      WindowSizingMode.atLeastIntrinsicSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Center(
        // padding: EdgeInsets.all(20),
        // child: Center(child: Text('Welcome to NativeShell!')),
        // child: Vp9Player(controller: controller),
        child: TextButton(
          child: Text('Link Start'),
          onPressed: () {
            Window.create(
              DesktopWindowState.toInitData('ws://localhost:3030/desktop'),
            );
          },
        ),
      ),
    );
  }
}
