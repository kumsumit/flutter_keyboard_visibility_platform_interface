import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility_platform_interface/flutter_keyboard_visibility_platform_interface.dart';
import 'package:meta/meta.dart';

/// The method channel implementation of the flutter_keyboard_visibility plugin,
/// currently used for Android and iOS.
class MethodChannelFlutterKeyboardVisibility
    extends FlutterKeyboardVisibilityPlatform {
  /// The event channel used for emitting keyboard visibility updates
  @visibleForTesting
  EventChannel eventChannel = const EventChannel('flutter_keyboard_visibility');

  late final Stream<KeyboardVisibilityStatus> _onChange = eventChannel
      .receiveBroadcastStream()
      .map((dynamic event) {
        switch (event as int) {
          case 2:
            return KeyboardVisibilityStatus.iosExternalKeyboardVisible;
          case 1:
            return KeyboardVisibilityStatus.visible;
          case 0:
          default:
            return KeyboardVisibilityStatus.notVisible;
        }
      });

  /// Emits changes to keyboard visibility from the platform
  @override
  Stream<KeyboardVisibilityStatus> get onChange => _onChange;
}
