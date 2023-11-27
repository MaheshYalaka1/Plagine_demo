import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'plagine_app_method_channel.dart';

abstract class PlagineAppPlatform extends PlatformInterface {
  /// Constructs a PlagineAppPlatform.
  PlagineAppPlatform() : super(token: _token);

  static final Object _token = Object();

  static PlagineAppPlatform _instance = MethodChannelPlagineApp();

  /// The default instance of [PlagineAppPlatform] to use.
  ///
  /// Defaults to [MethodChannelPlagineApp].
  static PlagineAppPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PlagineAppPlatform] when
  /// they register themselves.
  static set instance(PlagineAppPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
