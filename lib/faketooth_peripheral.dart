part of faketooth;

class FaketoothPeripheral {
  String identifier;
  String name;
  List<FaketoothService> services;
  FaketoothAdvertisementData advertisementData;

  FaketoothPeripheral({
    @required this.identifier,
    @required this.name,
    this.services,
    this.advertisementData,
  });

  Map<String, dynamic> toArguments() {
    return {
      'identifier'  : identifier,
      'name'        : name,
      'services'    : services?.map((e) => e.toArguments())?.toList() ?? []
    };
  }
}