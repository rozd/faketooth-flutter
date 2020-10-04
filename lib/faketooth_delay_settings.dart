part of faketooth;

class FaketoothDelaySettings {
  final double scanForPeripheralDelayInSeconds;
  final double connectPeripheralDelayInSeconds;
  final double cancelPeripheralConnectionDelayInSeconds;
  final double discoverServicesDelayInSeconds;
  final double discoverCharacteristicsDelayInSeconds;
  final double discoverIncludedServicesDelayInSeconds;
  final double discoverDescriptorsForCharacteristicDelayInSeconds;
  final double readValueForCharacteristicDelayInSeconds;
  final double writeValueForCharacteristicDelayInSeconds;
  final double readValueForDescriptorDelayInSeconds;
  final double writeValueForDescriptorDelayInSeconds;

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