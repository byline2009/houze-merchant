import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_merchant/constant/theme_constant.dart';

typedef void CallBackHandler();

class ButtonScanQRWidget extends StatefulWidget {
  final CallBackHandler callback;

  ButtonScanQRWidget({required this.callback});

  ButtonScanQRWidgetState createState() => ButtonScanQRWidgetState();
}

class ButtonScanQRWidgetState extends State<ButtonScanQRWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                ThemeConstant.sacn_button_gradient_color_top,
                ThemeConstant.primary_color,
              ]),
        ),
        width: 140,
        padding: EdgeInsets.all(0),
        child: TextButton(
          onPressed: () {
            widget.callback();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SvgPicture.asset('assets/images/qr-icon.svg'),
              Text(
                'Quét QR',
                style: TextStyle(
                    color: ThemeConstant.white_color,
                    fontSize: 16,
                    letterSpacing: 0.26,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ));
  }
}
