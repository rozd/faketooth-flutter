import 'dart:typed_data';

import 'package:faketooth/faketooth.dart';

class BLESimulator {

  static Future initialize() async {
    await Faketooth.shared.setSimulatedPeripherals(
        [
          FaketoothPeripheral(
              identifier: 'E621E1F8-C36C-495A-93FC-0C247A3E6E5F',
              name: "TDP_SIMULATED",
              services: [
                FaketoothService(
                    uuid: '0000180A-0000-1000-8000-00805F9B34FB',
                    isPrimary: true,
                    characteristics: [
                      FaketoothCharacteristic(
                        uuid: '2A29',
                        properties: {
                          FaketoothCharacteristicProperties.read,
                          FaketoothCharacteristicProperties.notify,
                        },
                        valueProducer: () {
                          return Future.value(Uint8List.fromList('Hello'.codeUnits));
                        },
                      ),
                      FaketoothCharacteristic(
                          uuid: '2A24',
                          properties: {
                            FaketoothCharacteristicProperties.read,
                          },
                          valueProducer: () => Future.value(Uint8List.fromList([1]))
                      ),
                      FaketoothCharacteristic(
                          uuid: '2A25',
                          properties: {
                            FaketoothCharacteristicProperties.read,
                          },
                          valueProducer: () => Future.value(Uint8List.fromList('TEST_CHIP_ID'.codeUnits))
                      ),
                      FaketoothCharacteristic(
                          uuid: '2A26',
                          properties: {
                            FaketoothCharacteristicProperties.read,
                          },
                          valueProducer: () => Future.value(Uint8List.fromList([49, 46, 51]))
                      ),
                      FaketoothCharacteristic(
                          uuid: '2A27',
                          properties: {
                            FaketoothCharacteristicProperties.read,
                          },
                          valueProducer: () => Future.value(Uint8List.fromList([49, 46, 48]))
                      ),
                    ]
                ),
                FaketoothService(
                    uuid: '180F',
                    isPrimary: true,
                    characteristics: [
                      FaketoothCharacteristic(
                          uuid: '2A19',
                          properties: {
                            FaketoothCharacteristicProperties.read,
                            FaketoothCharacteristicProperties.notify,
                          },
                          descriptors: [
                            FaketoothDescriptor(
                                uuid: "2902",
                                initialValue: 0x0001,
                                valueProducer: () {
                                  print("2902");
                                  return Future.value(0x0001);
                                }
                            )
                          ],
                          valueProducer: () {
                            return Future.value(Uint8List.fromList([60]));
                          }
                      ),
                    ]
                ),
                FaketoothService(
                    uuid: '05f20300-9063-4809-baec-44e73c40f39c',
                    isPrimary: true,
                    characteristics: [
                      FaketoothCharacteristic(
                          uuid: '05f20303-9063-4809-baec-44e73c40f39c',
                          properties: {
                            FaketoothCharacteristicProperties.read,
                            FaketoothCharacteristicProperties.notify,
                          },
                          valueProducer: () {
                            return Future.value(Uint8List.fromList('42'.codeUnits));
                          }
                      ),
                      FaketoothCharacteristic(
                          uuid: '05f20304-9063-4809-baec-44e73c40f39c',
                          properties: {
                            FaketoothCharacteristicProperties.read,
                            FaketoothCharacteristicProperties.indicate,
                          },
                          valueProducer: () {
                            return Future.value(Uint8List.fromList('PU\tU'.codeUnits));
                          }
                      ),
                      FaketoothCharacteristic(
                          uuid: '05f20302-9063-4809-baec-44e73c40f39c',
                          properties: {
                            FaketoothCharacteristicProperties.read,
                            FaketoothCharacteristicProperties.indicate,
                          },
                          valueProducer: () {
                            return Future.value(Uint8List.fromList([0, 0, 0]));
                          }
                      ),
                      FaketoothCharacteristic(
                          uuid: '05f20301-9063-4809-baec-44e73c40f39c',
                          properties: {
                            FaketoothCharacteristicProperties.read,
                            FaketoothCharacteristicProperties.write,
                          },
                          valueProducer: () {
                            return Future.value(Uint8List.fromList([0, 0, 0]));
                          }
                      ),
                    ]
                )
              ]
          ),
        ]
    );
  }

}