part of faketooth;

/// A class that represents a Bluetooth Low Energy (BLE) service in Faketooth.
///
/// This class defines the UUID, primary status, characteristics, and included services of a BLE service.
class FaketoothService {
  /// The UUID of the service.
  final String uuid;

  /// A boolean indicating whether the service is primary or secondary.
  final bool isPrimary;

  /// The list of characteristics provided by the service.
  final List<FaketoothCharacteristic>? characteristics;

  /// The list of included services in the service.
  final List<FaketoothService>? includedServices;

  /// Creates a new instance of [FaketoothService].
  ///
  /// The [uuid] and [isPrimary] parameters are required, while the [characteristics] and [includedServices] parameters are optional.
  const FaketoothService({
    required this.uuid,
    required this.isPrimary,
    this.characteristics,
    this.includedServices,
  });

  /// Converts the service to a map of arguments.
  ///
  /// This method is useful for passing the service as arguments to the Faketooth simulator.
  ///
  /// Example usage:
  /// ```dart
  /// FaketoothService service = FaketoothService(
  ///   uuid: '0000180f-0000-1000-8000-00805f9b34fb',
  ///   isPrimary: true,
  ///   characteristics: [
  ///     FaketoothCharacteristic(
  ///       uuid: '00002a19-0000-1000-8000-00805f9b34fb',
  ///       properties: {FaketoothCharacteristicProperties.read},
  ///     ),
  ///   ],
  /// );
  ///
  /// Map<String, dynamic> arguments = service.toArguments();
  /// print(arguments);
  /// // Output: {uuid: '0000180f-0000-1000-8000-00805f9b34fb', isPrimary: true, characteristics: [...]}
  /// ```
  Map<String, dynamic> toArguments() {
    return {
      'uuid'             : uuid,
      'isPrimary'        : isPrimary,
      'characteristics'  : characteristics?.map((e) => e.toArguments()).toList(),
      'includedServices' : includedServices?.map((e) => e.toArguments()).toList(),
    };
  }
}