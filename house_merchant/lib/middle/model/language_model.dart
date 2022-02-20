class LanguageModel {
  String? name;
  String? flag;
  String? locale;
  bool? selected;

  LanguageModel({this.name, this.flag, this.locale, this.selected});

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
        name: json['name'],
        flag: json['flag'],
        locale: json['locale'],
        selected: json['selected']);
  }

  LanguageModel.map(dynamic obj) {
    this.name = obj['name'];
    this.flag = obj['flag'];
    this.locale = obj['locale'];
    this.selected = obj['selected'];
  }

  Map<String, dynamic> toJson() =>
      {'name': name, 'flag': flag, 'locale': locale, 'selected': selected};
}
