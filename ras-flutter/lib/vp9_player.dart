import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

final _channel = MethodChannel('frameplayer_264_channel');

class Vp9Player {
  int? _textureId;

  var _width = 0;
  var _height = 0;

  final isReady = ValueNotifier(false);

  int get width {
    return _width;
  }

  int get height {
    return _height;
  }

  int get textureId {
    if (_textureId == null) {
      throw StateError('FramePlayerController is not initialized!');
    }

    return _textureId!;
  }

  Future<void> init() async {
    final textureId = await _channel.invokeMethod('init');

    if (textureId is! int) {
      throw StateError(
        'FramePlayerController initialization failed: got $textureId',
      );
    }

    _textureId = textureId;

    isReady.value = true;
  }

  Future<void> upload(Uint8List rawFrame) async {
    await _channel.invokeMethod('upload', rawFrame);
  }

  // void updateSize(int width, int height) {
  //   _width = width;
  //   _height = height;
  //   notifyListeners();
  // }
}

class Vp9PlayerView extends StatefulWidget {
  const Vp9PlayerView({
    Key? key,
    required this.player,
  }) : super(key: key);

  final Vp9Player player;

  @override
  State<Vp9PlayerView> createState() => _Vp9PlayerViewState();
}

class _Vp9PlayerViewState extends State<Vp9PlayerView> {
  @override
  void initState() {
    widget.player.isReady.addListener(onPlayerReady);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Vp9PlayerView oldWidget) {
    oldWidget.player.isReady.removeListener(onPlayerReady);
    widget.player.isReady.addListener(onPlayerReady);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.player.isReady.removeListener(onPlayerReady);
    super.dispose();
  }

  void onPlayerReady() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.player.isReady.value != true) {
      return Container();
    }

    return Texture(
      textureId: widget.player.textureId,
    );
  }
}
