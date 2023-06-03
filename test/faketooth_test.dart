import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:faketooth/faketooth.dart';

void main() {
  const MethodChannel channel = MethodChannel('faketooth');

  TestWidgetsFlutterBinding.ensureInitialized();
  var binding = TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  setUp(() {
    binding.setMockMethodCallHandler(channel, (message) async {
        return '42';
    });
  });

  tearDown(() {
    binding.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await Faketooth.shared.platformVersion, '42');
  });
}
