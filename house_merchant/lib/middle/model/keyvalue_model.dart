//Create a Model class to hold key-value pair data
class KeyValueModel {
  dynamic key;
  String value;

  KeyValueModel({this.key, this.value});

  factory KeyValueModel.fromJson(KeyValueModel json) {
    return KeyValueModel(
      key: json.key,
      value: json.value,
    );
  }
}