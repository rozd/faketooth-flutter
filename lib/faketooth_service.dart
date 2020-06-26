part of faketooth;

class FaketoothService {
  String uuid;
  List<FaketoothCharacteristic> characteristics;
  List<FaketoothService> includedServices;
  FaketoothService({@required this.uuid, this.characteristics, this.includedServices});

  Map<String, dynamic> toArguments() {
    return {
      'characteristics'  : characteristics?.map((e) => e.toArguments())?.toList(),
      'includedServices' : includedServices?.map((e) => e.toArguments())?.toList()
    };
  }
}