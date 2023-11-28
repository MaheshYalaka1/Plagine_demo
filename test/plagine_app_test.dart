import 'package:flutter_test/flutter_test.dart';
import 'package:plagine_app/plagine_app.dart';
import 'package:plagine_app/plagine_app_platform_interface.dart';
import 'package:plagine_app/plagine_app_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPlagineAppPlatform
    with MockPlatformInterfaceMixin
    implements PlagineAppPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PlagineAppPlatform initialPlatform = PlagineAppPlatform.instance;

  test('$MethodChannelPlagineApp is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPlagineApp>());
  });

  test('getPlatformVersion', () async {
    PlagineApp plagineAppPlugin = PlagineApp();
    MockPlagineAppPlatform fakePlatform = MockPlagineAppPlatform();
    PlagineAppPlatform.instance = fakePlatform;

    expect(await plagineAppPlugin.getPlatformVersion(), '42');
  });
}
