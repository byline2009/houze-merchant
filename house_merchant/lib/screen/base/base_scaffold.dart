import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/utils/localizations_util.dart';

class BaseScaffold extends StatelessWidget {

  final Widget child;
  final Widget bottom;
  final String title;
  final Widget trailing;
  final Color backgroundColor;

  BaseScaffold({this.title, this.child, this.bottom, this.trailing, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
      Column(
        children: <Widget>[

          SizedBox(height: 20),
          
          AppBar(
            centerTitle: false,
            leading: IconButton(
              icon: SvgPicture.asset("assets/icons/ic-notification.svg"),
              onPressed: () {
              },
            ),
            actions: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  this.trailing != null ? this.trailing : Center()

                ],
              ),
            ],
            title: Text(LocalizationsUtil.of(context).translate(this.title),
              style: TextStyle(
                fontSize: ThemeConstant.appbar_font_title,
                color: ThemeConstant.appbar_text_color,
                fontWeight: ThemeConstant.appbar_text_weight_bold)
            ),
            backgroundColor: this.backgroundColor != null ? this.backgroundColor : ThemeConstant.appbar_background_color,
            elevation: 0.0,
          ),

          this.bottom != null ? this.bottom : Center(),

          Expanded(child: child)
        ],
      )
    );
  }

}