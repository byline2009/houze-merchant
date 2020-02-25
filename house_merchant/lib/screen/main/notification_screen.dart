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
    Container makeListTile(NotificationModel noti) => Container(
        decoration: BoxDecoration(
            color: noti.isRead
                ? ThemeConstant.white_color
                : ThemeConstant.listview_selected_color),
        child: ListTile(
            contentPadding: EdgeInsets.only(left: 20.0),
            leading: Container(
              width: 40,
              height: 40,
              child: SvgPicture.asset(noti.isRead
                  ? "assets/images/ic-order-empty.svg"
                  : "assets/images/ic-promotion-highlight.svg"),
            ),
            title: Text(
              noti.title,
              style: TextStyle(
                  color: Colors.black, fontSize: 15, letterSpacing: 0.24),
            ),
            subtitle: Row(
              children: <Widget>[
                Expanded(
                    flex: 4,
                    child: Text(noti.content,
                        style: TextStyle(
                            color: ThemeConstant.grey_color,
                            fontSize: 12,
                            letterSpacing: 0.24))),
              ],
            ),
            onTap: () {
              print(noti.title);
            }));

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

    final makeBody = Container(
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: notifications.length,
        itemBuilder: (BuildContext context, int index) {
          return makeListTile(notifications[index]);
        },
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 2, color: ThemeConstant.background_grey_color),
      ),
    );

    return BaseScaffoldNormal(
      title: 'Thông báo',
      child: Container(
        color: ThemeConstant.background_grey_color,
        child: notifications.length == 0 ? notificationEmptyView : makeBody,
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
