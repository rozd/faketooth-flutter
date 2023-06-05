library faketooth;

import 'dart:async';
import 'package:flutter/services.dart';

part 'faketooth_peripheral.dart';
part 'faketooth_service.dart';
part 'faketooth_characteristic.dart';
part 'faketooth_descriptor.dart';
part 'faketooth_delay_settings.dart';
part 'faketooth_advertisement_data.dart';

/// A class that provides methods for simulating Bluetooth Low Energy (BLE) devices and interactions.
class Faketooth {

  // MARK: Properties

  MethodChannel _channel = const MethodChannel('faketooth');

  List<FaketoothPeripheral>? _simulatedPeripherals;

  /// A singleton instance of the `Faketooth` class.
  static final Faketooth shared = Faketooth._internal();

  /// Constructs a new instance of the `Faketooth` class.
  factory Faketooth() {
    return shared;
  }

  Faketooth._internal() {
    _channel.setMethodCallHandler(handleMethodCall);
  }

  /// Returns a flag indicating if BLE simulation is enabled.
  Future<bool> get isSimulated async {
    return await _channel.invokeMethod('isSimulated') ?? false;
  }

  /// Returns the platform plugin version.
  Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// Sets the list of simulated peripherals.
  Future<void> setSimulatedPeripherals(List<FaketoothPeripheral> value) async {
    _simulatedPeripherals = value;
    await _channel.invokeMethod(
        'setSimulatedPeripherals', _simulatedPeripherals!.map((value) => value.toArguments()).toList());
  }

  /// Sets the delay settings for BLE interactions.
  Future<void> setSettings({required FaketoothDelaySettings delay}) async {
    await _channel.invokeMethod("setDelaySettings", delay.toArguments());
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case "getValueForCharacteristic":
        var characteristic = findCharacteristic(
          peripheral: call.arguments['peripheral'],
          uuid: call.arguments['uuid']
        );
        if (characteristic?.valueProducer == null) {
          return null;
        }
        return await characteristic!.valueProducer!();
      case "setValueForCharacteristic":
        final characteristic = findCharacteristic(
          peripheral: call.arguments["peripheral"],
          uuid: call.arguments["uuid"],
        );
        final valueHandler = characteristic?.valueHandler;
        if (valueHandler != null) {
          valueHandler(call.arguments["value"]);
        }
        return null;
      case "getValueForDescriptor":
        var descriptor = findDescriptor(
          peripheral: call.arguments['peripheral'],
          uuid: call.arguments['uuid']
        );
        if (descriptor?.valueProducer == null) {
          return null;
        }
        return await descriptor!.valueProducer!();
      case "setValueForDescriptor":
        final descriptor = findDescriptor(
          peripheral: call.arguments['peripheral'],
          uuid: call.arguments['uuid']
        );
        final valueHandler = descriptor?.valueHandler;
        if (valueHandler != null) {
          valueHandler(call.arguments["value"]);
        }
        return null;
      default:
        return null;
    }
  }

  /// Finds a characteristic based on the peripheral identifier and characteristic UUID.
  FaketoothCharacteristic? findCharacteristic({required String peripheral, required String uuid}) {
    if (_simulatedPeripherals?.isNotEmpty == false) {
      return null;
    }

    for (FaketoothPeripheral p in _simulatedPeripherals!) {
      if (p.identifier.toLowerCase() != peripheral.toLowerCase()) {
        continue;
      }
      for (FaketoothService s in p.services!) {
        for (FaketoothCharacteristic c in s.characteristics!) {
          if (c.uuid.toLowerCase() == uuid.toLowerCase()) {
            return c;
          }
        }
      }
    }

    return null;
  }

  /// Finds a descriptor based on the peripheral identifier and descriptor UUID.
  FaketoothDescriptor? findDescriptor({required String peripheral, required String uuid}) {
    if (_simulatedPeripherals?.isNotEmpty == false) {
      return null;
    }

    for (FaketoothPeripheral p in _simulatedPeripherals!) {
      if (p.identifier.toLowerCase() != peripheral.toLowerCase()) {
        continue;
      }
      for (FaketoothService s in p.services!) {
        for (FaketoothCharacteristic c in s.characteristics!) {
          for (FaketoothDescriptor d in c.descriptors!) {
            if (d.uuid.toLowerCase() == uuid.toLowerCase()) {
              return d;
            }
          }
        }
      }
    }

    return null;
  }
}