import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key key}) : super(key: key);

  @override
  NotificationScreenState createState() => new NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  Size _screenSize;
  BuildContext _context;
  //Form controller

  @override
  void initState() {
    super.initState();
  }

  Widget notificationEmptyView = Container(
      child: Center(
    child: Column(
      // mainAxisAlignment: MainAxisAlignment.center,
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

  @override
  Widget build(BuildContext context) {
    this._screenSize = MediaQuery.of(context).size;
    this._context = context;

    return BaseScaffoldNormal(
      title: 'Thông báo',
      child: Container(
        color: ThemeConstant.background_grey_color,
        child: notificationEmptyView,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
