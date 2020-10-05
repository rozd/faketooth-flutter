part of faketooth;

class FaketoothDescriptor {
  final String uuid;
  final Future<dynamic> Function() valueProducer;
  final void Function(dynamic) valueHandler;
  final dynamic initialValue;

  const FaketoothDescriptor({
    @required this.uuid,
    this.initialValue,
    this.valueProducer,
    this.valueHandler,
  });

  Map<String, dynamic> toArguments() {
    return {
      'uuid'          : uuid,
      'initialValue'  : initialValue,
    };
  }
}