library faketooth;

import 'dart:async';
import 'dart:typed_data';

import 'package:faketooth/faketooth_advertisement_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

part 'faketooth_peripheral.dart';
part 'faketooth_service.dart';
part 'faketooth_characteristic.dart';
part 'faketooth_descriptor.dart';

class Faketooth {

  // MARK: Shared instance

  static final Faketooth shared = Faketooth._internal();

  // MARK: Properties

  MethodChannel _channel = const MethodChannel('faketooth');

  List<FaketoothPeripheral> _simulatedPeripherals;

  // MARK: Constructors

  factory Faketooth() {
    return shared;
  }

  Faketooth._internal() {
    _channel.setMethodCallHandler(handleMethodCall);
  }

  // MARK: Methods

  Future<bool> get isSimulated async {
    return await _channel.invokeMethod('isSimulated');
  }

  Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<void> setSimulatedPeripherals(List<FaketoothPeripheral> value) async {
    _simulatedPeripherals = value;
    await _channel.invokeMethod('setSimulatedPeripherals', _simulatedPeripherals.map((value) => value.toArguments()).toList());
  }

  // MARK: Handlers

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case "valueForCharacteristic":
        var characteristic = findCharacteristic(
            peripheral: call.arguments['peripheral'],
            uuid: call.arguments['uuid']
        );
        if (characteristic?.dataProducer == null) {
          return null;
        }
        return await characteristic.dataProducer();
      case "valueForDescriptor":
        var descriptor = findDescriptor(
          peripheral: call.arguments['peripheral'],
          uuid: call.arguments['uuid']
        );
        if (descriptor?.valueProducer == null) {
          return null;
        }
        return await descriptor.valueProducer();
      default:
        return null;
    }
  }

}

extension on Faketooth {

  FaketoothCharacteristic findCharacteristic({@required String peripheral, @required String uuid}) {
    if (_simulatedPeripherals == null || _simulatedPeripherals.isEmpty) {
      return null;
    }

    for (FaketoothPeripheral p in _simulatedPeripherals) {
      if (p.identifier?.toLowerCase() != peripheral?.toLowerCase()) {
        continue;
      }
      for (FaketoothService s in p.services) {
        for (FaketoothCharacteristic c in s.characteristics) {
          if (c.uuid?.toLowerCase() == uuid?.toLowerCase()) {
            return c;
          }
        }
      }
    }

    return null;
  }

  FaketoothDescriptor findDescriptor({@required String peripheral, @required String uuid}) {
    if (_simulatedPeripherals == null || _simulatedPeripherals.isEmpty) {
      return null;
    }

    for (FaketoothPeripheral p in _simulatedPeripherals) {
      if (p.identifier?.toLowerCase() != peripheral?.toLowerCase()) {
        continue;
      }
      for (FaketoothService s in p.services) {
        for (FaketoothCharacteristic c in s.characteristics) {
          for (FaketoothDescriptor d in c.descriptors) {
            if (d.uuid?.toLowerCase() == uuid?.toLowerCase()) {
              return d;
            }
          }
        }
      }
    }

    return null;
  }
}