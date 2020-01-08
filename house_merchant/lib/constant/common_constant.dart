import 'dart:io';

class CommonConstant {
  static const String tokenType = 'Bearer';
  static const int maxImage = 5;
  static const int pagingLimit = 10;
}

String DEVICE_TYPE = (Platform.isAndroid == true) ? "gcm" : "apple";