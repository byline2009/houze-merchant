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
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:house_merchant/utils/progresshub.dart';
import 'package:house_merchant/utils/string_util.dart';

typedef void checkHandler(String value);

class ChangePasswordScreen extends StatefulWidget {

  ChangePasswordScreen({Key key}) : super(key: key);

  @override
  ChangePasswordScreenState createState() => new ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {

  Size _screenSize;
  BuildContext _context;
  var padding;

  var _confirmEnable = false;
  final _old_password = TextFieldWidgetController();
  final _new_password = TextFieldWidgetController();
  StreamController<ButtonSubmitEvent> _confirmButtonController = new StreamController<ButtonSubmitEvent>();

  ProgressHUD progressToolkit = Progress.instanceCreate();

  //Repository
  var _profileRepository = ProfileRepository();

  ChangePasswordScreenState();

  @override
  void initState() {
    super.initState();
  }

  Widget inputContent(BuildContext context, String title, TextFieldWidgetController _controller, List<FormFieldValidator> validators, checkHandler checkCallback, {String attribute="", obscureText=false}) {

    final paddingScreen = EdgeInsets.only(left: padding, right: padding);

    return Padding(
        padding: paddingScreen,
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            Text(LocalizationsUtil.of(context).translate(title),
                style: TextStyle(
                  fontFamily: 'SFProDisplay',
                  fontSize: ThemeConstant.label_font_size,
                  fontWeight: FontWeight.w500,
                ))
          ],),
          SizedBox(height: 10.0,),
          FormBuilderCustomField(
              attribute: attribute,
              validators: validators,
              formField: FormField(
                // key: _fieldKey,
                  enabled: true,
                  //autovalidate: this._nextEnable,
                  builder: (FormFieldState<dynamic> field) {
                    return new Column(children: <Widget>[
                      Container(
                        width: _screenSize.width,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(bottom: 10.0),
                        padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Expanded(
                              child:TextFieldWidget(
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
                      Row(children: [ Text(StringUtil.isEmpty(field.errorText) ? "" : field.errorText, style: TextStyle(color: Colors.red),)] ),
                    ]);
                  }
              )
          ),

        ])
    );
  }

  Widget initContent(BuildContext context) {

    final padding = this._screenSize.width * 5 / 100;
    final paddingButton = EdgeInsets.all(padding);
    final _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    return FormBuilder(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              inputContent(context, "Mật khẩu cũ", _old_password, [], (String old_password) {
                if (_old_password.text.length >= 5 && _new_password.text.length >= 5) {
                  _confirmButtonController.sink.add(ButtonSubmitEvent(this._confirmEnable = true));
                } else {
                  _confirmButtonController.sink.add(ButtonSubmitEvent(this._confirmEnable = false));
                }
              }, attribute: "old_password", obscureText: true),
              inputContent(context, "Mật khẩu mới", _new_password, [], (String new_password) {
                if (_old_password.text.length >= 5 && _new_password.text.length >= 5) {
                  _confirmButtonController.sink.add(ButtonSubmitEvent(this._confirmEnable = true));
                } else {
                  _confirmButtonController.sink.add(ButtonSubmitEvent(this._confirmEnable = false));
                }
              }, attribute: "new_password", obscureText: true),

              Padding(
                  padding: paddingButton,
                  child: ButtonWidget(defaultHintText: LocalizationsUtil.of(context).translate('Xác nhận đổi'), controller: _confirmButtonController, callback: () async {
                    try {
                      progressToolkit.state.show();
                      final result = await _profileRepository.changePassword(_old_password.text, _new_password.text);

                      T7GDialog.showSimpleDialog(context,  <Widget>[
                        Container(padding: EdgeInsets.all(10) ,child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(LocalizationsUtil.of(context).translate('Mật khẩu đã được đổi, mời bạn đăng nhập lại.'), textAlign: TextAlign.center, style: TextStyle(
                                fontSize: ThemeConstant.form_font_normal,
                                color: ThemeConstant.appbar_text_color,
                                fontWeight: ThemeConstant.appbar_text_weight)),
                            SizedBox(height: 10),
                            ButtonWidget(defaultHintText: LocalizationsUtil.of(context).translate('Đăng nhập'), isActive: true, callback: () async {
                              _authenticationBloc.add(LoggedOut());
                              Navigator.of(context).popUntil((route) => route.isFirst);
                            })
                          ],
                        ),)
                      ], barrierDismissible: false);

                    } catch (e) {
                      _old_password.text = "";
                      _new_password.text = "";
                      _confirmButtonController.sink.add(ButtonSubmitEvent(this._confirmEnable = false));
                      T7GDialog.showAlertDialog(context, "Cảnh báo", e);
                    } finally {
                      progressToolkit.state.dismiss();
                    }

                  },)
              ),

            ]
        )
    );
  }

  @override
  Widget build(BuildContext context) {

    this._screenSize = MediaQuery.of(context).size;
    this._context = context;
    this.padding = this._screenSize.width * 5 / 100;
    final _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    return BaseScaffoldNormal(
        title: 'Liên hệ House Merchant',
        child: SafeArea(child:BlocBuilder(
            bloc: _authenticationBloc,
            builder: (BuildContext context, AuthenticationState authState) {
              return Stack(children: <Widget>[
                new GestureDetector(
                    onTap: () {
                      // Click outside and close Keyboard.
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: Container(
                        color: ThemeConstant.white_color,
                        child: ListView(
                          children: <Widget>[
                            Container(height: this._screenSize.height * 10 / 100),
                            initContent(context)
                          ],
                        )
                    )
                ),
                progressToolkit,
              ]);
            })
    )
    );

  }

  @override
  void dispose() {
    super.dispose();
  }
}
