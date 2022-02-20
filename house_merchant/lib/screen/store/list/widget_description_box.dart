import 'package:flutter/material.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/utils/localizations_util.dart';

class DescriptionBox extends StatelessWidget {
  final String? description;
  DescriptionBox({this.description});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 5),
        Text(
            LocalizationsUtil.of(context).translate(
                'Lời văn thật hay để cửa hàng bạn thu hút cư dân nhé!'),
            style: TextStyle(
                color: ThemeConstant.grey_color,
                fontFamily: ThemeConstant.form_font_family_display,
                fontSize: ThemeConstant.form_font_smaller,
                fontWeight: ThemeConstant.appbar_text_weight)),
        SizedBox(height: 15),
        Container(
            padding: EdgeInsets.only(top: 15, bottom: 19, left: 10, right: 10),
            decoration: BoxDecoration(
              color: ThemeConstant.background_grey_color,
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            child: Text(description != null && description!.length > 0
                ? description!
                : 'Chưa có mô tả'))
      ],
    );
  }
}
