import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_merchant/constant/common_constant.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/flutter_skeleton/flutter_skeleton.dart';
import 'package:house_merchant/middle/bloc/coupon/indext.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:house_merchant/middle/model/coupon_user_model.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
import 'package:house_merchant/screen/base/base_widget.dart';
import 'package:house_merchant/screen/base/widget_somthing_went_wrong.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'users_used/empty_page.dart';
import 'users_used/header_numbder_users_used.dart';

class CouponUserListScreen extends StatefulWidget {
  final dynamic params;
  const CouponUserListScreen({this.params, key}) : super(key: key);

  @override
  PromotionUsersScreenState createState() => new PromotionUsersScreenState();
}

class PromotionUsersScreenState extends State<CouponUserListScreen> {
  List<CouponUserModel> list = [];
  List<CouponUserModel> listTemp = [];
  int page = 0;

  CouponModel _couponModel;
  final _couponBloc = CouponBloc(CouponInitial());
  bool shouldLoadMore = true;
  ScrollController scrollController;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    this._couponModel = widget.params['coupon_model'];
    scrollController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    refreshController.dispose();
    scrollController.dispose();

    super.dispose();
  }

  void _onRefresh() {
    page = 0;
    listTemp.clear();
    list.clear();
    shouldLoadMore = true;
    _couponBloc.add(CouponUserLoadList(id: _couponModel.id, page: page));
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }

  void _onLoading() {
    if (this.shouldLoadMore) {
      this.page++;
      listTemp.clear();
      _couponBloc.add(CouponUserLoadList(id: _couponModel.id, page: page));
      refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldNormal(
        title: 'Danh sách sử dụng',
        child: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              HeaderNumberUsersUsed(couponModel: _couponModel),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: BlocBuilder(
                      bloc: _couponBloc,
                      builder:
                          (BuildContext context, CouponState currentState) {
                        print("Status: $currentState");
                        if (currentState is CouponInitial && page == 0) {
                          _couponBloc.add(CouponUserLoadList(
                              id: _couponModel.id, page: page));
                        }

                        if (currentState is CouponLoading && page == 0) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            child: ListSkeleton(
                              shrinkWrap: true,
                              length: 4,
                              config: SkeletonConfig(
                                theme: SkeletonTheme.Light,
                                isShowAvatar: true,
                                isCircleAvatar: true,
                                bottomLinesCount: 2,
                              ),
                            ),
                          );
                        }

                        if (currentState is CouponFailure) {
                          return SomethingWentWrong();
                        }

                        if (currentState is CouponGetUserListSuccessful &&
                            listTemp.isEmpty) {
                          final List<CouponUserModel> test =
                              (currentState.result);

                          shouldLoadMore = test.length >= 10;
                          listTemp.addAll(test);
                          list.addAll(test.toList());
                          if (list.length == 0) {
                            return EmptyPage();
                          }

                          print("List<CouponUserModel>: ${list.length}");
                        }
                        return SmartRefresher(
                            enablePullDown: true,
                            enablePullUp: true,
                            header: MaterialClassicHeader(color: Colors.white),
                            footer: CustomFooter(builder:
                                (BuildContext context, LoadStatus mode) {
                              Widget body;
                              if (shouldLoadMore == false) {
                                mode = LoadStatus.noMore;
                              }

                              if (mode == LoadStatus.idle ||
                                  mode == LoadStatus.loading) {
                                body = CupertinoActivityIndicator();
                              } else {
                                body =
                                    Text("- Không còn dữ liệu để hiển thị -");
                              }
                              return Container(
                                  height: 80, child: Center(child: body));
                            }),
                            controller: refreshController,
                            onRefresh: _onRefresh,
                            onLoading: _onLoading,
                            child: ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                controller: scrollController,
                                shrinkWrap: true,
                                itemCount: list.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return UserItem(user: list[index]);
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Divider(
                                            height: 2,
                                            color: ThemeConstant
                                                .background_grey_color)));
                      }),
                ),
              )
            ])));
  }
}

class UserItem extends StatelessWidget {
  final CouponUserModel user;

  const UserItem({this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80.0,
        key: Key(user.id),
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
              width: 50,
              height: 50,
              child: CircleAvatar(
                  backgroundColor: ThemeConstant.alto_color,
                  child: user.customer.avatar != null
                      ? BaseWidget.avatar(user.customer.avatar, 'O', 50)
                      : Text(
                          user.customer.fullName[0],
                          style: ThemeConstant.titleLargeStyle(Colors.white),
                        ))),
          title:
              Text(user.customer.fullName, style: ThemeConstant.titleTileStyle),
          subtitle: Text(
              'Ngày sử dụng: ' +
                  DateFormat(Format.timeAndDate)
                      .format(DateTime.parse(user.modified).toLocal())
                      .toString(),
              style: ThemeConstant.subtitleTileStyle),
        ));
  }
}
