part of faketooth;

/// A class that defines delay settings for simulating Bluetooth Low Energy (BLE) operations in Faketooth.
///
/// This class allows you to configure delays for various BLE operations performed by the Faketooth simulator.
/// You can customize the delay duration for scanning peripherals, connecting peripherals, canceling peripheral connections,
/// discovering services, discovering characteristics, discovering included services, discovering descriptors for characteristics,
/// reading values for characteristics, writing values for characteristics, reading values for descriptors, and writing values for descriptors.
///
/// Example usage:
/// ```dart
/// FaketoothDelaySettings delaySettings = FaketoothDelaySettings(
///   scanForPeripheralDelayInSeconds: 2.0,
///   connectPeripheralDelayInSeconds: 3.0,
/// );
/// ```
class FaketoothDelaySettings {
  /// The delay duration in seconds for scanning peripherals.
  final double scanForPeripheralDelayInSeconds;

  /// The delay duration in seconds for connecting peripherals.
  final double connectPeripheralDelayInSeconds;

  /// The delay duration in seconds for canceling peripheral connections.
  final double cancelPeripheralConnectionDelayInSeconds;

  /// The delay duration in seconds for discovering services.
  final double discoverServicesDelayInSeconds;

  /// The delay duration in seconds for discovering characteristics.
  final double discoverCharacteristicsDelayInSeconds;

  /// The delay duration in seconds for discovering included services.
  final double discoverIncludedServicesDelayInSeconds;

  /// The delay duration in seconds for discovering descriptors for characteristics.
  final double discoverDescriptorsForCharacteristicDelayInSeconds;

  /// The delay duration in seconds for reading values for characteristics.
  final double readValueForCharacteristicDelayInSeconds;

  /// The delay duration in seconds for writing values for characteristics.
  final double writeValueForCharacteristicDelayInSeconds;

  /// The delay duration in seconds for reading values for descriptors.
  final double readValueForDescriptorDelayInSeconds;

  /// The delay duration in seconds for writing values for descriptors.
  final double writeValueForDescriptorDelayInSeconds;

  /// Creates a new instance of [FaketoothDelaySettings].
  const FaketoothDelaySettings({
    this.scanForPeripheralDelayInSeconds = 1.0,
    this.connectPeripheralDelayInSeconds = 1.0,
    this.cancelPeripheralConnectionDelayInSeconds = 1.0,
    this.discoverServicesDelayInSeconds = 0.1,
    this.discoverCharacteristicsDelayInSeconds = 0.1,
    this.discoverIncludedServicesDelayInSeconds = 0.1,
    this.discoverDescriptorsForCharacteristicDelayInSeconds = 0.1,
    this.readValueForCharacteristicDelayInSeconds = 0.1,
    this.writeValueForCharacteristicDelayInSeconds = 0.1,
    this.readValueForDescriptorDelayInSeconds = 0.1,
    this.writeValueForDescriptorDelayInSeconds = 0.1,
  });

  /// Converts the delay settings to a map of argument names and delay durations.
  ///
  /// This method is useful for passing the delay settings as arguments to the Faketooth simulator.
  ///
  Map<String, double> toArguments() {
    return {
      "scanForPeripheralDelayInSeconds"                     : scanForPeripheralDelayInSeconds,
      "connectPeripheralDelayInSeconds"                     : connectPeripheralDelayInSeconds,
      "cancelPeripheralConnectionDelayInSeconds"            : cancelPeripheralConnectionDelayInSeconds,
      "discoverServicesDelayInSeconds"                      : discoverServicesDelayInSeconds,
      "discoverCharacteristicsDelayInSeconds"               : discoverCharacteristicsDelayInSeconds,
      "discoverIncludedServicesDelayInSeconds"              : discoverIncludedServicesDelayInSeconds,
      "discoverDescriptorsForCharacteristicDelayInSeconds"  : discoverDescriptorsForCharacteristicDelayInSeconds,
      "readValueForCharacteristicDelayInSeconds"            : readValueForCharacteristicDelayInSeconds,
      "writeValueForCharacteristicDelayInSeconds"           : writeValueForCharacteristicDelayInSeconds,
      "readValueForDescriptorDelayInSeconds"                : readValueForDescriptorDelayInSeconds,
      "writeValueForDescriptorDelayInSeconds"               : writeValueForDescriptorDelayInSeconds,
    };
  }
}