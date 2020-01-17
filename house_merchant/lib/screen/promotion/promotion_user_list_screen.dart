import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';

class UserModel {
  String avatar;
  String name;
  String date;

  UserModel({this.avatar, this.name, this.date});
}

class CouponUserListScreen extends StatefulWidget {
  CouponUserListScreen({Key key}) : super(key: key);

  @override
  PromotionUsersScreenState createState() => new PromotionUsersScreenState();
}

class PromotionUsersScreenState extends State<CouponUserListScreen> {
  Size _screenSize;
  BuildContext _context;
  double _padding;
  List users;

  @override
  void initState() {
    users = getUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this._screenSize = MediaQuery.of(context).size;
    this._padding = this._screenSize.width * 5 / 100;

    Widget headerWidget = Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(_padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Ưu đãi 25% mừng Lễ Giáng Sinh 2019',
              style: ThemeConstant.titleLargeStyle(ThemeConstant.black_color)),
          SizedBox(height: 12),
          ThemeConstant.dividerBottom,
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                '21/50',
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
              child:
                  SvgPicture.asset("assets/images/ic-promotion-highlight.svg"),
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
      name: "1. Minh Ngoc Nguyen",
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
