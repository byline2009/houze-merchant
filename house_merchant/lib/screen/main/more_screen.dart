import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:house_merchant/constant/theme_constant.dart';
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

class MoreScreen extends StatefulWidget {
  MoreScreen({Key? key}) : super(key: key);

  @override
  MoreScreenState createState() => MoreScreenState();
}

class MoreScreenState extends State<MoreScreen> {
  Widget _headerWidget(ProfileBloc profileBloc, ShopModel shop) {
    return BlocBuilder(
        bloc: profileBloc,
        builder: (BuildContext context, ProfileState profileState) {
          if (profileState is ProfileInitial) {
            profileBloc.add(GetProfileEvent());
          }

          if (profileState is ProfileFailure) {
            final result = profileState.error;
            Fluttertoast.showToast(
                msg: result,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.redAccent,
                textColor: Colors.white,
                fontSize: 16.0);
          }

          if (profileState is ProfileGetSuccessful) {
            final result = profileState.result;

            return Container(
                color: Colors.white,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.all(0.0),
                        leading: CircleAvatar(
                            backgroundColor: ThemeConstant.alto_color,
                            child: Text(result.fullName![0],
                                style: ThemeConstant.titleLargeStyle(
                                    Colors.white))),
                        title: Text(result.fullName!,
                            style: ThemeConstant.headerTitleBoldStyle(
                                ThemeConstant.black_color)),
                        subtitle: Text('QUẢN LÝ CỬA HÀNG',
                            style: TextStyle(
                                fontSize: 13.0,
                                color: ThemeConstant.violet_color,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.26)),
                        onTap: () {}),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: Text(shop.name ?? '',
                                style: ThemeConstant.headerTitleBoldStyle(
                                    ThemeConstant.black_color))),
                        /*Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.star,
                                  color: ThemeConstant.start_yelow_color),
                              SizedBox(width: 10.0),
                              Text('4.92',
                                  style: ThemeConstant.headerTitleBoldStyle(
                                      ThemeConstant.start_yelow_color))
                            ],
                          ),
                        ),*/
                      ],
                    )
                  ],
                ));
          }

          return CardListSkeleton(
            shrinkWrap: true,
            length: 1,
            config: SkeletonConfig(
              theme: SkeletonTheme.Light,
              isShowAvatar: true,
              isCircleAvatar: true,
              bottomLinesCount: 3,
              radius: 0.0,
            ),
          );
        });
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

  Widget arrowButton() {
    return Icon(Icons.arrow_forward, color: ThemeConstant.alto_color, size: 16);
  }

  Widget makeBody(ProfileBloc profileBloc, ShopModel? shop) {
    return ListView(shrinkWrap: true, children: <Widget>[
      Column(
        children: <Widget>[
          shop != null ? _headerWidget(profileBloc, shop) : Center(),
          Container(decoration: ThemeConstant.decorationGreyBottom(10.0)),
          /*shop != null
              ? Container(
                  color: Colors.white,
                  child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      title: Text('Trạng thái cửa hàng',
                          style: ThemeConstant.titleStyle(Colors.black)),
                      subtitle: Text(shop.statusName(),
                          style: ThemeConstant.subtitleStyle(
                              ThemeConstant.approved_color)),
                      trailing: arrowButton(),
                      onTap: () {
                        print('Trạng thái cửa hàng');
                      }))
              : Center(),
          SizedBox(height: 2),
          Container(
              color: Colors.white,
              child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: Text(
                    'Quản lý tài khoản',
                    style: ThemeConstant.titleStyle(Colors.black),
                  ),
                  trailing: arrowButton(),
                  onTap: () {
                    print('cow');
                  })),
          SizedBox(height: 2),*/
          Container(
              color: Colors.white,
              child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: Text(
                    'Thông tin cá nhân',
                    style: ThemeConstant.titleStyle(Colors.black),
                  ),
                  trailing: arrowButton(),
                  onTap: () {
                    AppRouter.pushDialogNoParams(
                        context, AppRouter.PROFILE_PAGE);
                  })),
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
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                title: Text(
                  'Liên hệ Houze Merchant',
                  style: ThemeConstant.titleStyle(Colors.black),
                ),
                trailing: arrowButton(),
                onTap: () {
                  print('Liên hệ Houze Merchant');
                  AppRouter.pushDialogNoParams(context, AppRouter.CONTACT_PAGE);
                },
              )),
          /*SizedBox(height: 2),
          Container(
              color: Colors.white,
              child: ListTile(
                dense: true,
                contentPadding:
                    EdgeInsets.only(left: 20.0, right: 20.0, top: 0, bottom: 0),
                title: Text('Quy định & Điều khoản',
                    style: ThemeConstant.titleStyle(Colors.black)),
                trailing: arrowButton(),
                onTap: () {
                  print('Quy định & Điều khoản');
                },
              )),*/
          SizedBox(height: 50.0)
        ],
      )
    ]);
  }

  Widget buildBody(
      BuildContext context, ProfileBloc profileBloc, ShopBloc shopBloc) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShopBloc>(
          create: (BuildContext context) => shopBloc,
        ),
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) => profileBloc,
        )
      ],
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          BlocBuilder(
              bloc: shopBloc,
              builder: (BuildContext context, ShopState shopState) {
                if (shopState is ShopInitial) {
                  shopBloc.add(ShopGetDetail(id: Sqflite.current_shop));
                }

                if (shopState is ShopGetDetailSuccessful) {
                  final shopModel = shopState.result;
                  return makeBody(profileBloc, shopModel);
                }

                if (shopState is ShopFailure) {
                  return makeBody(profileBloc, null);
                }

                return CardListSkeleton(
                  shrinkWrap: true,
                  length: 5,
                  config: SkeletonConfig(
                    theme: SkeletonTheme.Light,
                    isShowAvatar: false,
                    isCircleAvatar: false,
                    bottomLinesCount: 2,
                    radius: 0.0,
                  ),
                );
              }),
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
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    final _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    final _screenSize = MediaQuery.of(context).size;

    T7GDialog.showContentDialog(
        context,
        <Widget>[
          Container(
              padding: EdgeInsets.all(20.0),
              width: _screenSize.width * 90 / 100,
              child: Column(
                children: <Widget>[
                  Image.asset('assets/images/dialogs/graphic-logout.png',
                      width: 100, height: 100),
                  SizedBox(height: 20),
                  Text(LocalizationsUtil.of(context).translate("Xác nhận"),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: ThemeConstant.form_font_family,
                        fontSize: _screenSize.width < 350 ? 16 : 24,
                        color: ThemeConstant.black_color,
                        fontWeight: ThemeConstant.appbar_text_weight_bold,
                      )),
                  SizedBox(height: 20),
                  Text(
                      LocalizationsUtil.of(context).translate(
                          "Bạn muốn đăng xuất khỏi\nứng dụng Houze Merchant?"),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: ThemeConstant.form_font_family,
                        fontSize: 16,
                        color: ThemeConstant.form_text_normal,
                        fontWeight: ThemeConstant.appbar_text_weight,
                      )),
                  SizedBox(height: 54),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                              height: 48.0,
                              child: BaseWidget.buttonThemePink('Không',
                                  callback: () {
                                Navigator.of(context).pop();
                              }))),
                      SizedBox(width: 15),
                      Expanded(
                          child: Container(
                        height: 48.0,
                        child:
                            BaseWidget.buttonOutline('Đăng xuất', callback: () {
                          _authenticationBloc.add(LoggedOut());

                          Navigator.of(context).pop();
                        }),
                      )),
                    ],
                  )
                ],
              ))
        ],
        closeShow: false);
  }

  @override
  Widget build(BuildContext context) {
    final shopBloc = ShopBloc(ShopInitial());
    final profileBloc = ProfileBloc(ProfileInitial());

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
                    child: buildBody(context, profileBloc, shopBloc))),
            Positioned(
              bottom: 20.0,
              left: 20,
              right: 0,
              child: Text('Houze Merchant v1.0',
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
