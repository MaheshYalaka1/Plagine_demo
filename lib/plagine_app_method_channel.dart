import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'plagine_app_platform_interface.dart';

/// An implementation of [PlagineAppPlatform] that uses method channels.
class MethodChannelPlagineApp extends PlagineAppPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('plagine_app');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
