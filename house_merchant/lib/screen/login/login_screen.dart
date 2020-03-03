import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_widget.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_bloc.dart';
import 'package:house_merchant/middle/bloc/login/index.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:house_merchant/utils/progresshub.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  ProgressHUD progressToolkit = Progress.instanceCreate();
  Size _screenSize;

  StreamController<ButtonSubmitEvent> loginButtonController =
      new StreamController<ButtonSubmitEvent>.broadcast();
  final GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  final fusername = TextEditingController();
  final fpassword = TextEditingController();

  //setting
  final fusernameLength = 5;
  final fpassLength = 5;

  Widget loginButton(LoginBloc loginBloc) {
    return ButtonWidget(
        controller: loginButtonController,
        defaultHintText: LocalizationsUtil.of(context).translate('Đăng nhập'),
        callback: () async {
          FocusScope.of(context).requestFocus(new FocusNode());
          fbKey.currentState.save();
          loginBloc.add(LoginButtonPressed(
            username: fusername.text,
            password: fpassword.text,
          ));
        });
  }

  Widget usernameSection() {
    return FormBuilderCustomField(
        attribute: "name",
        formField: FormField(
            enabled: true,
            builder: (FormFieldState<dynamic> field) {
              return Column(
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
                      cursorColor: ThemeConstant.alto_color,
                      keyboardType: TextInputType.text,
                      controller: fusername,
                      decoration: ThemeConstant.tfInputDecoration(
                          'Vui lòng nhập tên đăng nhập'),
                      onChanged: (String username) {
                        field.didChange(username);
                        if (fusername.text.length >= fusernameLength &&
                            fpassword.text.length >= fpassLength) {
                          loginButtonController.sink
                              .add(ButtonSubmitEvent(true));
                        }
                        if (fusername.text.length <= fusernameLength - 1 ||
                            fpassword.text.length <= fpassLength - 1) {
                          loginButtonController.sink
                              .add(ButtonSubmitEvent(false));
                        }
                      })
                ],
              );
            }));
  }

  Widget passwordSection() {
    return FormBuilderCustomField(
      attribute: "password",
      formField: FormField(
          enabled: true,
          builder: (FormFieldState<dynamic> field) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Mật khẩu",
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                        color: ThemeConstant.black_color)),
                SizedBox(height: 5.0),
                TextField(
                    cursorColor: ThemeConstant.alto_color,
                    keyboardType: TextInputType.text,
                    controller: fpassword,
                    obscureText: true,
                    decoration: ThemeConstant.tfInputDecoration(
                        'Vui lòng nhập mật khẩu'),
                    onChanged: (String password) {
                      field.didChange(password);
                      if (fusername.text.length >= fusernameLength &&
                          fpassword.text.length >= fpassLength) {
                        loginButtonController.sink.add(ButtonSubmitEvent(true));
                      }
                      if (fusername.text.length <= fusernameLength - 1 ||
                          fpassword.text.length <= fpassLength - 1) {
                        loginButtonController.sink
                            .add(ButtonSubmitEvent(false));
                      }
                    })
              ],
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = LoginBloc(
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
    print('bugg rebuild');

    final introduceSection = Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: 150,
                        maxWidth: 300.0,
                        minHeight: 40.0,
                        maxHeight: 100.0),
                    child: FittedBox(
                        child: Text(
                      'House\nMerchant',
                      style: TextStyle(
                          letterSpacing: 0.68,
                          fontSize: 34.0,
                          fontWeight: FontWeight.bold,
                          color: ThemeConstant.violet_color),
                    ))),
                SizedBox(height: 5.0),
                Text('Ứng dụng quản lý cửa hàng\nKết nối với cư dân toà nhà',
                    style: TextStyle(
                        letterSpacing: 0.26,
                        fontSize: 16.0,
                        color: ThemeConstant.black_color,
                        fontWeight: ThemeConstant.appbar_text_weight))
              ])),
          SvgPicture.asset('assets/images/ic-login-store.svg',
              width: 134.0, height: 162.0, fit: BoxFit.fitHeight),
        ]));

    final forgotLabel = FlatButton(
      child: Text('Quên mật khẩu',
          style: TextStyle(
              color: ThemeConstant.violet_color,
              fontSize: 18.0,
              fontWeight: FontWeight.bold)),
      onPressed: () {},
    );

    this._screenSize = MediaQuery.of(context).size;
    final _padding = this._screenSize.width * 5 / 100;

    return Scaffold(
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Stack(children: <Widget>[
              Center(
                child: Container(
                  padding: EdgeInsets.only(left: _padding, top: 40),
                  child: ListView(
                    children: <Widget>[
                      introduceSection,
                      SizedBox(height: 50.0),
                      Padding(
                        padding: EdgeInsets.only(right: _padding),
                        child: FormBuilder(
                          key: fbKey,
                          child: BlocListener(
                              bloc: loginBloc,
                              listener: (context, state) async {
                                if (state is LoginLoading) {
                                  progressToolkit.state.show();
                                  await Future.delayed(Duration(seconds: 3));
                                }

                                if (state is LoginFailure) {
                                  progressToolkit.state.dismiss();
                                }
                              },
                              child: BlocBuilder<LoginBloc, LoginState>(
                                  bloc: loginBloc,
                                  builder: (
                                    BuildContext context,
                                    LoginState state,
                                  ) {
                                    var errorText;

                                    if (state is LoginFailure) {
                                      errorText = state.error;
                                      fpassword.clear();
                                      loginButtonController.sink
                                          .add(ButtonSubmitEvent(false));
                                    }

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        this.usernameSection(),
                                        SizedBox(height: 30.0),
                                        this.passwordSection(),
                                        SizedBox(height: 10.0),
                                        errorText != null
                                            ? Row(children: [
                                                Text(
                                                  errorText,
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )
                                              ])
                                            : Center(),
                                        SizedBox(height: 70.0),
                                        this.loginButton(loginBloc),
                                        SizedBox(height: 40.0),
                                        forgotLabel
                                      ],
                                    );
                                  })),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              progressToolkit
            ])));
  }
}
