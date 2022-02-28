import 'package:house_merchant/middle/model/language_model.dart';

class AppConstant {
  static const String locateVI = 'vi';
  static const String locateEN = 'en';
  static final List<LanguageModel> languages = [
    LanguageModel(
      name: 'Tiếng Việt',
      flag: AppVectors.icViet,
      locale: AppConstant.locateVI,
    ),
    LanguageModel(
      name: 'English',
      flag: AppVectors.icEnglish,
      locale: AppConstant.locateEN,
    )
  ];
}

class AppVectors {
  static const String svgPath = 'assets/svg/';

  static const String icViet = svgPath + 'login/ic_viet.svg';
  static const String icEnglish = svgPath + 'login/ic_english.svg';
}
