import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:house_merchant/custom/button_create_widget.dart';
import 'package:house_merchant/screen/promotion/promotion_list_screen.dart';
import 'package:house_merchant/router.dart';
import 'package:house_merchant/screen/base/base_scaffold.dart';

class CouponScreen extends StatefulWidget {
  CouponScreen({Key key}) : super(key: key);

  @override
  CouponScreenState createState() => CouponScreenState();
}

class CouponScreenState extends State<CouponScreen> {
  Size _screenSize;
  double _padding;

  @override
  Widget build(BuildContext context) {
    this._screenSize = MediaQuery.of(context).size;
    this._padding = this._screenSize.width * 5 / 100;

    return BaseScaffold(
      title: 'Ưu đãi',
      trailing: Padding(
          child: ButtonCreateWidget(
            title: "Tạo mới",
            onPressed: () {
              Router.pushNoParams(context, Router.COUPON_CREATE);
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 25.0,
            ),
          ),
          padding: EdgeInsets.only(right: this._padding)),
      child: CouponListScreen(),
    );
  }
}
