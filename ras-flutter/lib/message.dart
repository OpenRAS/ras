// import 'package:json_annotation/json_annotation.dart';

// part 'message.g.dart';

// abstract class RasMessage {
//   static RasMessage? parse(Map<String, dynamic> json) {
//     final type = json['t'];

//     if (type is! String) {
//       return null;
//     }

//     switch (type) {
//       case VideoFrame.type:
//         return VideoFrame.fromJson(json);
//       case MouseMove.type:
//         return MouseMove.fromJson(json);
//     }
//   }

//   Map<String, dynamic> toJson();
// }

// @JsonSerializable()
// class VideoFrame implements RasMessage {
//   VideoFrame();

//   static const type = 'vf';

//   @JsonKey(name: 'w')
//   late int width;

//   @JsonKey(name: 'h')
//   late int height;

//   @JsonKey(name: 'n')
//   late int chunks;

//   factory VideoFrame.fromJson(Map<String, dynamic> json) {
//     return _$VideoFrameFromJson(json);
//   }

//   @override
//   Map<String, dynamic> toJson() {
//     return _$VideoFrameToJson(this)..['t'] = type;
//   }
// }

// @JsonSerializable()
// class MouseMove implements RasMessage {
//   MouseMove();

//   static const type = 'mm';

//   late int x;

//   late int y;

//   factory MouseMove.fromJson(Map<String, dynamic> json) {
//     return _$MouseMoveFromJson(json);
//   }

//   @override
//   Map<String, dynamic> toJson() {
//     return _$MouseMoveToJson(this)..['t'] = type;
//   }
// }

// @JsonSerializable()
// class MouseUp implements RasMessage {
//   MouseUp();

//   static const type = 'mu';

//   @JsonKey(name: 'b')
//   late String button;

//   factory MouseUp.fromJson(Map<String, dynamic> json) {
//     return _$MouseUpFromJson(json);
//   }

//   @override
//   Map<String, dynamic> toJson() {
//     return _$MouseUpToJson(this)..['t'] = type;
//   }
// }

// @JsonSerializable()
// class MouseDown implements RasMessage {
//   MouseDown();

//   static const type = 'md';

//   @JsonKey(name: 'b')
//   late String button;

//   factory MouseDown.fromJson(Map<String, dynamic> json) {
//     return _$MouseDownFromJson(json);
//   }

//   @override
//   Map<String, dynamic> toJson() {
//     return _$MouseDownToJson(this)..['t'] = type;
//   }
// }

// @JsonSerializable()
// class MouseScroll implements RasMessage {
//   MouseScroll();

//   static const type = 'ms';

//   late int x;

//   late int y;

//   factory MouseScroll.fromJson(Map<String, dynamic> json) {
//     return _$MouseScrollFromJson(json);
//   }

//   @override
//   Map<String, dynamic> toJson() {
//     return _$MouseScrollToJson(this)..['t'] = type;
//   }
// }

// @JsonSerializable()
// class KeyCharUp implements RasMessage {
//   KeyCharUp();

//   static const type = 'kcu';

//   @JsonKey(name: 'c')
//   late int char;

//   factory KeyCharUp.fromJson(Map<String, dynamic> json) {
//     return _$KeyCharUpFromJson(json);
//   }

//   @override
//   Map<String, dynamic> toJson() {
//     return _$KeyCharUpToJson(this)..['t'] = type;
//   }
// }

// @JsonSerializable()
// class KeyCharDown implements RasMessage {
//   KeyCharDown();

//   static const type = 'kcd';

//   @JsonKey(name: 'c')
//   late int char;

//   factory KeyCharDown.fromJson(Map<String, dynamic> json) {
//     return _$KeyCharDownFromJson(json);
//   }

//   @override
//   Map<String, dynamic> toJson() {
//     return _$KeyCharDownToJson(this)..['t'] = type;
//   }
// }