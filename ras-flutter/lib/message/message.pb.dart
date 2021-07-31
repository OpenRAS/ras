///
//  Generated code. Do not modify.
//  source: message.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'message.pbenum.dart';

export 'message.pbenum.dart';

class VideoFrame extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VideoFrame', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ras'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'width', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'height', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  VideoFrame._() : super();
  factory VideoFrame({
    $core.int? width,
    $core.int? height,
    $core.List<$core.int>? data,
  }) {
    final _result = create();
    if (width != null) {
      _result.width = width;
    }
    if (height != null) {
      _result.height = height;
    }
    if (data != null) {
      _result.data = data;
    }
    return _result;
  }
  factory VideoFrame.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VideoFrame.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VideoFrame clone() => VideoFrame()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VideoFrame copyWith(void Function(VideoFrame) updates) => super.copyWith((message) => updates(message as VideoFrame)) as VideoFrame; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VideoFrame create() => VideoFrame._();
  VideoFrame createEmptyInstance() => create();
  static $pb.PbList<VideoFrame> createRepeated() => $pb.PbList<VideoFrame>();
  @$core.pragma('dart2js:noInline')
  static VideoFrame getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VideoFrame>(create);
  static VideoFrame? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get width => $_getIZ(0);
  @$pb.TagNumber(1)
  set width($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWidth() => $_has(0);
  @$pb.TagNumber(1)
  void clearWidth() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get height => $_getIZ(1);
  @$pb.TagNumber(2)
  set height($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearHeight() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get data => $_getN(2);
  @$pb.TagNumber(3)
  set data($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => clearField(3);
}

class MouseMove extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MouseMove', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ras'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'x', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'y', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  MouseMove._() : super();
  factory MouseMove({
    $core.int? x,
    $core.int? y,
  }) {
    final _result = create();
    if (x != null) {
      _result.x = x;
    }
    if (y != null) {
      _result.y = y;
    }
    return _result;
  }
  factory MouseMove.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MouseMove.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MouseMove clone() => MouseMove()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MouseMove copyWith(void Function(MouseMove) updates) => super.copyWith((message) => updates(message as MouseMove)) as MouseMove; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MouseMove create() => MouseMove._();
  MouseMove createEmptyInstance() => create();
  static $pb.PbList<MouseMove> createRepeated() => $pb.PbList<MouseMove>();
  @$core.pragma('dart2js:noInline')
  static MouseMove getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MouseMove>(create);
  static MouseMove? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get x => $_getIZ(0);
  @$pb.TagNumber(1)
  set x($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get y => $_getIZ(1);
  @$pb.TagNumber(2)
  set y($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => clearField(2);
}

class MouseMoveRelative extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MouseMoveRelative', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ras'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dx', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dy', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  MouseMoveRelative._() : super();
  factory MouseMoveRelative({
    $core.int? dx,
    $core.int? dy,
  }) {
    final _result = create();
    if (dx != null) {
      _result.dx = dx;
    }
    if (dy != null) {
      _result.dy = dy;
    }
    return _result;
  }
  factory MouseMoveRelative.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MouseMoveRelative.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MouseMoveRelative clone() => MouseMoveRelative()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MouseMoveRelative copyWith(void Function(MouseMoveRelative) updates) => super.copyWith((message) => updates(message as MouseMoveRelative)) as MouseMoveRelative; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MouseMoveRelative create() => MouseMoveRelative._();
  MouseMoveRelative createEmptyInstance() => create();
  static $pb.PbList<MouseMoveRelative> createRepeated() => $pb.PbList<MouseMoveRelative>();
  @$core.pragma('dart2js:noInline')
  static MouseMoveRelative getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MouseMoveRelative>(create);
  static MouseMoveRelative? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get dx => $_getIZ(0);
  @$pb.TagNumber(1)
  set dx($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDx() => $_has(0);
  @$pb.TagNumber(1)
  void clearDx() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get dy => $_getIZ(1);
  @$pb.TagNumber(2)
  set dy($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDy() => $_has(1);
  @$pb.TagNumber(2)
  void clearDy() => clearField(2);
}

class MouseUp extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MouseUp', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ras'), createEmptyInstance: create)
    ..e<MouseButton>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'button', $pb.PbFieldType.OE, defaultOrMaker: MouseButton.LEFT, valueOf: MouseButton.valueOf, enumValues: MouseButton.values)
    ..hasRequiredFields = false
  ;

  MouseUp._() : super();
  factory MouseUp({
    MouseButton? button,
  }) {
    final _result = create();
    if (button != null) {
      _result.button = button;
    }
    return _result;
  }
  factory MouseUp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MouseUp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MouseUp clone() => MouseUp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MouseUp copyWith(void Function(MouseUp) updates) => super.copyWith((message) => updates(message as MouseUp)) as MouseUp; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MouseUp create() => MouseUp._();
  MouseUp createEmptyInstance() => create();
  static $pb.PbList<MouseUp> createRepeated() => $pb.PbList<MouseUp>();
  @$core.pragma('dart2js:noInline')
  static MouseUp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MouseUp>(create);
  static MouseUp? _defaultInstance;

  @$pb.TagNumber(1)
  MouseButton get button => $_getN(0);
  @$pb.TagNumber(1)
  set button(MouseButton v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasButton() => $_has(0);
  @$pb.TagNumber(1)
  void clearButton() => clearField(1);
}

class MouseDown extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MouseDown', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ras'), createEmptyInstance: create)
    ..e<MouseButton>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'button', $pb.PbFieldType.OE, defaultOrMaker: MouseButton.LEFT, valueOf: MouseButton.valueOf, enumValues: MouseButton.values)
    ..hasRequiredFields = false
  ;

  MouseDown._() : super();
  factory MouseDown({
    MouseButton? button,
  }) {
    final _result = create();
    if (button != null) {
      _result.button = button;
    }
    return _result;
  }
  factory MouseDown.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MouseDown.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MouseDown clone() => MouseDown()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MouseDown copyWith(void Function(MouseDown) updates) => super.copyWith((message) => updates(message as MouseDown)) as MouseDown; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MouseDown create() => MouseDown._();
  MouseDown createEmptyInstance() => create();
  static $pb.PbList<MouseDown> createRepeated() => $pb.PbList<MouseDown>();
  @$core.pragma('dart2js:noInline')
  static MouseDown getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MouseDown>(create);
  static MouseDown? _defaultInstance;

  @$pb.TagNumber(1)
  MouseButton get button => $_getN(0);
  @$pb.TagNumber(1)
  set button(MouseButton v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasButton() => $_has(0);
  @$pb.TagNumber(1)
  void clearButton() => clearField(1);
}

class MouseClick extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MouseClick', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ras'), createEmptyInstance: create)
    ..e<MouseButton>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'button', $pb.PbFieldType.OE, defaultOrMaker: MouseButton.LEFT, valueOf: MouseButton.valueOf, enumValues: MouseButton.values)
    ..hasRequiredFields = false
  ;

  MouseClick._() : super();
  factory MouseClick({
    MouseButton? button,
  }) {
    final _result = create();
    if (button != null) {
      _result.button = button;
    }
    return _result;
  }
  factory MouseClick.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MouseClick.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MouseClick clone() => MouseClick()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MouseClick copyWith(void Function(MouseClick) updates) => super.copyWith((message) => updates(message as MouseClick)) as MouseClick; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MouseClick create() => MouseClick._();
  MouseClick createEmptyInstance() => create();
  static $pb.PbList<MouseClick> createRepeated() => $pb.PbList<MouseClick>();
  @$core.pragma('dart2js:noInline')
  static MouseClick getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MouseClick>(create);
  static MouseClick? _defaultInstance;

  @$pb.TagNumber(1)
  MouseButton get button => $_getN(0);
  @$pb.TagNumber(1)
  set button(MouseButton v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasButton() => $_has(0);
  @$pb.TagNumber(1)
  void clearButton() => clearField(1);
}

class MouseScroll extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MouseScroll', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ras'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dx', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dy', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  MouseScroll._() : super();
  factory MouseScroll({
    $core.int? dx,
    $core.int? dy,
  }) {
    final _result = create();
    if (dx != null) {
      _result.dx = dx;
    }
    if (dy != null) {
      _result.dy = dy;
    }
    return _result;
  }
  factory MouseScroll.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MouseScroll.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MouseScroll clone() => MouseScroll()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MouseScroll copyWith(void Function(MouseScroll) updates) => super.copyWith((message) => updates(message as MouseScroll)) as MouseScroll; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MouseScroll create() => MouseScroll._();
  MouseScroll createEmptyInstance() => create();
  static $pb.PbList<MouseScroll> createRepeated() => $pb.PbList<MouseScroll>();
  @$core.pragma('dart2js:noInline')
  static MouseScroll getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MouseScroll>(create);
  static MouseScroll? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get dx => $_getIZ(0);
  @$pb.TagNumber(1)
  set dx($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDx() => $_has(0);
  @$pb.TagNumber(1)
  void clearDx() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get dy => $_getIZ(1);
  @$pb.TagNumber(2)
  set dy($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDy() => $_has(1);
  @$pb.TagNumber(2)
  void clearDy() => clearField(2);
}

enum KeyUp_Union {
  key, 
  char, 
  notSet
}

class KeyUp extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, KeyUp_Union> _KeyUp_UnionByTag = {
    1 : KeyUp_Union.key,
    2 : KeyUp_Union.char,
    0 : KeyUp_Union.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'KeyUp', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ras'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..e<Key>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OE, defaultOrMaker: Key.Alt, valueOf: Key.valueOf, enumValues: Key.values)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'char', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  KeyUp._() : super();
  factory KeyUp({
    Key? key,
    $core.int? char,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (char != null) {
      _result.char = char;
    }
    return _result;
  }
  factory KeyUp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory KeyUp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  KeyUp clone() => KeyUp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  KeyUp copyWith(void Function(KeyUp) updates) => super.copyWith((message) => updates(message as KeyUp)) as KeyUp; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static KeyUp create() => KeyUp._();
  KeyUp createEmptyInstance() => create();
  static $pb.PbList<KeyUp> createRepeated() => $pb.PbList<KeyUp>();
  @$core.pragma('dart2js:noInline')
  static KeyUp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<KeyUp>(create);
  static KeyUp? _defaultInstance;

  KeyUp_Union whichUnion() => _KeyUp_UnionByTag[$_whichOneof(0)]!;
  void clearUnion() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Key get key => $_getN(0);
  @$pb.TagNumber(1)
  set key(Key v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get char => $_getIZ(1);
  @$pb.TagNumber(2)
  set char($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChar() => $_has(1);
  @$pb.TagNumber(2)
  void clearChar() => clearField(2);
}

enum KeyDown_Union {
  key, 
  char, 
  notSet
}

class KeyDown extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, KeyDown_Union> _KeyDown_UnionByTag = {
    1 : KeyDown_Union.key,
    2 : KeyDown_Union.char,
    0 : KeyDown_Union.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'KeyDown', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ras'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..e<Key>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', $pb.PbFieldType.OE, defaultOrMaker: Key.Alt, valueOf: Key.valueOf, enumValues: Key.values)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'char', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  KeyDown._() : super();
  factory KeyDown({
    Key? key,
    $core.int? char,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (char != null) {
      _result.char = char;
    }
    return _result;
  }
  factory KeyDown.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory KeyDown.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  KeyDown clone() => KeyDown()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  KeyDown copyWith(void Function(KeyDown) updates) => super.copyWith((message) => updates(message as KeyDown)) as KeyDown; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static KeyDown create() => KeyDown._();
  KeyDown createEmptyInstance() => create();
  static $pb.PbList<KeyDown> createRepeated() => $pb.PbList<KeyDown>();
  @$core.pragma('dart2js:noInline')
  static KeyDown getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<KeyDown>(create);
  static KeyDown? _defaultInstance;

  KeyDown_Union whichUnion() => _KeyDown_UnionByTag[$_whichOneof(0)]!;
  void clearUnion() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Key get key => $_getN(0);
  @$pb.TagNumber(1)
  set key(Key v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get char => $_getIZ(1);
  @$pb.TagNumber(2)
  set char($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChar() => $_has(1);
  @$pb.TagNumber(2)
  void clearChar() => clearField(2);
}

enum Message_Union {
  videoFrame, 
  mouseMove, 
  mouseMoveRelative, 
  mouseUp, 
  mouseDown, 
  mouseClick, 
  mouseScroll, 
  notSet
}

class Message extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Message_Union> _Message_UnionByTag = {
    1 : Message_Union.videoFrame,
    2 : Message_Union.mouseMove,
    3 : Message_Union.mouseMoveRelative,
    4 : Message_Union.mouseUp,
    5 : Message_Union.mouseDown,
    6 : Message_Union.mouseClick,
    7 : Message_Union.mouseScroll,
    0 : Message_Union.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Message', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ras'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7])
    ..aOM<VideoFrame>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'videoFrame', subBuilder: VideoFrame.create)
    ..aOM<MouseMove>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mouseMove', subBuilder: MouseMove.create)
    ..aOM<MouseMoveRelative>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mouseMoveRelative', subBuilder: MouseMoveRelative.create)
    ..aOM<MouseUp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mouseUp', subBuilder: MouseUp.create)
    ..aOM<MouseDown>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mouseDown', subBuilder: MouseDown.create)
    ..aOM<MouseClick>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mouseClick', subBuilder: MouseClick.create)
    ..aOM<MouseScroll>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mouseScroll', subBuilder: MouseScroll.create)
    ..hasRequiredFields = false
  ;

  Message._() : super();
  factory Message({
    VideoFrame? videoFrame,
    MouseMove? mouseMove,
    MouseMoveRelative? mouseMoveRelative,
    MouseUp? mouseUp,
    MouseDown? mouseDown,
    MouseClick? mouseClick,
    MouseScroll? mouseScroll,
  }) {
    final _result = create();
    if (videoFrame != null) {
      _result.videoFrame = videoFrame;
    }
    if (mouseMove != null) {
      _result.mouseMove = mouseMove;
    }
    if (mouseMoveRelative != null) {
      _result.mouseMoveRelative = mouseMoveRelative;
    }
    if (mouseUp != null) {
      _result.mouseUp = mouseUp;
    }
    if (mouseDown != null) {
      _result.mouseDown = mouseDown;
    }
    if (mouseClick != null) {
      _result.mouseClick = mouseClick;
    }
    if (mouseScroll != null) {
      _result.mouseScroll = mouseScroll;
    }
    return _result;
  }
  factory Message.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Message.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Message clone() => Message()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Message copyWith(void Function(Message) updates) => super.copyWith((message) => updates(message as Message)) as Message; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Message create() => Message._();
  Message createEmptyInstance() => create();
  static $pb.PbList<Message> createRepeated() => $pb.PbList<Message>();
  @$core.pragma('dart2js:noInline')
  static Message getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message>(create);
  static Message? _defaultInstance;

  Message_Union whichUnion() => _Message_UnionByTag[$_whichOneof(0)]!;
  void clearUnion() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  VideoFrame get videoFrame => $_getN(0);
  @$pb.TagNumber(1)
  set videoFrame(VideoFrame v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasVideoFrame() => $_has(0);
  @$pb.TagNumber(1)
  void clearVideoFrame() => clearField(1);
  @$pb.TagNumber(1)
  VideoFrame ensureVideoFrame() => $_ensure(0);

  @$pb.TagNumber(2)
  MouseMove get mouseMove => $_getN(1);
  @$pb.TagNumber(2)
  set mouseMove(MouseMove v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasMouseMove() => $_has(1);
  @$pb.TagNumber(2)
  void clearMouseMove() => clearField(2);
  @$pb.TagNumber(2)
  MouseMove ensureMouseMove() => $_ensure(1);

  @$pb.TagNumber(3)
  MouseMoveRelative get mouseMoveRelative => $_getN(2);
  @$pb.TagNumber(3)
  set mouseMoveRelative(MouseMoveRelative v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasMouseMoveRelative() => $_has(2);
  @$pb.TagNumber(3)
  void clearMouseMoveRelative() => clearField(3);
  @$pb.TagNumber(3)
  MouseMoveRelative ensureMouseMoveRelative() => $_ensure(2);

  @$pb.TagNumber(4)
  MouseUp get mouseUp => $_getN(3);
  @$pb.TagNumber(4)
  set mouseUp(MouseUp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasMouseUp() => $_has(3);
  @$pb.TagNumber(4)
  void clearMouseUp() => clearField(4);
  @$pb.TagNumber(4)
  MouseUp ensureMouseUp() => $_ensure(3);

  @$pb.TagNumber(5)
  MouseDown get mouseDown => $_getN(4);
  @$pb.TagNumber(5)
  set mouseDown(MouseDown v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasMouseDown() => $_has(4);
  @$pb.TagNumber(5)
  void clearMouseDown() => clearField(5);
  @$pb.TagNumber(5)
  MouseDown ensureMouseDown() => $_ensure(4);

  @$pb.TagNumber(6)
  MouseClick get mouseClick => $_getN(5);
  @$pb.TagNumber(6)
  set mouseClick(MouseClick v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasMouseClick() => $_has(5);
  @$pb.TagNumber(6)
  void clearMouseClick() => clearField(6);
  @$pb.TagNumber(6)
  MouseClick ensureMouseClick() => $_ensure(5);

  @$pb.TagNumber(7)
  MouseScroll get mouseScroll => $_getN(6);
  @$pb.TagNumber(7)
  set mouseScroll(MouseScroll v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasMouseScroll() => $_has(6);
  @$pb.TagNumber(7)
  void clearMouseScroll() => clearField(7);
  @$pb.TagNumber(7)
  MouseScroll ensureMouseScroll() => $_ensure(6);
}

