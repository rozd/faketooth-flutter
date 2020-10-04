part of faketooth;

class FaketoothService {
  final String uuid;
  final bool isPrimary;
  final List<FaketoothCharacteristic> characteristics;
  final List<FaketoothService> includedServices;

  const FaketoothService({
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
