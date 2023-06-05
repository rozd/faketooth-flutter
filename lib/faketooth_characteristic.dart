part of faketooth;

/// A class that represents a Bluetooth Low Energy (BLE) characteristic in Faketooth.
///
/// This class defines the properties and behavior of a BLE characteristic, including its UUID, properties, descriptors,
/// initial value, value producer, and value handler.
class FaketoothCharacteristic {
  /// The UUID of the characteristic.
  final String uuid;

  /// The set of properties associated with the characteristic.
  final Set<FaketoothCharacteristicProperties> properties;

  /// The list of descriptors associated with the characteristic.
  final List<FaketoothDescriptor>? descriptors;

  /// A function that produces the value of the characteristic.
  final Future<Uint8List> Function()? valueProducer;

  /// A function that handles the value changes of the characteristic.
  final void Function(Uint8List?)? valueHandler;

  /// The initial value of the characteristic.
  final Uint8List? initialValue;

  /// Creates a new instance of [FaketoothCharacteristic].
  ///
  /// The [uuid] and [properties] parameters are required, while the [descriptors], [initialValue], [valueProducer], and [valueHandler]
  /// parameters are optional.
  const FaketoothCharacteristic({
    required this.uuid,
    required this.properties,
    this.descriptors,
    this.initialValue,
    this.valueProducer,
    this.valueHandler,
  });

  /// Converts the characteristic to a map of arguments.
  ///
  /// This method is useful for passing the characteristic as arguments to the Faketooth simulator.
  ///
  /// Example usage:
  /// ```dart
  /// FaketoothCharacteristic characteristic = FaketoothCharacteristic(
  ///   uuid: '00002a37-0000-1000-8000-00805f9b34fb',
  ///   properties: {
  ///     FaketoothCharacteristicProperties.read,
  ///     FaketoothCharacteristicProperties.write,
  ///   },
  ///   descriptors: [
  ///     FaketoothDescriptor(
  ///       uuid: '00002902-0000-1000-8000-00805f9b34fb',
  ///       value: Uint8List.fromList([0x00, 0x00]),
  ///     ),
  ///   ],
  /// );
  ///
  /// Map<String, dynamic> arguments = characteristic.toArguments();
  /// print(arguments);
  /// // Output: {uuid: '00002a37-0000-1000-8000-00805f9b34fb', properties: ['read', 'write'], ...}
  /// ```
  Map<String, dynamic> toArguments() {
    return {
      'uuid'        : uuid,
      'properties'  : properties.map((e) => e.code).toList(),
      'descriptors' : descriptors?.map((e) => e.toArguments()).toList() ?? [],
      "initialValue": initialValue,
    };
  }
}

/// An enum that represents the properties of a Bluetooth Low Energy (BLE) characteristic in Faketooth.
///
/// The properties define the behavior and capabilities of a characteristic.
enum FaketoothCharacteristicProperties {
  /// The characteristic supports broadcasting.
  broadcast,

  /// The characteristic supports reading.
  read,

  /// The characteristic supports writing without response.
  writeWithoutResponse,

  /// The characteristic supports writing.
  write,

  /// The characteristic supports notifications.
  notify,

  /// The characteristic supports indications.
  indicate,

  /// The characteristic supports authenticated signed writes.
  authenticatedSignedWrites,

  /// The characteristic has extended properties.
  extendedProperties,

  /// The characteristic requires encryption for notifications.
  notifyEncryptionRequired,

  /// The characteristic requires encryption for indications.
  indicateEncryptionRequired,
}

extension FaketoothCharacteristicPropertiesCode on FaketoothCharacteristicProperties {
  /// Retrieves the code corresponding to the characteristic property.
  ///
  /// The code is used internally by Faketooth for configuration and communication.
  /// Returns `null` if the characteristic property is not recognized.
  String? get code {
    switch (this) {
      case FaketoothCharacteristicProperties.broadcast                  : return "broadcast";
      case FaketoothCharacteristicProperties.read                       : return "read";
      case FaketoothCharacteristicProperties.writeWithoutResponse       : return "writeWithoutResponse";
      case FaketoothCharacteristicProperties.write                      : return "write";
      case FaketoothCharacteristicProperties.notify                     : return "notify";
      case FaketoothCharacteristicProperties.indicate                   : return "indicate";
      case FaketoothCharacteristicProperties.authenticatedSignedWrites  : return "authenticatedSignedWrites";
      case FaketoothCharacteristicProperties.extendedProperties         : return "extendedProperties";
      case FaketoothCharacteristicProperties.notifyEncryptionRequired   : return "notifyEncryptionRequired";
      case FaketoothCharacteristicProperties.indicateEncryptionRequired : return "indicateEncryptionRequired";
      default: return null;
    }
  }
}