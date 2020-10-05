part of faketooth;

class FaketoothCharacteristic {
  final String uuid;
  final Set<FaketoothCharacteristicProperties> properties;
  final List<FaketoothDescriptor> descriptors;
  final Future<Uint8List> Function() valueProducer;
  final void Function(Uint8List) valueHandler;
  final Uint8List initialValue;

  const FaketoothCharacteristic({
    @required this.uuid,
    @required this.properties,
    this.descriptors,
    this.initialValue,
    this.valueProducer,
    this.valueHandler,
  });

  Map<String, dynamic> toArguments() {
    return {
      'uuid'        : uuid,
      'properties'  : properties.map((e) => e.code).toList(),
      'descriptors' : descriptors?.map((e) => e.toArguments())?.toList() ?? [],
      "initialValue": initialValue,
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

extension FaketoothCharacteristicPropertiesCode on FaketoothCharacteristicProperties {
  String get code {
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