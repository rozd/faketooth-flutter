part of faketooth;

class FaketoothAdvertisementData {
  final String localName;
  final List<String> serviceUUIDs;

  const FaketoothAdvertisementData({
    this.localName,
    this.serviceUUIDs
  });

  Map<String, dynamic> toArguments() {
    return {
      'localName'   : localName,
      'serviceUUIDs': serviceUUIDs,
    };
  }
}