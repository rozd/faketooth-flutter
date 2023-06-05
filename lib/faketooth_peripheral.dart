part of faketooth;

/// A class that represents a Bluetooth Low Energy (BLE) peripheral in Faketooth.
///
/// This class defines the identifier, name, services, and advertisement data associated with the peripheral.
class FaketoothPeripheral {
  /// The identifier of the peripheral.
  final String identifier;

  /// The name of the peripheral.
  final String name;

  /// The list of services provided by the peripheral.
  final List<FaketoothService>? services;

  /// The advertisement data of the peripheral.
  final FaketoothAdvertisementData? advertisementData;

  /// Creates a new instance of [FaketoothPeripheral].
  ///
  /// The [identifier] and [name] parameters are required, while the [services] and [advertisementData] parameters are optional.
  const FaketoothPeripheral({
    required this.identifier,
    required this.name,
    this.services,
    this.advertisementData,
  });

  /// Converts the peripheral to a map of arguments.
  ///
  /// This method is useful for passing the peripheral as arguments to the Faketooth simulator.
  ///
  /// Example usage:
  /// ```dart
  /// FaketoothPeripheral peripheral = FaketoothPeripheral(
  ///   identifier: 'ABCD1234',
  ///   name: 'MyDevice',
  ///   services: [
  ///     FaketoothService(
  ///       uuid: '0000180f-0000-1000-8000-00805f9b34fb',
  ///       characteristics: [
  ///         FaketoothCharacteristic(
  ///           uuid: '00002a19-0000-1000-8000-00805f9b34fb',
  ///           properties: {FaketoothCharacteristicProperties.read},
  ///         ),
  ///       ],
  ///     ),
  ///   ],
  ///   advertisementData: FaketoothAdvertisementData(
  ///     localName: 'MyDevice',
  ///     serviceUUIDs: ['0000180f-0000-1000-8000-00805f9b34fb'],
  ///   ),
  /// );
  ///
  /// Map<String, dynamic> arguments = peripheral.toArguments();
  /// print(arguments);
  /// // Output: {identifier: 'ABCD1234', name: 'MyDevice', services: [...], advertisementData: {...}}
  /// ```
  Map<String, dynamic> toArguments() {
    return {
      'identifier': identifier,
      'name': name,
      'services': services?.map((e) => e.toArguments()).toList() ?? [],
      'advertisementData': advertisementData?.toArguments(),
    };
  }
}