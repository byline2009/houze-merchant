import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/screen/base/boxes_container.dart';

class MoreScreen extends StatefulWidget {
  MoreScreen({Key key}) : super(key: key);

  @override
  MoreScreenState createState() => MoreScreenState();
}

class MoreScreenState extends State<MoreScreen> {
  Widget headerWidget() {
    return Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 30,
                ),
                SizedBox(width: 15.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Lê Thị Minh Cún',
                      style: ThemeConstant.headerTitleStyle(
                          ThemeConstant.black_color),
                    ),
                    SizedBox(height: 5.0),
                    Text('QUẢN LÝ CỬA HÀNG',
                        style: TextStyle(
                            fontSize: 13.0,
                            color: ThemeConstant.violet_color,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.26))
                  ],
                )
              ],
            ),
            SizedBox(height: 26.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: Text(
                  'HouseMap coffee',
                  style:
                      ThemeConstant.headerTitleStyle(ThemeConstant.black_color),
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
                        style: ThemeConstant.headerTitleStyle(
                            ThemeConstant.start_yelow_color),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }

  List _buildList(List<String> titleList) {
    List<Widget> listItems = List();

    for (int i = 0; i < titleList.length; i++) {
      listItems.add(whiteRow(titleList[i]));
    }
    return listItems;
  }

  Widget whiteRow(String title) {
    return GestureDetector(
        onTap: () {
          print(title);
        },
        child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: ThemeConstant.decorationGreyBottom(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: ThemeConstant.black_color,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.26),
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: ThemeConstant.alto_color,
                )
              ],
            )));
  }

  Widget greyRow(String title) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
      height: 50.0,
      color: ThemeConstant.background_grey_color,
      child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: 18.0,
              color: ThemeConstant.unselected_color,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.29),
        )
      ]),
    );
  }

  // Widget bottomSection() {
  //   return SliverToBoxAdapter(
  //     child: ,
  //   );
  // }

  Widget arrowButton() {
    return Icon(
      Icons.arrow_forward,
      color: ThemeConstant.grey_color,
      size: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: BoxesContainer(
              child: headerWidget(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(_buildList([
              'Trạng thái cửa hàng',
              'Quản lý tài khoản',
              'Thông tin cá nhân'
            ])),
          ),
          SliverToBoxAdapter(
            child: greyRow('Hỗ trợ'),
          ),
          SliverList(
            delegate: SliverChildListDelegate(_buildList([
              'Liên hệ House Merchant',
              'Quy định & Điều khoản',
            ])),
          ),
        ],
      ),
    );
  }
}
