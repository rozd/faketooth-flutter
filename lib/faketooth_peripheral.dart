part of faketooth;

class FaketoothPeripheral {
  String identifier;
  String name;
  List<FaketoothService> services;
  FaketoothPeripheral({@required this.identifier, @required this.name, this.services});

  Map<String, dynamic> toArguments() {
    return {
      'identifier'  : identifier,
      'name'        : name,
      'services'    : services.map((e) => e.toArguments()).toList()
    };
  }
}