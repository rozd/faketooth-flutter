part of faketooth;

class FaketoothCharacteristic {
  String uuid;
  Future<Uint8List> Function() dataProducer;
  Set<FaketoothCharacteristicProperties> properties;
  bool isNotifying;
  List<FaketoothDescriptor> descriptors;

  FaketoothCharacteristic({
    @required this.uuid,
    @required this.properties,
    this.isNotifying,
    this.descriptors,
    this.dataProducer
  });

  Map<String, dynamic> toArguments() {
    return {
      'uuid'        : uuid,
      'properties'  : properties.map((e) => e.index).reduce((value, element) => value | element),
      'isNotifying' : isNotifying,
      'descriptors' : descriptors?.map((e) => e.toArguments())?.toList() ?? []
    };
  }
}

enum FaketoothCharacteristicProperties {
  broadcast,
  read,
  writeWithoutResponse,
  write,
  notify,
  indicate,
  authenticatedSignedWrites,
  extendedProperties,
  notifyEncryptionRequired,
  indicateEncryptionRequired,
}