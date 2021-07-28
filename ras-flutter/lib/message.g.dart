// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoFrame _$VideoFrameFromJson(Map<String, dynamic> json) {
  return VideoFrame()
    ..width = json['w'] as int
    ..height = json['h'] as int
    ..chunks = json['n'] as int;
}

Map<String, dynamic> _$VideoFrameToJson(VideoFrame instance) =>
    <String, dynamic>{
      'w': instance.width,
      'h': instance.height,
      'n': instance.chunks,
    };

MouseMove _$MouseMoveFromJson(Map<String, dynamic> json) {
  return MouseMove()
    ..x = json['x'] as int
    ..y = json['y'] as int;
}

Map<String, dynamic> _$MouseMoveToJson(MouseMove instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };

MouseUp _$MouseUpFromJson(Map<String, dynamic> json) {
  return MouseUp()..button = json['b'] as String;
}

Map<String, dynamic> _$MouseUpToJson(MouseUp instance) => <String, dynamic>{
      'b': instance.button,
    };

MouseDown _$MouseDownFromJson(Map<String, dynamic> json) {
  return MouseDown()..button = json['b'] as String;
}

Map<String, dynamic> _$MouseDownToJson(MouseDown instance) => <String, dynamic>{
      'b': instance.button,
    };

MouseScrollX _$MouseScrollXFromJson(Map<String, dynamic> json) {
  return MouseScrollX()..offset = json['o'] as int;
}

Map<String, dynamic> _$MouseScrollXToJson(MouseScrollX instance) =>
    <String, dynamic>{
      'o': instance.offset,
    };

MouseScrollY _$MouseScrollYFromJson(Map<String, dynamic> json) {
  return MouseScrollY()..offset = json['o'] as int;
}

Map<String, dynamic> _$MouseScrollYToJson(MouseScrollY instance) =>
    <String, dynamic>{
      'o': instance.offset,
    };
