part of faketooth;

class FaketoothDescriptor {
  final String uuid;
  final Future<Uint8List> Function() valueProducer;

  FaketoothDescriptor({
    @required this.uuid,
    this.valueProducer,
  });

  Map<String, dynamic> toArguments() {
    return {
      'uuid': uuid
    };
  }
}