///
//  Generated code. Do not modify.
//  source: message.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class MouseButton extends $pb.ProtobufEnum {
  static const MouseButton LEFT = MouseButton._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LEFT');
  static const MouseButton MIDDLE = MouseButton._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MIDDLE');
  static const MouseButton RIGHT = MouseButton._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RIGHT');
  static const MouseButton SCROLL_UP = MouseButton._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SCROLL_UP');
  static const MouseButton SCROLL_DOWN = MouseButton._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SCROLL_DOWN');
  static const MouseButton SCROLL_LEFT = MouseButton._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SCROLL_LEFT');
  static const MouseButton SCROLL_RIGHT = MouseButton._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SCROLL_RIGHT');

  static const $core.List<MouseButton> values = <MouseButton> [
    LEFT,
    MIDDLE,
    RIGHT,
    SCROLL_UP,
    SCROLL_DOWN,
    SCROLL_LEFT,
    SCROLL_RIGHT,
  ];

  static final $core.Map<$core.int, MouseButton> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MouseButton? valueOf($core.int value) => _byValue[value];

  const MouseButton._($core.int v, $core.String n) : super(v, n);
}

class Key extends $pb.ProtobufEnum {
  static const Key Alt = Key._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Alt');
  static const Key Backspace = Key._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Backspace');
  static const Key CapsLock = Key._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CapsLock');
  static const Key Control = Key._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Control');
  static const Key Delete = Key._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Delete');
  static const Key DownArrow = Key._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DownArrow');
  static const Key End = Key._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'End');
  static const Key Escape = Key._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Escape');
  static const Key F1 = Key._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'F1');
  static const Key F10 = Key._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'F10');
  static const Key F11 = Key._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'F11');
  static const Key F12 = Key._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'F12');
  static const Key F2 = Key._(12, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'F2');
  static const Key F3 = Key._(13, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'F3');
  static const Key F4 = Key._(14, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'F4');
  static const Key F5 = Key._(15, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'F5');
  static const Key F6 = Key._(16, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'F6');
  static const Key F7 = Key._(17, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'F7');
  static const Key F8 = Key._(18, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'F8');
  static const Key F9 = Key._(19, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'F9');
  static const Key Home = Key._(20, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Home');
  static const Key LeftArrow = Key._(21, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LeftArrow');
  static const Key Meta = Key._(22, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Meta');
  static const Key Option = Key._(23, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Option');
  static const Key PageDown = Key._(24, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PageDown');
  static const Key PageUp = Key._(25, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PageUp');
  static const Key Return = Key._(26, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Return');
  static const Key RightArrow = Key._(27, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RightArrow');
  static const Key Shift = Key._(28, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Shift');
  static const Key Space = Key._(29, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Space');
  static const Key Tab = Key._(30, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Tab');
  static const Key UpArrow = Key._(31, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UpArrow');

  static const $core.List<Key> values = <Key> [
    Alt,
    Backspace,
    CapsLock,
    Control,
    Delete,
    DownArrow,
    End,
    Escape,
    F1,
    F10,
    F11,
    F12,
    F2,
    F3,
    F4,
    F5,
    F6,
    F7,
    F8,
    F9,
    Home,
    LeftArrow,
    Meta,
    Option,
    PageDown,
    PageUp,
    Return,
    RightArrow,
    Shift,
    Space,
    Tab,
    UpArrow,
  ];

  static final $core.Map<$core.int, Key> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Key? valueOf($core.int value) => _byValue[value];

  const Key._($core.int v, $core.String n) : super(v, n);
}

