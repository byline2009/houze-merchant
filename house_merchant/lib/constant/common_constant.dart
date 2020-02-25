import 'dart:io';

class CommonConstant {
  static const String tokenType = 'Bearer';
  static const int maxImage = 5;
  static const int pagingLimit = 10;
}

class Promotion {
  static const String pending = 'CHỜ DUYỆT';
  static const String approved = 'ĐANG CHẠY';
  static const String expire = 'HẾT HẠN';
  static const String rejected = 'BỊ TỪ CHỐI';
  static const String canceled = 'ĐÃ HỦY';

  static const int pendingStatus = 0;
  static const int approveStatus = 1;
  static const int rejectStatus = 2;
  static const int canceledStatus = 3;
}

String DEVICE_TYPE = (Platform.isAndroid == true) ? "gcm" : "apple";
