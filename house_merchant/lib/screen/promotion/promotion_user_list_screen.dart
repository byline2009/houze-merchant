import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/middle/bloc/coupon/indext.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:house_merchant/middle/model/coupon_user_model.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
import 'package:house_merchant/screen/base/base_widget.dart';
import 'package:house_merchant/screen/base/boxes_container.dart';
import 'package:intl/intl.dart';

class CouponUserListScreen extends StatefulWidget {
  dynamic params;
  CouponUserListScreen({this.params, key}) : super(key: key);

  @override
  PromotionUsersScreenState createState() => new PromotionUsersScreenState();
}

class PromotionUsersScreenState extends State<CouponUserListScreen> {
  Size _screenSize;
  double _padding;
  List<CouponUserModel> users;
  CouponModel _couponModel;
  final _couponBloc = CouponBloc();

  @override
  void initState() {
    this._couponModel = widget.params['coupon_model'];
    _couponBloc.add(CouponUserLoadList(id: _couponModel.id));
    print(_couponModel.id);
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
          Text(_couponModel.title,
              style: ThemeConstant.titleLargeStyle(ThemeConstant.black_color)),
          SizedBox(height: 12),
          BaseWidget.dividerBottom,
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                _couponModel.getUsedCound(),
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

    Widget userItem(CouponUserModel user) {
      return Container(
          height: 80.0,
          decoration: BoxDecoration(color: ThemeConstant.white_color),
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              child: CircleAvatar(
                  backgroundColor: ThemeConstant.alto_color,
                  child: user.customer.avatar == null
                      ? BaseWidget.avatar(user.customer.avatar, 'O', 50)
                      : Text(
                          user.customer.fullname[0],
                          style: ThemeConstant.titleLargeStyle(Colors.white),
                        )),
            ),
            title: Text(
              user.customer.fullname,
              style: ThemeConstant.titleTileStyle,
            ),
            subtitle: Text(
                'Ngày sử dụng: ' +
                    DateFormat('HH:mm - dd/MM/yyyy')
                        .format(DateTime.parse(user.created)),
                style: ThemeConstant.subtitleTileStyle),
          ));
    }

    Widget userListWidget(List<CouponUserModel> rs) {
      return Container(
          child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: rs.length,
        itemBuilder: (BuildContext context, int index) {
          return userItem(rs[index]);
        },
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 2, color: ThemeConstant.background_grey_color),
      ));
    }

    return BaseScaffoldNormal(
        title: 'Danh sách sử dụng',
        child: SafeArea(
            child: BlocBuilder(
                bloc: _couponBloc,
                builder: (BuildContext context, CouponState currentState) {
                  print("Status: $currentState");

                  if (currentState is CouponGetUserListSuccessful) {
                    List<CouponUserModel> rs = currentState.result;
                    print("List<CouponUserModel>: ${rs.length}");

                    this.users = rs;
                    return CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverToBoxAdapter(
                              child: BoxesContainer(child: Center())),
                          SliverToBoxAdapter(
                              child: BoxesContainer(child: headerWidget)),
                          SliverToBoxAdapter(
                            child: BoxesContainer(
                              child: userListWidget(rs),
                            ),
                          ),
                        ]);
                  }
                  return Center();
                })));
  }
}
