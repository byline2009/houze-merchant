import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/flutter_skeleton/flutter_skeleton.dart';
import 'package:house_merchant/middle/bloc/profile/index.dart';
import 'package:house_merchant/router.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:intl/intl.dart';

class ProfileScreenWidget extends StatefulWidget {
  final dynamic params;

  ProfileScreenWidget({Key key, this.params}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState(params: this.params);
}

class ProfileScreenState extends State<ProfileScreenWidget> {
  final dynamic params;

  ProfileScreenState({this.params});

  @override
  void initState() {
    super.initState();
  }

  Widget makeRowData(String label, String value, {Color color}) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(LocalizationsUtil.of(context).translate(label),
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: color ?? ThemeConstant.grey_color,
                  fontSize: ThemeConstant.form_font_normal,
                  fontFamily: ThemeConstant.form_font_family_display)),
          SizedBox(width: 20),
          Flexible(
            child: Text(value,
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color ?? Colors.black,
                    fontSize: ThemeConstant.form_font_normal,
                    fontFamily: ThemeConstant.form_font_family_display)),
          )
        ],
      ),
    );
  }

  Widget profileBody(BuildContext context, ProfileBloc profileBloc) {
    return CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
      SliverToBoxAdapter(
        child: BlocBuilder(
          bloc: profileBloc,
          builder: (BuildContext context, ProfileState profileState) {
            if (profileState is ProfileInitial) {
              profileBloc.add(GetProfileEvent());
            }

            if (profileState is ProfileGetSuccessful) {
              final result = profileState.result;

              return Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CircleAvatar(
                                  backgroundColor: ThemeConstant.alto_color,
                                  child: Text(result.fullname[0],
                                      style: ThemeConstant.titleLargeStyle(
                                          Colors.white)),
                                  radius: 33),
                              SizedBox(height: 25.0),
                              makeRowData('Họ và tên:', result.fullname),
                              makeRowData('Tên đăng nhập:', result.username),
                              makeRowData('Chức vụ:', 'Chủ quán'),
                              result.birthday != null
                                  ? makeRowData(
                                      'Ngày sinh:',
                                      DateFormat('dd/MM/yyyy')
                                          .format(
                                              DateTime.parse(result.birthday)
                                                  .toLocal())
                                          .toString())
                                  : Center(),
                              result.phoneNumber != null
                                  ? makeRowData('Điện thoại:',
                                      result.phoneNumber.toString())
                                  : Center(),
                            ],
                          )),
                      buildGreyRow(
                          'Mật khẩu',
                          TextStyle(
                              fontSize: 20.0,
                              color: ThemeConstant.unselected_color,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.29)),
                      Container(
                          color: Colors.white,
                          height: 60.0,
                          child: ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 5, bottom: 0),
                            title: Text('Thay đổi mật khẩu',
                                style: ThemeConstant.titleStyle(Colors.black)),
                            trailing: arrowButton(),
                            onTap: () {
                              print('Thay đổi mật khẩu');
                              AppRouter.pushDialogNoParams(
                                  context, AppRouter.CHANGE_PASSWORD);
                            },
                          )),
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
                bottomLinesCount: 6,
                radius: 0.0,
              ),
            );
          },
        ),
      ),
    ]);
  }

  Widget arrowButton() {
    return Icon(Icons.arrow_forward, color: ThemeConstant.alto_color, size: 16);
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

  @override
  Widget build(BuildContext context) {
    final profileBloc = ProfileBloc(ProfileInitial());

    return BaseScaffoldNormal(
        title: 'Thông tin cá nhân',
        child: SafeArea(
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(height: 10.0),
              Expanded(child: profileBody(context, profileBloc)),
            ],
          )),
        ));
  }
}
