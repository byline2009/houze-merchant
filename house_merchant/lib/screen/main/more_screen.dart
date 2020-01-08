import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:house_merchant/constant/theme_constant.dart';

class MoreScreen extends StatefulWidget {
  MoreScreen({Key key}) : super(key: key);

  @override
  MoreScreenState createState() => MoreScreenState();
}

class MoreScreenState extends State<MoreScreen> {
  Widget headerWidget() {
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
                  child: Text('N',
                      style: TextStyle(
                          fontSize: 27,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.43))),
              title: Text(
                'Nguyễn Thị Minh Ngọc',
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
                  'HouseMap coffee',
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
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            headerWidget(),
            Container(
              decoration: ThemeConstant.decorationGreyBottom(10.0),
            ),
            Container(
                color: Colors.white,
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 0, bottom: 0),
                  title: Text(
                    'Trạng thái cửa hàng',
                    style: ThemeConstant.titleStyle(Colors.black),
                  ),
                  subtitle: Text(
                    'Đang hoạt động',
                    style: ThemeConstant.subtitleStyle(
                        ThemeConstant.status_approved),
                  ),
                  trailing: arrowButton(),
                  onTap: () {
                    print('Trạng thái cửa hàng');
                  },
                )),
            Container(
              decoration: ThemeConstant.decorationGreyBottom(2.0),
            ),
            Container(
                color: Colors.white,
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 0, bottom: 0),
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
                  contentPadding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 0, bottom: 0),
                  title: Text(
                    'Thông tin cá nhân',
                    style: ThemeConstant.titleStyle(Colors.black),
                  ),
                  trailing: arrowButton(),
                  onTap: () {
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
                  contentPadding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 0, bottom: 0),
                  title: Text(
                    'Liên hệ House Merchant',
                    style: ThemeConstant.titleStyle(Colors.black),
                  ),
                  trailing: arrowButton(),
                  onTap: () {
                    print('Liên hệ House Merchant');
                  },
                )),
            Container(
              decoration: ThemeConstant.decorationGreyBottom(2.0),
            ),
            Container(
                color: Colors.white,
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 0, bottom: 0),
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
        ),
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
              },
            )),
      ],
    );
  }

  Widget arrowButton() {
    return Icon(Icons.arrow_forward, color: ThemeConstant.alto_color, size: 16);
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

  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //       child: Column(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       _myListView(context),
  //       Container(
  //         padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
  //         color: ThemeConstant.background_grey_color,
  //         child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.end,
  //             children: <Widget>[Text('House Merchant v1.0', style: TextStyle(fontSize: 13, color: ThemeConstant.grey_color, letterSpacing: 0.26, ))]),
  //       ),
  //     ],
  //   )); //_myListView(context));
  // }
}
