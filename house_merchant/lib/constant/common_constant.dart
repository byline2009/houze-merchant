import 'dart:io';

class CommonConstant {
  static const String tokenType = 'Bearer';
  static const int maxImage = 5;
  static const int pagingLimit = 10;
}

class Promotion {
  static const String pending = 'CHỜ DUYỆT';
  static const String approve = 'ĐANG CHẠY';
  static const String expire = 'HẾT HẠN';

  static const int pendingStatus = 0;
  static const int approveStatus = 1;
  static const int expireStatus = 2;
}

String DEVICE_TYPE = (Platform.isAndroid == true) ? "gcm" : "apple";
