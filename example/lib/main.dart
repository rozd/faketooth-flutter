import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:faketooth/faketooth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _isSimulated     = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    Object simulated;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await Faketooth.shared.setSimulatedPeripherals(
          [
            FaketoothPeripheral(
                identifier: 'E621E1F8-C36C-495A-93FC-0C247A3E6E5F',
                name: "Test",
                services: [
                  FaketoothService(
                      uuid: 'E621E1F8-C36C-495A-93FC-0C247A3E6E5F',
                      characteristics: [
                        FaketoothCharacteristic(
                            uuid: 'E621E1F8-C36C-495A-93FC-000000000001',
                            isNotifying: false,
                            properties: {FaketoothCharacteristicProperties.read, FaketoothCharacteristicProperties.notify},
                            dataProducer: () {
                              return Future.value(Uint8List.fromList('Hello'.codeUnits));
                            },
                        )
                      ]
                  )
                ]
            )
          ]
      );
      platformVersion = await Faketooth.shared.platformVersion;
      simulated = await Faketooth.shared.isSimulated;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
      simulated = 'Unknown';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _isSimulated     = simulated ? 'Yes' : 'No';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('Running on: $_platformVersion\nisSimulated: $_isSimulated'),
            ],
          ),
        ),
      ),
    );
  }

}
