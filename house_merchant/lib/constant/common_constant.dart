import 'dart:io';

class CommonConstant {
  static const String tokenType = 'Bearer';
  static const int maxImage = 5;
  static const int pagingLimit = 10;
}

class Format {
  static const String timeAndDate = 'HH:mm - dd/MM/yyyy';
}

class Promotion {
  static const String pending = 'Chờ duyệt';
  static const String approved = 'Đang chạy';
  static const String expire = 'Hết hạn';
  static const String rejected = 'Bị từ chối';
  static const String canceled = 'Đã hủy';

  static const int pendingStatus = 0;
  static const int approveStatus = 1;
  static const int rejectStatus = 2;
  static const int canceledStatus = 3;
}

String deviceType = (Platform.isAndroid == true) ? "gcm" : "apple";
