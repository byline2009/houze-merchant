import 'package:flutter/material.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/utils/localizations_util.dart';

typedef void CallBackHandler();

class ButtonCreateWidget extends StatefulWidget {
  final CallBackHandler onPressed;
  final Widget icon;
  final String title;

  ButtonCreateWidget(
      {@required this.onPressed, @required this.title, this.icon});

  ButtonCreateWidgetState createState() => ButtonCreateWidgetState();
}

class ButtonCreateWidgetState extends State<ButtonCreateWidget> {
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        height: 44.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: ThemeConstant.primary_color,
            elevation: 0.0,
            onPrimary: ThemeConstant.white_color,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: ThemeConstant.primary_color),
                borderRadius: new BorderRadius.circular(28.0)),
          ),
          onPressed: () {
            widget.onPressed();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              widget.icon != null ? widget.icon : Center(),
              SizedBox(width: 10),
              Text(
                LocalizationsUtil.of(context).translate(widget.title),
                style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.26,
                    fontWeight: FontWeight.w500,
                    fontFamily: ThemeConstant.form_font_family_display),
              )
            ],
          ),
        ));
  }
}
