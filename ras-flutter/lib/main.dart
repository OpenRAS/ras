import 'package:app_template/window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nativeshell/nativeshell.dart';

// final controller = Vp9PlayerController();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

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
        child: Column(
          children: [
            TextButton(
              child: Text('Link Start'),
              onPressed: () {
                Window.create(
                  DesktopWindowState.toInitData(
                    'ws://192.168.0.109:3030/desktop',
                  ),
                );
              },
            ),
            TextButton(
              child: Text('Link Start 1'),
              onPressed: () {
                Window.create(
                  DesktopWindowState.toInitData(
                    'ws://192.168.0.109:3031/desktop',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
