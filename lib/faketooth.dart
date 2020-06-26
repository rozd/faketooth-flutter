library faketooth;

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

part 'faketooth_peripheral.dart';
part 'faketooth_service.dart';
part 'faketooth_characteristic.dart';
part 'faketooth_descriptor.dart';

class Faketooth {
  static const MethodChannel _channel =
  const MethodChannel('faketooth');

  static Future<bool> get isSimulated async {
    return await _channel.invokeMethod('isSimulated');
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> setSimulatedPeripherals(List<FaketoothPeripheral> value) async {
    await _channel.invokeMethod('setSimulatedPeripherals', value.map((value) => value.toArguments()).toList());
  }
}
