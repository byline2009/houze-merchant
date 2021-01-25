import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';

class NotificationModel {
  String icon;
  String title;
  String content;
  bool isRead;

  NotificationModel({this.icon, this.title, this.content, this.isRead});
}

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key key}) : super(key: key);

  @override
  NotificationScreenState createState() => new NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  List notifications;

  @override
  void initState() {
    notifications = getNotificationList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notificationEmptyView = Container(
        child: Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 200.0),
          SvgPicture.asset('assets/images/ic-notification-empty.svg',
              width: 80.0, height: 80.0),
          SizedBox(height: 10.0),
          Text(
            'Không có thông báo nào',
            style: TextStyle(
                fontSize: 16.0,
                color: ThemeConstant.grey_color,
                letterSpacing: 0.26,
                fontWeight: ThemeConstant.appbar_text_weight),
          )
        ],
      ),
    ));

    return BaseScaffoldNormal(
      title: 'Thông báo',
      child: Container(
          color: ThemeConstant.background_grey_color,
          child:
              notificationEmptyView //notifications.length == 0 ? notificationEmptyView : makeBody,
          ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

List getNotificationList() {
  return [
    NotificationModel(
        icon: '',
        title: "Ưu đãi đã kết thúc thời hạn",
        content: "Tặng ngay 20 mã khuyến mãi cho khách hàng nữ",
        isRead: false),
    NotificationModel(
        icon: '',
        title: "Ưu đãi đã được duyệt",
        content: "Ưu đãi 25% mừng Lễ Giáng Sinh 2019",
        isRead: false),
    NotificationModel(
        icon: '',
        title: "Có đơn hàng mới!",
        content: "Tổng hoá đơn: 125,000 vnd",
        isRead: false),
    NotificationModel(
        icon: '',
        title: "Ưu đãi đã kết thúc thời hạn",
        content: "Tặng ngay 20 mã khuyến mãi cho khách hàng nữ",
        isRead: false),
    NotificationModel(
        icon: '',
        title: "Ưu đãi đã được duyệt",
        content: "Ưu đãi 25% mừng Lễ Giáng Sinh 2019",
        isRead: true),
    NotificationModel(
        icon: '',
        title: "Ưu đãi đã kết thúc thời hạn",
        content: "Tặng ngay 20 mã khuyến mãi cho khách hàng nữ",
        isRead: true),
    NotificationModel(
        icon: '',
        title: "Ưu đãi đã được duyệt",
        content: "Ưu đãi 25% mừng Lễ Giáng Sinh 2019",
        isRead: true),
  ];
}
