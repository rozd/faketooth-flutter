class FaketoothAdvertisementData {
  final String localName;
  final List<String> serviceUUIDs;

  FaketoothAdvertisementData({this.localName, this.serviceUUIDs});

  Map<String, dynamic> toArguments() {
    return {
      'localName'   : localName,
      'serviceUUIDs': serviceUUIDs,
    };
  }
}