import 'dart:typed_data';

import 'package:faketooth_example/ble_simulator.dart';
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
      await BLESimulator.initialize();
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
