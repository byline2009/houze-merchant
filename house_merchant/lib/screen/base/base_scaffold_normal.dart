import 'package:flutter/material.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/utils/localizations_util.dart';

class BaseScaffoldNormal extends StatelessWidget {

  final Widget child;
  final String title;

  BaseScaffoldNormal({this.title, this.child});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(LocalizationsUtil.of(context).translate(this.title),
          style: TextStyle(
          fontSize: ThemeConstant.appbar_scaffold_font_title,
          color: ThemeConstant.appbar_text_color,
          fontWeight: ThemeConstant.appbar_text_weight)),
      backgroundColor: ThemeConstant.appbar_background_color,
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: ThemeConstant.appbar_icon_color,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      )),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: this.child)
    );
  }

}