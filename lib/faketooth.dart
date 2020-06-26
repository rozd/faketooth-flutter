import 'dart:async';

import 'package:flutter/services.dart';

class Faketooth {
  static const MethodChannel _channel =
      const MethodChannel('faketooth');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
