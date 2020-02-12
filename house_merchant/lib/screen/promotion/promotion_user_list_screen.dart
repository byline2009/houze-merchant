import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
import 'package:house_merchant/screen/base/base_widget.dart';

class UserModel {
  String avatar;
  String name;
  String date;

  UserModel({this.avatar, this.name, this.date});
}

class CouponUserListScreen extends StatefulWidget {
  dynamic params;
  CouponUserListScreen({this.params, key}) : super(key: key);

  @override
  PromotionUsersScreenState createState() => new PromotionUsersScreenState();
}

class PromotionUsersScreenState extends State<CouponUserListScreen> {
  Size _screenSize;
  BuildContext _context;
  double _padding;
  List users;
  CouponModel _couponModel;

  @override
  void initState() {
    users = getUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this._screenSize = MediaQuery.of(context).size;
    this._padding = this._screenSize.width * 5 / 100;
    this._couponModel = widget.params['coupon_model'];

    Widget headerWidget = Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(_padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_couponModel.title,
              style: ThemeConstant.titleLargeStyle(ThemeConstant.black_color)),
          SizedBox(height: 12),
          BaseWidget.dividerBottom,
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                '0/${_couponModel.quantity}',
                style:
                    ThemeConstant.titleLargeStyle(ThemeConstant.primary_color),
              ),
              SizedBox(width: 5.0),
              Text(
                'Lượt sử dụng',
                style: TextStyle(
                    fontSize: ThemeConstant.font_size_16,
                    letterSpacing: ThemeConstant.letter_spacing_026,
                    color: ThemeConstant.grey_color),
              ),
            ],
          )
        ],
      ),
    );

    Widget userItem(UserModel user) {
      return Container(
          height: 80.0,
          decoration: BoxDecoration(color: ThemeConstant.white_color),
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              child: CircleAvatar(
                  backgroundColor: ThemeConstant.alto_color,
                  child: Text(
                    user.name[0],
                    style: ThemeConstant.titleLargeStyle(Colors.white),
                  )),
            ),
            title: Text(
              user.name,
              style: ThemeConstant.titleTileStyle,
            ),
            subtitle: Text(user.date, style: ThemeConstant.subtitleTileStyle),
          ));
    }

    final userListWidget = Container(
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return userItem(users[index]);
        },
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 2, color: ThemeConstant.background_grey_color),
      ),
    );

    // TODO: implement build
    return BaseScaffoldNormal(
        title: 'Danh sách sử dụng',
        child: SafeArea(
          child: Container(
              color: ThemeConstant.background_grey_color,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  headerWidget,
                  SizedBox(height: 10.0),
                  Expanded(child: userListWidget, flex: 1),
                ],
              )),
        ));
  }
}

List getUserList() {
  return [
    UserModel(
      avatar: '',
      name: "Minh Ngoc Nguyen",
      date: "Ngày sử dụng: 19:31 - 26/12/2020",
    ),
    UserModel(
      avatar: '',
      name: "Phan Minh Trí",
      date: "Ngày sử dụng: 19:31 - 26/12/2020",
    ),
    UserModel(
      avatar: '',
      name: "Nguyễn Thị Diệu An",
      date: "Ngày sử dụng: 19:31 - 26/12/2020",
    ),
    UserModel(
      avatar: '',
      name: "Nguyễn Cảnh Gia",
      date: "Ngày sử dụng: 19:31 - 26/12/2020",
    ),
    UserModel(
      avatar: '',
      name: "Phạm Minh Phương",
      date: "Ngày sử dụng: 19:31 - 26/12/2020",
    ),
    UserModel(
      avatar: '',
      name: "Ưu đãi đã kết thúc thời hạn",
      date: "Ngày sử dụng: 19:31 - 26/12/2020",
    ),
    UserModel(
      avatar: '',
      name: "Nguyễn Thị Diệu An",
      date: "Ngày sử dụng: 19:31 - 26/12/2020",
    ),
    UserModel(
      avatar: '',
      name: "Minh Ngoc Nguyen",
      date: "Ngày sử dụng: 19:31 - 26/12/2020",
    ),
    UserModel(
      avatar: '',
      name: "Phan Minh Trí",
      date: "Ngày sử dụng: 19:31 - 26/12/2020",
    ),
    UserModel(
      avatar: '',
      name: "Nguyễn Thị Diệu An",
      date: "Ngày sử dụng: 19:31 - 26/12/2020",
    ),
    UserModel(
      avatar: '',
      name: "Nguyễn Cảnh Gia",
      date: "Ngày sử dụng: 19:31 - 26/12/2020",
    ),
    UserModel(
      avatar: '',
      name: "Phạm Minh Phương",
      date: "Ngày sử dụng: 19:31 - 26/12/2020",
    ),
    UserModel(
      avatar: '',
      name: "Ưu đãi đã kết thúc thời hạn",
      date: "Ngày sử dụng: 19:31 - 26/12/2020",
    ),
    UserModel(
      avatar: '',
      name: "14.Nguyễn Thị Diệu An",
      date: "Ngày sử dụng: 19:31 - 26/12/2020",
    ),
  ];
}
