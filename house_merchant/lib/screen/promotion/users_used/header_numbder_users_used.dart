import 'package:flutter/material.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:house_merchant/screen/base/base_widget.dart';

class HeaderNumberUsersUsed extends StatelessWidget {
  final CouponModel couponModel;
  const HeaderNumberUsersUsed({@required this.couponModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(couponModel.title,
              style: ThemeConstant.titleLargeStyle(ThemeConstant.black_color)),
          SizedBox(height: 12),
          BaseWidget.dividerBottom,
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                couponModel.getNumberOfUsersUsed(),
                style:
                    ThemeConstant.titleLargeStyle(ThemeConstant.primary_color),
              ),
              SizedBox(width: 5.0),
              Text(
                'Lượt sử dụng',
                style: TextStyle(
                    fontSize: ThemeConstant.font_size_16,
                    letterSpacing: ThemeConstant.letter_spacing_026,
                    color: ThemeConstant.grey_color),
              ),
            ],
          )
        ],
      ),
    );
  }
}
