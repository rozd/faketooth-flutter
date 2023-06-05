part of faketooth;

/// A class that represents the advertisement data for a Bluetooth Low Energy (BLE) peripheral in Faketooth.
///
/// This class defines the local name and service UUIDs associated with the peripheral's advertisement data.
class FaketoothAdvertisementData {
  /// The local name of the peripheral.
  final String? localName;

  /// The list of service UUIDs provided by the peripheral.
  final List<String>? serviceUUIDs;

  /// Creates a new instance of [FaketoothAdvertisementData].
  ///
  /// The [localName] and [serviceUUIDs] parameters are optional.
  const FaketoothAdvertisementData({
    this.localName,
    this.serviceUUIDs
  });

  /// Converts the advertisement data to a map of arguments.
  ///
  /// This method is useful for passing the advertisement data as arguments to the Faketooth simulator.
  ///
  /// Example usage:
  /// ```dart
  /// FaketoothAdvertisementData advertisementData = FaketoothAdvertisementData(
  ///   localName: 'MyDevice',
  ///   serviceUUIDs: ['0000180f-0000-1000-8000-00805f9b34fb', '0000180a-0000-1000-8000-00805f9b34fb'],
  /// );
  ///
  /// Map<String, dynamic> arguments = advertisementData.toArguments();
  /// print(arguments);
  /// // Output: {localName: 'MyDevice', serviceUUIDs: ['0000180f-0000-1000-8000-00805f9b34fb', '0000180a-0000-1000-8000-00805f9b34fb']}
  /// ```
  Map<String, dynamic> toArguments() {
    return {
      'localName'   : localName,
      'serviceUUIDs': serviceUUIDs,
    };
  }
}