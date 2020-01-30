import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/group_radio_tags_widget.dart';
import 'package:house_merchant/custom/text_limit_widget.dart';
import 'package:house_merchant/middle/bloc/coupon/coupon_list_bloc.dart';
import 'package:house_merchant/middle/bloc/coupon/indext.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:house_merchant/router.dart';
import 'package:house_merchant/screen/base/image_widget.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CouponListScreen extends StatefulWidget {
  dynamic params;

  CouponListScreen({this.params, Key key}) : super(key: key);

  @override
  CouponListScreenState createState() => new CouponListScreenState();
}

class CouponListScreenState extends State<CouponListScreen> {

  Size _screenSize;
  double _padding;

  CouponListBloc couponListBloc = CouponListBloc();

  RefreshController _refreshController = RefreshController(initialRefresh: true);
  ScrollController listScrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
  }

  Widget tags() {
    return GroupRadioTagsWidget(
      tags: <GroupRadioTags>[
        GroupRadioTags(
          id: -1,
          title: "Tất cả",
        ),
        GroupRadioTags(id: 0, title: "Đang chạy"),
        GroupRadioTags(id: 1, title: "Chờ duyệt"),
        GroupRadioTags(id: 2, title: "Hết hạn"),
      ],
      callback: (dynamic index) {},
      defaultIndex: 0,
    );
  }

  Widget statusProduct(int status) {
    switch (status) {
      case 0:
        return Text('CHỜ DUYỆT',
            style: TextStyle(
                color: ThemeConstant.promotion_status_pending,
                fontFamily: ThemeConstant.form_font_family_display,
                fontSize: ThemeConstant.form_font_smaller,
                fontWeight: ThemeConstant.appbar_text_weight_bold));
      case 1:
        return Text('ĐANG CHẠY',
            style: TextStyle(
                color: ThemeConstant.promotion_status_running,
                fontFamily: ThemeConstant.form_font_family_display,
                fontSize: ThemeConstant.form_font_smaller,
                fontWeight: ThemeConstant.appbar_text_weight_bold));
      case 2:
        return Text('HẾT HẠN',
            style: TextStyle(
                color: ThemeConstant.promotion_status_expired,
                fontFamily: ThemeConstant.form_font_family_display,
                fontSize: ThemeConstant.form_font_smaller,
                fontWeight: ThemeConstant.appbar_text_weight_bold));
    }
    return Text('');
  }

  Widget itemCard(CouponModel couponModel) {
    var startDate = DateFormat('HH:mm - dd/MM/yyyy')
        .format(DateTime.parse(couponModel.startDate));

    var endDate = DateFormat('HH:mm - dd/MM/yyyy')
        .format(DateTime.parse(couponModel.endDate));

    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  child: ImageWidget(
                      imgUrl: couponModel.images.length > 0
                          ? couponModel.images.first.imageThumb
                          : "https://anhdaostorage.blob.core.windows.net/qa-media/facility/20191114014630397045/meeting-room.jpg",
                      width: 80,
                      height: 80),
                  width: 80,
                  height: 80,
                  color: ThemeConstant.background_grey_color),
              SizedBox(width: 12),
              Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            TextLimitWidget(couponModel.title,
                                maxLines: 2,
                                style: new TextStyle(
                                  letterSpacing: 0.26,
                                  fontWeight: FontWeight.w500,
                                  fontSize: ThemeConstant.form_font_title,
                                  fontFamily:
                                  ThemeConstant.form_font_family_display,
                                  color: ThemeConstant.black_color,
                                )),
                          ],
                        ),
                        SizedBox(height: 5),
                        statusProduct(couponModel.status),
                      ],
                    ),
                  ))
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('0/${couponModel.quantity}',
                  style: new TextStyle(
                    fontSize: ThemeConstant.label_font_size,
                    fontFamily: ThemeConstant.form_font_family_display,
                    color: ThemeConstant.black_color,
                  )),
              Text('Từ $startDate',
                  style: new TextStyle(
                    fontSize: ThemeConstant.form_font_small,
                    fontFamily: ThemeConstant.form_font_family_display,
                    color: ThemeConstant.grey_color,
                  )),
            ],
          ),
          SizedBox(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Lượt sử dụng',
                  style: new TextStyle(
                    fontSize: ThemeConstant.form_font_small,
                    fontFamily: ThemeConstant.form_font_family_display,
                    color: ThemeConstant.grey_color,
                  )),
              Text('Đến $endDate',
                  style: new TextStyle(
                    fontSize: ThemeConstant.form_font_small,
                    fontFamily: ThemeConstant.form_font_family_display,
                    color: ThemeConstant.grey_color,
                  )),
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      height: 155,
    );
  }

  @override
  Widget build(BuildContext context) {

    this._screenSize = MediaQuery.of(context).size;
    this._padding = this._screenSize.width * 5 / 100;

    return Column(
          children: <Widget>[
            this.tags(),
            Expanded(
              child: Container(
                color: ThemeConstant.background_grey_color,
                child: BlocBuilder(
                  bloc: couponListBloc,
                  builder: (BuildContext context, CouponList couponList) {

                    print('couponList');
                    print(couponList.data);

                    if (couponList == null) {
                      return Center(child: Text(LocalizationsUtil.of(context).translate("Mất kết nối")));
                    }

                    if (!this.couponListBloc.isNext && couponList != null && couponList.data.length == 0) {
                      return Center(child: Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(LocalizationsUtil.of(context).translate("Chưa có lịch sử đăng ký"))
                      ));
                    }

                    _refreshController.loadComplete();
                    _refreshController.refreshCompleted();

                    return Scrollbar(child: SmartRefresher(
                        controller: _refreshController,
                        enablePullDown: true,
                        enablePullUp: true,
                        header: MaterialClassicHeader(),
                        footer: CustomFooter(
                            builder: (BuildContext context, LoadStatus mode) {
                              Widget body = Center();

                              if (this.couponListBloc.isNext == false) {
                                mode = LoadStatus.noMore;
                              }

                              if (mode==LoadStatus.loading) {
                                body = CupertinoActivityIndicator();
                              }

                              if (mode == LoadStatus.noMore) {
                                body = Text('- Không còn dữ liệu để hiển thị -');
                              }

                              return Container(
                                height: 50,
                                child: Center(child: body),
                              );
                            }
                        ),
                        onRefresh: () {
                          this.couponListBloc.add(CouponLoadList(page: 1));
                        },
                        onLoading: () {
                          if (mounted) {
                            this.couponListBloc.add(
                              CouponLoadList(),
                            );
                          }
                        },
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (c, index) {
                            return GestureDetector(
                                onTap: () {
                                  Router.push(
                                      context, Router.COUPON_DETAIL_PAGE, {
                                    "coupon_model": couponList.data[index],
                                  });
                                },
                                child: Padding(
                                  child: this.itemCard(couponList.data[index]),
                                  padding: EdgeInsets.only(
                                      left: this._padding,
                                      right: this._padding,
                                      top: 10,
                                      bottom: 10),
                                ));
                          },
                          itemCount: couponList.data.length,
                        )
                    ));
                  })
            ))
          ],
        );
  }

}
