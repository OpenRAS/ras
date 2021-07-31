///
//  Generated code. Do not modify.
//  source: message.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use mouseButtonDescriptor instead')
const MouseButton$json = const {
  '1': 'MouseButton',
  '2': const [
    const {'1': 'LEFT', '2': 0},
    const {'1': 'MIDDLE', '2': 1},
    const {'1': 'RIGHT', '2': 2},
    const {'1': 'SCROLL_UP', '2': 3},
    const {'1': 'SCROLL_DOWN', '2': 4},
    const {'1': 'SCROLL_LEFT', '2': 5},
    const {'1': 'SCROLL_RIGHT', '2': 6},
  ],
};

/// Descriptor for `MouseButton`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List mouseButtonDescriptor = $convert.base64Decode('CgtNb3VzZUJ1dHRvbhIICgRMRUZUEAASCgoGTUlERExFEAESCQoFUklHSFQQAhINCglTQ1JPTExfVVAQAxIPCgtTQ1JPTExfRE9XThAEEg8KC1NDUk9MTF9MRUZUEAUSEAoMU0NST0xMX1JJR0hUEAY=');
@$core.Deprecated('Use keyDescriptor instead')
const Key$json = const {
  '1': 'Key',
  '2': const [
    const {'1': 'Alt', '2': 0},
    const {'1': 'Backspace', '2': 1},
    const {'1': 'CapsLock', '2': 2},
    const {'1': 'Control', '2': 3},
    const {'1': 'Delete', '2': 4},
    const {'1': 'DownArrow', '2': 5},
    const {'1': 'End', '2': 6},
    const {'1': 'Escape', '2': 7},
    const {'1': 'F1', '2': 8},
    const {'1': 'F10', '2': 9},
    const {'1': 'F11', '2': 10},
    const {'1': 'F12', '2': 11},
    const {'1': 'F2', '2': 12},
    const {'1': 'F3', '2': 13},
    const {'1': 'F4', '2': 14},
    const {'1': 'F5', '2': 15},
    const {'1': 'F6', '2': 16},
    const {'1': 'F7', '2': 17},
    const {'1': 'F8', '2': 18},
    const {'1': 'F9', '2': 19},
    const {'1': 'Home', '2': 20},
    const {'1': 'LeftArrow', '2': 21},
    const {'1': 'Meta', '2': 22},
    const {'1': 'Option', '2': 23},
    const {'1': 'PageDown', '2': 24},
    const {'1': 'PageUp', '2': 25},
    const {'1': 'Return', '2': 26},
    const {'1': 'RightArrow', '2': 27},
    const {'1': 'Shift', '2': 28},
    const {'1': 'Space', '2': 29},
    const {'1': 'Tab', '2': 30},
    const {'1': 'UpArrow', '2': 31},
  ],
};

/// Descriptor for `Key`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List keyDescriptor = $convert.base64Decode('CgNLZXkSBwoDQWx0EAASDQoJQmFja3NwYWNlEAESDAoIQ2Fwc0xvY2sQAhILCgdDb250cm9sEAMSCgoGRGVsZXRlEAQSDQoJRG93bkFycm93EAUSBwoDRW5kEAYSCgoGRXNjYXBlEAcSBgoCRjEQCBIHCgNGMTAQCRIHCgNGMTEQChIHCgNGMTIQCxIGCgJGMhAMEgYKAkYzEA0SBgoCRjQQDhIGCgJGNRAPEgYKAkY2EBASBgoCRjcQERIGCgJGOBASEgYKAkY5EBMSCAoESG9tZRAUEg0KCUxlZnRBcnJvdxAVEggKBE1ldGEQFhIKCgZPcHRpb24QFxIMCghQYWdlRG93bhAYEgoKBlBhZ2VVcBAZEgoKBlJldHVybhAaEg4KClJpZ2h0QXJyb3cQGxIJCgVTaGlmdBAcEgkKBVNwYWNlEB0SBwoDVGFiEB4SCwoHVXBBcnJvdxAf');
@$core.Deprecated('Use videoFrameDescriptor instead')
const VideoFrame$json = const {
  '1': 'VideoFrame',
  '2': const [
    const {'1': 'width', '3': 1, '4': 1, '5': 13, '10': 'width'},
    const {'1': 'height', '3': 2, '4': 1, '5': 13, '10': 'height'},
    const {'1': 'data', '3': 3, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `VideoFrame`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoFrameDescriptor = $convert.base64Decode('CgpWaWRlb0ZyYW1lEhQKBXdpZHRoGAEgASgNUgV3aWR0aBIWCgZoZWlnaHQYAiABKA1SBmhlaWdodBISCgRkYXRhGAMgASgMUgRkYXRh');
@$core.Deprecated('Use mouseMoveDescriptor instead')
const MouseMove$json = const {
  '1': 'MouseMove',
  '2': const [
    const {'1': 'x', '3': 1, '4': 1, '5': 13, '10': 'x'},
    const {'1': 'y', '3': 2, '4': 1, '5': 13, '10': 'y'},
  ],
};

/// Descriptor for `MouseMove`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mouseMoveDescriptor = $convert.base64Decode('CglNb3VzZU1vdmUSDAoBeBgBIAEoDVIBeBIMCgF5GAIgASgNUgF5');
@$core.Deprecated('Use mouseMoveRelativeDescriptor instead')
const MouseMoveRelative$json = const {
  '1': 'MouseMoveRelative',
  '2': const [
    const {'1': 'dx', '3': 1, '4': 1, '5': 5, '10': 'dx'},
    const {'1': 'dy', '3': 2, '4': 1, '5': 5, '10': 'dy'},
  ],
};

/// Descriptor for `MouseMoveRelative`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mouseMoveRelativeDescriptor = $convert.base64Decode('ChFNb3VzZU1vdmVSZWxhdGl2ZRIOCgJkeBgBIAEoBVICZHgSDgoCZHkYAiABKAVSAmR5');
@$core.Deprecated('Use mouseUpDescriptor instead')
const MouseUp$json = const {
  '1': 'MouseUp',
  '2': const [
    const {'1': 'button', '3': 1, '4': 1, '5': 14, '6': '.ras.MouseButton', '10': 'button'},
  ],
};

/// Descriptor for `MouseUp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mouseUpDescriptor = $convert.base64Decode('CgdNb3VzZVVwEigKBmJ1dHRvbhgBIAEoDjIQLnJhcy5Nb3VzZUJ1dHRvblIGYnV0dG9u');
@$core.Deprecated('Use mouseDownDescriptor instead')
const MouseDown$json = const {
  '1': 'MouseDown',
  '2': const [
    const {'1': 'button', '3': 1, '4': 1, '5': 14, '6': '.ras.MouseButton', '10': 'button'},
  ],
};

/// Descriptor for `MouseDown`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mouseDownDescriptor = $convert.base64Decode('CglNb3VzZURvd24SKAoGYnV0dG9uGAEgASgOMhAucmFzLk1vdXNlQnV0dG9uUgZidXR0b24=');
@$core.Deprecated('Use mouseClickDescriptor instead')
const MouseClick$json = const {
  '1': 'MouseClick',
  '2': const [
    const {'1': 'button', '3': 1, '4': 1, '5': 14, '6': '.ras.MouseButton', '10': 'button'},
  ],
};

/// Descriptor for `MouseClick`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mouseClickDescriptor = $convert.base64Decode('CgpNb3VzZUNsaWNrEigKBmJ1dHRvbhgBIAEoDjIQLnJhcy5Nb3VzZUJ1dHRvblIGYnV0dG9u');
@$core.Deprecated('Use mouseScrollDescriptor instead')
const MouseScroll$json = const {
  '1': 'MouseScroll',
  '2': const [
    const {'1': 'dx', '3': 1, '4': 1, '5': 5, '10': 'dx'},
    const {'1': 'dy', '3': 2, '4': 1, '5': 5, '10': 'dy'},
  ],
};

/// Descriptor for `MouseScroll`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mouseScrollDescriptor = $convert.base64Decode('CgtNb3VzZVNjcm9sbBIOCgJkeBgBIAEoBVICZHgSDgoCZHkYAiABKAVSAmR5');
@$core.Deprecated('Use keyUpDescriptor instead')
const KeyUp$json = const {
  '1': 'KeyUp',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 14, '6': '.ras.Key', '9': 0, '10': 'key'},
    const {'1': 'char', '3': 2, '4': 1, '5': 13, '9': 0, '10': 'char'},
  ],
  '8': const [
    const {'1': 'union'},
  ],
};

/// Descriptor for `KeyUp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List keyUpDescriptor = $convert.base64Decode('CgVLZXlVcBIcCgNrZXkYASABKA4yCC5yYXMuS2V5SABSA2tleRIUCgRjaGFyGAIgASgNSABSBGNoYXJCBwoFdW5pb24=');
@$core.Deprecated('Use keyDownDescriptor instead')
const KeyDown$json = const {
  '1': 'KeyDown',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 14, '6': '.ras.Key', '9': 0, '10': 'key'},
    const {'1': 'char', '3': 2, '4': 1, '5': 13, '9': 0, '10': 'char'},
  ],
  '8': const [
    const {'1': 'union'},
  ],
};

/// Descriptor for `KeyDown`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List keyDownDescriptor = $convert.base64Decode('CgdLZXlEb3duEhwKA2tleRgBIAEoDjIILnJhcy5LZXlIAFIDa2V5EhQKBGNoYXIYAiABKA1IAFIEY2hhckIHCgV1bmlvbg==');
@$core.Deprecated('Use messageDescriptor instead')
const Message$json = const {
  '1': 'Message',
  '2': const [
    const {'1': 'video_frame', '3': 1, '4': 1, '5': 11, '6': '.ras.VideoFrame', '9': 0, '10': 'videoFrame'},
    const {'1': 'mouse_move', '3': 2, '4': 1, '5': 11, '6': '.ras.MouseMove', '9': 0, '10': 'mouseMove'},
    const {'1': 'mouse_move_relative', '3': 3, '4': 1, '5': 11, '6': '.ras.MouseMoveRelative', '9': 0, '10': 'mouseMoveRelative'},
    const {'1': 'mouse_up', '3': 4, '4': 1, '5': 11, '6': '.ras.MouseUp', '9': 0, '10': 'mouseUp'},
    const {'1': 'mouse_down', '3': 5, '4': 1, '5': 11, '6': '.ras.MouseDown', '9': 0, '10': 'mouseDown'},
    const {'1': 'mouse_click', '3': 6, '4': 1, '5': 11, '6': '.ras.MouseClick', '9': 0, '10': 'mouseClick'},
    const {'1': 'mouse_scroll', '3': 7, '4': 1, '5': 11, '6': '.ras.MouseScroll', '9': 0, '10': 'mouseScroll'},
    const {'1': 'key_up', '3': 8, '4': 1, '5': 11, '6': '.ras.KeyUp', '9': 0, '10': 'keyUp'},
    const {'1': 'key_down', '3': 9, '4': 1, '5': 11, '6': '.ras.KeyDown', '9': 0, '10': 'keyDown'},
  ],
  '8': const [
    const {'1': 'union'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode('CgdNZXNzYWdlEjIKC3ZpZGVvX2ZyYW1lGAEgASgLMg8ucmFzLlZpZGVvRnJhbWVIAFIKdmlkZW9GcmFtZRIvCgptb3VzZV9tb3ZlGAIgASgLMg4ucmFzLk1vdXNlTW92ZUgAUgltb3VzZU1vdmUSSAoTbW91c2VfbW92ZV9yZWxhdGl2ZRgDIAEoCzIWLnJhcy5Nb3VzZU1vdmVSZWxhdGl2ZUgAUhFtb3VzZU1vdmVSZWxhdGl2ZRIpCghtb3VzZV91cBgEIAEoCzIMLnJhcy5Nb3VzZVVwSABSB21vdXNlVXASLwoKbW91c2VfZG93bhgFIAEoCzIOLnJhcy5Nb3VzZURvd25IAFIJbW91c2VEb3duEjIKC21vdXNlX2NsaWNrGAYgASgLMg8ucmFzLk1vdXNlQ2xpY2tIAFIKbW91c2VDbGljaxI1Cgxtb3VzZV9zY3JvbGwYByABKAsyEC5yYXMuTW91c2VTY3JvbGxIAFILbW91c2VTY3JvbGwSIwoGa2V5X3VwGAggASgLMgoucmFzLktleVVwSABSBWtleVVwEikKCGtleV9kb3duGAkgASgLMgwucmFzLktleURvd25IAFIHa2V5RG93bkIHCgV1bmlvbg==');
