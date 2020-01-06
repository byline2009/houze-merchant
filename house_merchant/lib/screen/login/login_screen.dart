import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_merchant/constant/theme_constant.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final introduceSection = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'House\nMerchant',
                style: TextStyle(
                    fontSize: 34.0,
                    fontWeight: FontWeight.bold,
                    color: ThemeConstant.violet_color),
              ),
              SizedBox(height: 5.0),
              Text('Ứng dụng quản lý cửa hàng\nKết nối với cư dân toà nhà',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: ThemeConstant.black_color,
                      fontWeight: ThemeConstant.appbar_text_weight))
            ],
          ),
          SizedBox(width: 25.0),
          SvgPicture.asset('assets/images/ic-login-store.svg',
              width: 162.0, height: 162.0, fit: BoxFit.contain),
        ]);

    final usernameSection = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Tên đăng nhập",
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: ThemeConstant.black_color)),
        SizedBox(height: 5.0),
        TextFormField(
          keyboardType: TextInputType.text,
          autofocus: true,
          initialValue: '',
          decoration: InputDecoration(
            hintText: 'Vui lòng nhập tên đăng nhập',
            contentPadding: EdgeInsets.all(12.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        )
      ],
    );

    final passwordSection = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Mật khẩu",
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: ThemeConstant.black_color)),
        SizedBox(height: 5.0),
        TextFormField(
            keyboardType: TextInputType.text,
            obscureText: true,
            initialValue: '',
            decoration: InputDecoration(
                hintText: 'Vui lòng nhập mật khẩu',
                contentPadding: EdgeInsets.all(12.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0))))
      ],
    );

    final loginButon = Material(
        borderRadius: BorderRadius.circular(4.0),
        color: ThemeConstant.alto_color,
        child: MaterialButton(
          height: 48.0,
          onPressed: () {
            print("Dang nhap");
          },
          child: Text(
            "Đăng nhập",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ThemeConstant.white_color,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ));

    final forgotPasswordButon = Material(
        color: Colors.transparent,
        child: MaterialButton(
          height: 48.0,
          onPressed: () {
            print("Quen mat khau");
          },
          child: Text(
            "Quên mật khẩu",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ThemeConstant.violet_color,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ));

    // TODO: implement build
    return Center(
      child: Container(
        padding: EdgeInsets.only(left: 20.0, top: 40.9),
        child: ListView(
          children: <Widget>[
            introduceSection,
            SizedBox(height: 50.0),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Column(
                children: <Widget>[
                  usernameSection,
                  SizedBox(height: 30.0),
                  passwordSection,
                  SizedBox(height: 80.0),
                  loginButon,
                  SizedBox(height: 40.0),
                  forgotPasswordButon
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
