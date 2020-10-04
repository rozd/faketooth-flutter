part of faketooth;

class FaketoothService {
  String uuid;
  bool isPrimary;
  List<FaketoothCharacteristic> characteristics;
  List<FaketoothService> includedServices;

  FaketoothService({
    @required this.uuid,
    @required this.isPrimary,
    this.characteristics,
    this.includedServices
  });

  Map<String, dynamic> toArguments() {
    return {
      'uuid'             : uuid,
      'isPrimary'        : isPrimary,
      'characteristics'  : characteristics?.map((e) => e.toArguments())?.toList(),
      'includedServices' : includedServices?.map((e) => e.toArguments())?.toList()
    };
  }
}
