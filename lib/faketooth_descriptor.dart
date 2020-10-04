part of faketooth;

class FaketoothDescriptor {
  final String uuid;
  final Future<dynamic> Function() valueProducer;
  final dynamic initialValue;

  const FaketoothDescriptor({
    @required this.uuid,
    this.valueProducer,
    this.initialValue,
  });

  Map<String, dynamic> toArguments() {
    return {
      'uuid'          : uuid,
      'initialValue'  : initialValue,
    };
  }
}