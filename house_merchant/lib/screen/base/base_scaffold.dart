import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/utils/localizations_util.dart';

class BaseScaffold extends StatelessWidget {

  final Widget child;
  final String title;

  BaseScaffold({this.title, this.child});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/ic-notification.svg"),
          onPressed: () {
          },
        ),
        title: Text(LocalizationsUtil.of(context).translate(this.title),
          style: TextStyle(
            fontSize: ThemeConstant.appbar_font_title,
            color: ThemeConstant.appbar_text_color,
            fontWeight: ThemeConstant.appbar_text_weight_bold)
        ),
        backgroundColor: ThemeConstant.appbar_background_color,
        elevation: 0.0,
      ),
      body: SafeArea(child: child)
    );
  }

}