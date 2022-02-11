import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_widget.dart';
import 'package:house_merchant/custom/dialogs/T7GDialog.dart';
import 'package:house_merchant/custom/textfield_widget.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_bloc.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_event.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_state.dart';
import 'package:house_merchant/middle/repository/profile_repository.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
import 'package:house_merchant/screen/base/base_widget.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:house_merchant/utils/progresshub.dart';
import 'package:house_merchant/utils/string_util.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

typedef void checkHandler(String value);

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key key}) : super(key: key);

  @override
  ChangePasswordScreenState createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  Size _screenSize;

  var padding;

  bool _confirmEnable = false;
  final _oldPassword = TextFieldWidgetController();
  final _newPassword = TextFieldWidgetController();
  final StreamController<ButtonSubmitEvent> _confirmButtonController =
      StreamController<ButtonSubmitEvent>();

  ProgressHUD progressToolkit = Progress.instanceCreate();

  //Repository
  var _profileRepository = ProfileRepository();

  ChangePasswordScreenState();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _confirmButtonController.close();
    super.dispose();
  }

  Widget inputContent(
      BuildContext context,
      String title,
      TextFieldWidgetController _controller,
      List<FormFieldValidator> validators,
      checkHandler checkCallback,
      {String attribute = "",
      obscureText = false}) {
    final paddingScreen = EdgeInsets.only(left: padding, right: padding);

    return Padding(
        padding: paddingScreen,
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              Text(LocalizationsUtil.of(context).translate(title),
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontSize: ThemeConstant.label_font_size,
                    fontWeight: FontWeight.w500,
                  ))
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          FormBuilderField(
              name: attribute,
              validator: FormBuilderValidators.compose(validators),
              builder: (FormFieldState<dynamic> field) {
                return Column(children: <Widget>[
                  Container(
                    width: _screenSize.width,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 10.0),
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: TextFieldWidget(
                              controller: _controller,
                              obscureText: obscureText,
                              defaultHintText: '',
                              callback: (String password) {
                                field.didChange(password);
                                checkCallback(password);
                              }),
                        ),
                      ],
                    ),
                  ),
                  Row(children: [
                    Text(
                      StringUtil.isEmpty(field.errorText)
                          ? ""
                          : field.errorText,
                      style: TextStyle(color: Colors.red),
                    )
                  ]),
                ]);
              }),
        ]));
  }

  Widget showSucessful() {
    final _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    final width = this._screenSize.width * 90 / 100;
    return Padding(
        padding: EdgeInsets.all(20),
        child: Container(
            width: width,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Image.asset('assets/images/dialogs/graphic-password.png',
                    width: 100, height: 100),
                SizedBox(height: 20),
                Text(LocalizationsUtil.of(context).translate("Đổi thành công!"),
                    style: TextStyle(
                      fontFamily: ThemeConstant.form_font_family_display,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.26,
                      color: ThemeConstant.black_color,
                    )),
                SizedBox(height: 20),
                Center(
                    child: Text(
                  LocalizationsUtil.of(context).translate(
                      "Mật khẩu đã được đổi\nVui lòng đăng nhập lại"),
                  style: TextStyle(
                      fontFamily: ThemeConstant.form_font_family_display,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.26,
                      color: ThemeConstant.grey_color,
                      height: 1.5),
                  textAlign: TextAlign.center,
                )),
                SizedBox(height: 20),
                BaseWidget.buttonThemePink('Đăng nhập lại', callback: () {
                  _authenticationBloc.add(LoggedOut());
                  Navigator.of(context).popUntil((route) => route.isFirst);
                })
              ],
            )));
  }

  Widget initContent(BuildContext context) {
    final padding = this._screenSize.width * 5 / 100;
    final paddingButton = EdgeInsets.all(padding);

    return FormBuilder(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          inputContent(context, "Mật khẩu cũ", _oldPassword, [],
              (String oldPassword) {
            if (_oldPassword.text.length >= 5 &&
                _newPassword.text.length >= 5) {
              _confirmButtonController.sink
                  .add(ButtonSubmitEvent(this._confirmEnable = true));
            } else {
              _confirmButtonController.sink
                  .add(ButtonSubmitEvent(this._confirmEnable = false));
            }
          }, attribute: "old_password", obscureText: true),
          inputContent(context, "Mật khẩu mới", _newPassword, [],
              (String newPassword) {
            if (_oldPassword.text.length >= 5 &&
                _newPassword.text.length >= 5) {
              _confirmButtonController.sink
                  .add(ButtonSubmitEvent(this._confirmEnable = true));
            } else {
              _confirmButtonController.sink
                  .add(ButtonSubmitEvent(this._confirmEnable = false));
            }
          }, attribute: "new_password", obscureText: true),
          Padding(
              padding: paddingButton,
              child: ButtonWidget(
                defaultHintText:
                    LocalizationsUtil.of(context).translate('Xác nhận đổi'),
                controller: _confirmButtonController,
                callback: () async {
                  try {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    progressToolkit.state.show();
                    await _profileRepository.changePassword(
                        _oldPassword.text, _newPassword.text);

                    T7GDialog.showContentDialog(context, [this.showSucessful()],
                        closeShow: false, barrierDismissible: false);
                  } catch (e) {
                    _oldPassword.text = "";
                    _newPassword.text = "";
                    _confirmButtonController.sink
                        .add(ButtonSubmitEvent(this._confirmEnable = false));
                    T7GDialog.showAlertDialog(context, "Cảnh báo", e);
                  } finally {
                    progressToolkit.state.dismiss();
                  }
                },
              )),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    this._screenSize = MediaQuery.of(context).size;
    this.padding = this._screenSize.width * 5 / 100;
    final _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    return BaseScaffoldNormal(
        title: 'Đổi mật khẩu',
        child: SafeArea(
            child: BlocBuilder(
                bloc: _authenticationBloc,
                builder: (BuildContext context, AuthenticationState authState) {
                  return Stack(children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          // Click outside and close Keyboard.
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
                        child: Container(
                            color: ThemeConstant.white_color,
                            child: ListView(
                              children: <Widget>[
                                Container(
                                    height: this._screenSize.height * 10 / 100),
                                initContent(context)
                              ],
                            ))),
                    progressToolkit,
                  ]);
                })));
  }
}
