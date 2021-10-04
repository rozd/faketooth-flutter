part of faketooth;

class FaketoothPeripheral {
  final String identifier;
  final String name;
  final List<FaketoothService>? services;
  final FaketoothAdvertisementData? advertisementData;

  const FaketoothPeripheral({
    required this.identifier,
    required this.name,
    this.services,
    this.advertisementData,
  });

  Map<String, dynamic> toArguments() {
    return {
      'identifier'  : identifier,
      'name'        : name,
      'services'    : services?.map((e) => e.toArguments()).toList() ?? []
    };
  }
}