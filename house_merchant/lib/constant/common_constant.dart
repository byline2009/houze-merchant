import 'dart:io';

import 'package:house_merchant/custom/group_radio_tags_widget.dart';

class CommonConstant {
  static const String tokenType = 'Bearer';
  static const int maxImage = 5;
  static const int pagingLimit = 10;
}

class Format {
  static const String timeAndDate = 'HH:mm - dd/MM/yyyy';
}

class Promotion {
  static const String all = 'Tất cả';
  static const String pending = 'Chờ duyệt';
  static const String approved = 'Đang chạy';
  static const String expire = 'Hết hạn';
  static const String rejected = 'Bị từ chối';
  static const String canceled = 'Đã hủy';

  static const int expiredStatus = -2;
  static const int allStatus = -1;
  static const int pendingStatus = 0;
  static const int approveStatus = 1;
  static const int rejectStatus = 2;
  static const int canceledStatus = 3;

  static final List<GroupRadioTags> statusTags = [
    GroupRadioTags(id: Promotion.allStatus, title: Promotion.all),
    GroupRadioTags(id: Promotion.approveStatus, title: Promotion.approved),
    GroupRadioTags(id: Promotion.pendingStatus, title: Promotion.pending),
    GroupRadioTags(id: Promotion.expiredStatus, title: Promotion.expire),
    GroupRadioTags(id: Promotion.rejectStatus, title: Promotion.rejected),
    GroupRadioTags(id: Promotion.canceledStatus, title: Promotion.canceled),
  ];
}

String deviceType = (Platform.isAndroid == true) ? "gcm" : "apple";
