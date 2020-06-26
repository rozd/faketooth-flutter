part of faketooth;

class FaketoothDescriptor {
  String uuid;
  Uint8List Function() valueProducer;

  Map<String, dynamic> toArguments() {
    return {
      'uuid': uuid
    };
  }
}