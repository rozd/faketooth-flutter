# Faketooth Flutter Plugin

The Faketooth Flutter Plugin allows you to emulate a Bluetooth Low Energy (BLE) device on iOS, macOS, watchOS, and tvOS targets from within your Flutter applications. This plugin leverages the [`faketooth`](https://github.com/rozd/faketooth) library for iOS/macOS/watchOS/tvOS, enabling you to create virtual peripherals with custom services, characteristics, descriptors, and values.

## Installation

To use the Faketooth Flutter Plugin, you need to add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  faketooth_flutter: ^0.2.0
```

Then, run `flutter pub get` to fetch the plugin.

## Usage

Follow the steps below to start using the Faketooth Flutter Plugin:

1. Import the package in your Dart code:

```dart
import 'package:faketooth_flutter/faketooth_flutter.dart';
```

2. Set up the simulated peripherals by calling the `setSimulatedPeripherals` method on the `Faketooth` singleton instance. Pass in a list of `FaketoothPeripheral` objects to define the virtual BLE devices you want to emulate.

Here's an example that demonstrates the basic usage:

```dart
await Faketooth.shared.setSimulatedPeripherals([
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
          // Add more characteristics and services as needed
        ],
      ),
      // Add more services as needed
    ],
  ),
  // Add more peripherals as needed
]);
```

In this example, we create a single virtual peripheral named "TDP_SIMULATED" with a primary service. The service contains a characteristic with read and notify properties. You can add more characteristics and services based on your requirements.

3. Build and run your Flutter application. Faketooth will simulate the BLE interface and make it possible to interact with your virtual peripherals as if they were real devices.

## Example

To see the Faketooth Flutter Plugin in action, you can check out the example provided in the [Faketooth Flutter](https://github.com/rozd/faketooth-flutter/tree/master/example) repository. It demonstrates how to set up and use the plugin within a Flutter project.

## Contributions and Support

Contributions to the Faketooth Flutter Plugin are welcome! If you encounter any issues, have questions, or would like to suggest improvements, please open an issue on the [GitHub repository](https://github.com/rozd/faketooth-flutter).

## License

The Faketooth Flutter Plugin is released under the MIT license. See the [LICENSE](https://github.com/rozd/faketooth-flutter/blob/main/LICENSE) file for more information.

---

Thank you for using the Faketooth Flutter Plugin! I hope this plugin simplifies your BLE testing and development workflows. If you find it helpful, please consider giving it a star on [GitHub](https://github.com/rozd/faketooth-fl
