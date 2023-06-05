part of faketooth;

/// A class that represents a Bluetooth Low Energy (BLE) descriptor in Faketooth.
///
/// This class defines the UUID, value producer, value handler, and initial value of a BLE descriptor.
class FaketoothDescriptor {
  /// The UUID of the descriptor.
  final String uuid;

  /// A function that produces the value of the descriptor.
  final Future<dynamic> Function()? valueProducer;

  /// A function that handles the value changes of the descriptor.
  final void Function(dynamic)? valueHandler;

  /// The initial value of the descriptor.
  final dynamic initialValue;

  /// Creates a new instance of [FaketoothDescriptor].
  ///
  /// The [uuid] parameter is required, while the [valueProducer], [valueHandler], and [initialValue] parameters are optional.
  const FaketoothDescriptor({
    required this.uuid,
    this.initialValue,
    this.valueProducer,
    this.valueHandler,
  });

  /// Converts the descriptor to a map of arguments.
  ///
  /// This method is useful for passing the descriptor as arguments to the Faketooth simulator.
  ///
  /// Example usage:
  /// ```dart
  /// FaketoothDescriptor descriptor = FaketoothDescriptor(
  ///   uuid: '00002902-0000-1000-8000-00805f9b34fb',
  ///   initialValue: Uint8List.fromList([0x00, 0x00]),
  /// );
  ///
  /// Map<String, dynamic> arguments = descriptor.toArguments();
  /// print(arguments);
  /// // Output: {uuid: '00002902-0000-1000-8000-00805f9b34fb', initialValue: Uint8List.fromList([0x00, 0x00])}
  /// ```
  Map<String, dynamic> toArguments() {
    return {
      'uuid'          : uuid,
      'initialValue'  : initialValue,
    };
  }
}