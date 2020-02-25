import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_widget.dart';
import 'package:house_merchant/custom/dialogs/T7GDialog.dart';
import 'package:house_merchant/custom/flutter_skeleton/src/skeleton/card_list_skeleton.dart';
import 'package:house_merchant/custom/flutter_skeleton/src/skeleton_config.dart';
import 'package:house_merchant/custom/flutter_skeleton/src/skeleton_theme.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_bloc.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_event.dart';
import 'package:house_merchant/middle/bloc/profile/index.dart';
import 'package:house_merchant/middle/bloc/shop/index.dart';
import 'package:house_merchant/middle/model/shop_model.dart';
import 'package:house_merchant/router.dart';
import 'package:house_merchant/screen/base/base_widget.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:house_merchant/utils/sqflite.dart';
import 'package:house_merchant/middle/bloc/shop/index.dart';

class MoreScreen extends StatefulWidget {
  MoreScreen({Key key}) : super(key: key);

  @override
  MoreScreenState createState() => MoreScreenState();
}

class MoreScreenState extends State<MoreScreen> {
  Widget _headerWidget(ProfileBloc profileBloc, ShopModel shop) {
    return BlocBuilder(
        bloc: profileBloc,
        builder: (BuildContext context, ProfileState profileState) {
          print('============> STATE: $profileState');

          if (profileState is ProfileInitial) {
            profileBloc.add(GetProfileEvent());
          }

          if (profileState is ProfileGetSuccessful) {
            final result = profileState.result; // as ProfileModel;
            print('============> RESULT: $result');

            return Container(
                color: Colors.white,
                padding: EdgeInsets.all(
                  20.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.all(0.0),
                      leading: CircleAvatar(
                          backgroundColor: ThemeConstant.alto_color,
                          child: Text(result.fullname[0],
                              style:
                                  ThemeConstant.titleLargeStyle(Colors.white))),
                      title: Text(
                        result.fullname,
                        style: ThemeConstant.headerTitleBoldStyle(
                            ThemeConstant.black_color),
                      ),
                      subtitle: Text('QUẢN LÝ CỬA HÀNG',
                          style: TextStyle(
                              fontSize: 13.0,
                              color: ThemeConstant.violet_color,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.26)),
                      onTap: () {},
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          shop.name ?? '',
                          style: ThemeConstant.headerTitleBoldStyle(
                              ThemeConstant.black_color),
                        )),
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                color: ThemeConstant.start_yelow_color,
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                '4.92',
                                style: ThemeConstant.headerTitleBoldStyle(
                                    ThemeConstant.start_yelow_color),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ));
          }
          return CardListSkeleton(
            shrinkWrap: true,
            length: 4,
            config: SkeletonConfig(
              theme: SkeletonTheme.Light,
              isShowAvatar: false,
              isCircleAvatar: false,
              bottomLinesCount: 4,
              radius: 0.0,
            ),
          );
        });

/*
    */
  }

  Widget buildGreyRow(String title, TextStyle style) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
      height: 50.0,
      color: ThemeConstant.background_grey_color,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[Text(title, style: style)]),
    );
  }

  Widget _myListView(BuildContext context) {
    ShopBloc _shopBloc = ShopBloc();
    var _profileBloc = ProfileBloc();

    return MultiBlocProvider(
        providers: [
          BlocProvider<ShopBloc>(
            create: (BuildContext context) => _shopBloc,
          ),
          BlocProvider<ProfileBloc>(
            create: (BuildContext context) => _profileBloc,
          ),
        ],
        child: ListView(
          children: <Widget>[
            // Container(
            BlocBuilder(
                bloc: _shopBloc,
                builder: (BuildContext context, ShopState shopState) {
                  if (shopState is ShopInitial) {
                    _shopBloc.add(ShopGetDetail(id: Sqflite.current_shop));
                  }
                  if (shopState is ShopGetDetailSuccessful) {
                    final shopModel = shopState.result;
                    return _buildBody(_profileBloc, shopModel);
                  }
                  if (shopState is ShopFailure) {
                    return _buildBody(_profileBloc, null);
                  }
                  return CardListSkeleton(
                    shrinkWrap: true,
                    length: 4,
                    config: SkeletonConfig(
                      theme: SkeletonTheme.Light,
                      isShowAvatar: false,
                      isCircleAvatar: false,
                      bottomLinesCount: 4,
                      radius: 0.0,
                    ),
                  );
                }),
            // ),
            Container(
                color: Colors.white,
                child: ListTile(
                  dense: true,
                  title: Text('Đăng xuất',
                      style: ThemeConstant.titleStyle(
                          ThemeConstant.form_border_error)),
                  trailing: arrowButton(),
                  onTap: () {
                    print('Đăng xuất');
                    this.showLogoutDialog(context);
                  },
                )),
          ],
        ));
  }

  void showLogoutDialog(BuildContext context) {

    final _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    final _screenSize = MediaQuery.of(context).size;
    final padding = _screenSize.width * 5 / 100;
    final paddingButton = EdgeInsets.all(padding);
    T7GDialog.showContentDialog(context, <Widget>[
      Container(
        padding: EdgeInsets.all(20.0),
          width: _screenSize.width * 80 / 100,
          height: _screenSize.height * 40 / 100,
          child: Column(
            children: <Widget>[
              Image.asset('assets/images/dialogs/graphic-logout.png', width: 100, height: 100),
              SizedBox(height: 20),
              Text(LocalizationsUtil.of(context).translate("Xác nhận"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: ThemeConstant.form_font_family,
                    fontSize: _screenSize.width < 350 ? 16 : 24,
                    color: ThemeConstant.black_color,
                    fontWeight: ThemeConstant.appbar_text_weight_bold,)
              ),
              SizedBox(height: 20,),
              Text(LocalizationsUtil.of(context).translate("Bạn muốn đăng xuất khỏi\nứng dụng House Merchant?"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: ThemeConstant.form_font_family,
                    fontSize: 16,
                    color: ThemeConstant.form_text_normal,
                    fontWeight: ThemeConstant.appbar_text_weight,)
              ),
              SizedBox(height: 54,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 48.0,
                      child:
                      BaseWidget.buttonThemePink('Không', callback: () {

                        Navigator.of(context).pop();
                      }),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                      child: Container(
                        height: 48.0,
                        child: BaseWidget.buttonOutline('Đăng xuất', callback: () {
                          _authenticationBloc.add(LoggedOut());

                        }),
                      )),
                ],
              )
            ],
          )
      )
    ], closeShow: false);
  }

  Widget arrowButton() {
    return Icon(Icons.arrow_forward, color: ThemeConstant.alto_color, size: 16);
  }

  Widget _buildBody(ProfileBloc profileBloc, ShopModel shop) {
    return Column(
      children: <Widget>[
        shop != null ? _headerWidget(profileBloc, shop): Center(),
        Container(
          decoration: ThemeConstant.decorationGreyBottom(10.0),
        ),
        shop != null ? Container(
            color: Colors.white,
            child: ListTile(
              dense: true,
              contentPadding:
                  EdgeInsets.only(left: 20.0, right: 20.0, top: 0, bottom: 0),
              title: Text(
                'Trạng thái cửa hàng',
                style: ThemeConstant.titleStyle(Colors.black),
              ),
              subtitle: Text(
                shop.getStatusName(),
                style:
                    ThemeConstant.subtitleStyle(ThemeConstant.status_approved),
              ),
              trailing: arrowButton(),
              onTap: () {
                print('Trạng thái cửa hàng');
              },
            )) : Center(),
        Container(
          decoration: ThemeConstant.decorationGreyBottom(2.0),
        ),
        Container(
            color: Colors.white,
            child: ListTile(
              dense: true,
              contentPadding:
                  EdgeInsets.only(left: 20.0, right: 20.0, top: 0, bottom: 0),
              title: Text(
                'Quản lý tài khoản',
                style: ThemeConstant.titleStyle(Colors.black),
              ),
              trailing: arrowButton(),
              onTap: () {
                print('cow');
              },
            )),
        Container(
          decoration: ThemeConstant.decorationGreyBottom(2.0),
        ),
        Container(
            color: Colors.white,
            child: ListTile(
              dense: true,
              contentPadding:
                  EdgeInsets.only(left: 20.0, right: 20.0, top: 0, bottom: 0),
              title: Text(
                'Thông tin cá nhân',
                style: ThemeConstant.titleStyle(Colors.black),
              ),
              trailing: arrowButton(),
              onTap: () {
                Router.pushDialogNoParams(context, Router.PROFILE_PAGE);
                print('Thông tin cá nhân');
              },
            )),
        buildGreyRow(
            'Hỗ trợ',
            TextStyle(
                fontSize: 20.0,
                color: ThemeConstant.unselected_color,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.29)),
        Container(
            color: Colors.white,
            child: ListTile(
              dense: true,
              contentPadding:
                  EdgeInsets.only(left: 20.0, right: 20.0, top: 0, bottom: 0),
              title: Text(
                'Liên hệ House Merchant',
                style: ThemeConstant.titleStyle(Colors.black),
              ),
              trailing: arrowButton(),
              onTap: () {
                print('Liên hệ House Merchant');
                Router.pushDialogNoParams(context, Router.CONTACT_PAGE);
              },
            )),
        Container(
          decoration: ThemeConstant.decorationGreyBottom(2.0),
        ),
        Container(
            color: Colors.white,
            child: ListTile(
              dense: true,
              contentPadding:
                  EdgeInsets.only(left: 20.0, right: 20.0, top: 0, bottom: 0),
              title: Text(
                'Quy định & Điều khoản',
                style: ThemeConstant.titleStyle(Colors.black),
              ),
              trailing: arrowButton(),
              onTap: () {
                print('Quy định & Điều khoản');
              },
            )),
        Container(
          decoration: ThemeConstant.decorationGreyBottom(50.0),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Container(
        color: ThemeConstant.background_grey_color,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              bottom: 56.0,
              left: 0,
              right: 0,
              child: Container(
                color: ThemeConstant.background_grey_color,
                child: _myListView(context),
              ),
            ),
            Positioned(
              bottom: 20.0,
              left: 20,
              right: 0,
              child: Text('House Merchant v1.0',
                  style: TextStyle(
                      fontSize: 13,
                      color: ThemeConstant.grey_color,
                      letterSpacing: 0.26,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
