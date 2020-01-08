import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_merchant/constant/theme_constant.dart';

class ComingSoonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(top: 140.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SvgPicture.asset(
            'assets/images/ic-comming-soon.svg',
            width: 100.0,
            height: 100.0,
          ),
          SizedBox(height: 20.0),
          Text(
            'Tính năng đang hoàn thiện\nSẽ ra mắt trong thời gian tới',
            style: TextStyle(
                fontSize: 16.0,
                color: ThemeConstant.grey_color,
                letterSpacing: 0.26,
                fontWeight: ThemeConstant.appbar_text_weight),
          )
        ],
      ),
    );
    ;
  }
}
