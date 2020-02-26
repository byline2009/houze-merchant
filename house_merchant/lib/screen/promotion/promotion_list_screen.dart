import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:house_merchant/constant/common_constant.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_scan_widget.dart';
import 'package:house_merchant/custom/dialogs/T7GDialog.dart';
import 'package:house_merchant/custom/group_radio_tags_widget.dart';
import 'package:house_merchant/custom/text_limit_widget.dart';
import 'package:house_merchant/middle/bloc/coupon/coupon_list_bloc.dart';
import 'package:house_merchant/middle/bloc/coupon/indext.dart';
import 'package:house_merchant/middle/model/coupon_model.dart';
import 'package:house_merchant/middle/model/qrcode_model.dart';
import 'package:house_merchant/middle/repository/coupon_repository.dart';
import 'package:house_merchant/router.dart';
import 'package:house_merchant/screen/base/base_widget.dart';
import 'package:house_merchant/screen/base/coming_soon_widget.dart';
import 'package:house_merchant/screen/base/image_widget.dart';
import 'package:house_merchant/screen/promotion/promotion_scan_success_screen.dart';
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
  var statusFilter = -1;

  CouponListBloc couponListBloc = CouponListBloc();
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
    couponListBloc.add(CouponLoadList(page: -1, status: this.statusFilter));
  }

  Widget tags() {
    return GroupRadioTagsWidget(
      tags: <GroupRadioTags>[
        GroupRadioTags(id: -1, title: "Tất cả"),
        GroupRadioTags(id: 1, title: "Đang chạy"),
        GroupRadioTags(id: 0, title: "Chờ duyệt"),
        GroupRadioTags(id: -2, title: "Hết hạn"),
        GroupRadioTags(id: 2, title: "Bị từ chối"),
        GroupRadioTags(id: 3, title: "Đã hủy"),
      ],
      callback: (dynamic id) {
        this.statusFilter = id;
        couponListBloc.add(CouponLoadList(page: -1, status: statusFilter));
      },
      defaultIndex: 0,
    );
  }

  Widget statusProduct(int status) {
    switch (status) {
      case -1:
        return Text(Promotion.expire,
            style: TextStyle(
                color: ThemeConstant.promotion_status_expired,
                fontFamily: ThemeConstant.form_font_family_display,
                fontSize: ThemeConstant.form_font_smaller,
                fontWeight: ThemeConstant.appbar_text_weight_bold));
      case Promotion.pendingStatus:
        return Text(Promotion.pending,
            style: TextStyle(
                color: ThemeConstant.promotion_status_pending,
                fontFamily: ThemeConstant.form_font_family_display,
                fontSize: ThemeConstant.form_font_smaller,
                fontWeight: ThemeConstant.appbar_text_weight_bold));
      case Promotion.approveStatus:
        return Text(Promotion.approved,
            style: TextStyle(
                color: ThemeConstant.promotion_status_running,
                fontFamily: ThemeConstant.form_font_family_display,
                fontSize: ThemeConstant.form_font_smaller,
                fontWeight: ThemeConstant.appbar_text_weight_bold));
      case Promotion.canceledStatus:
        return Text(Promotion.canceled,
            style: TextStyle(
                color: ThemeConstant.promotion_status_expired,
                fontFamily: ThemeConstant.form_font_family_display,
                fontSize: ThemeConstant.form_font_smaller,
                fontWeight: ThemeConstant.appbar_text_weight_bold));
      case Promotion.rejectStatus:
        return Text(Promotion.rejected,
            style: TextStyle(
                color: ThemeConstant.promotion_status_cancel,
                fontFamily: ThemeConstant.form_font_family_display,
                fontSize: ThemeConstant.form_font_smaller,
                fontWeight: ThemeConstant.appbar_text_weight_bold));
    }
    return Text('');
  }

  Widget itemCard(CouponModel couponModel) {
    var startDate = DateFormat(Format.timeAndDate)
        .format(DateTime.parse(couponModel.startDate).toLocal());
    var endDate = DateFormat(Format.timeAndDate)
        .format(DateTime.parse(couponModel.endDate).toLocal());
    return Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 80,
                    height: 80,
                    child: couponModel.images.length > 0
                        ? ImageWidget(
                            imgUrl: couponModel.images.first.imageThumb,
                            width: 80,
                            height: 80)
                        : SvgPicture.asset(
                            'assets/images/ic-promotion-default.svg')),
                SizedBox(width: 12),
                Expanded(
                    child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(children: <Widget>[
                        TextLimitWidget(couponModel.title,
                            maxLines: 2,
                            style: new TextStyle(
                              letterSpacing: 0.26,
                              fontWeight: FontWeight.w500,
                              fontSize: ThemeConstant.form_font_title,
                              fontFamily:
                                  ThemeConstant.form_font_family_display,
                              color: ThemeConstant.black_color,
                            ))
                      ]),
                      SizedBox(height: 5),
                      statusProduct(couponModel.isExpired == true
                          ? -1
                          : couponModel.status),
                    ],
                  ),
                ))
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(couponModel.getUsedCound(),
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
        ));
  }

  @override
  Widget build(BuildContext context) {
    this._screenSize = MediaQuery.of(context).size;
    this._padding = this._screenSize.width * 5 / 100;
    var _dataDisplay = List<CouponModel>();

    return SafeArea(
        child: Container(
      color: ThemeConstant.background_grey_color,
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              child: Column(
                children: <Widget>[
                  this.tags(),
                  Expanded(
                      child: Container(
                          color: ThemeConstant.background_grey_color,
                          child: BlocBuilder(
                              bloc: couponListBloc,
                              builder: (BuildContext context,
                                  CouponList couponList) {
                                _dataDisplay = couponList.data;

                                if (couponList.data.length == 0 &&
                                    this.statusFilter == -1) {
                                  return Container(
                                      color: Colors.white,
                                      child: ComingSoonWidget(
                                          description:
                                              'Ưu đãi hiện đang trống\nNhanh tay bấm nút “Tạo mới” nào!',
                                          assetImgPath:
                                              'assets/images/ic-promotion-default.svg'));
                                }

                                if (!couponListBloc.isNext &&
                                    couponList != null &&
                                    couponList.data.length == 0) {
                                  return Center(
                                      child: Padding(
                                          padding: EdgeInsets.only(bottom: 20),
                                          child: Text(LocalizationsUtil.of(
                                                  context)
                                              .translate(
                                                  "Chưa có lịch sử đăng ký"))));
                                }

                                _refreshController.loadComplete();
                                _refreshController.refreshCompleted();

                                return Scrollbar(
                                    child: SmartRefresher(
                                        controller: _refreshController,
                                        enablePullDown: true,
                                        enablePullUp: true,
                                        header: MaterialClassicHeader(),
                                        footer: CustomFooter(builder:
                                            (BuildContext context,
                                                LoadStatus mode) {
                                          Widget body = Center();

                                          if (couponListBloc.isNext == false) {
                                            mode = LoadStatus.noMore;
                                          }

                                          if (mode == LoadStatus.loading) {
                                            body = CupertinoActivityIndicator();
                                          }

                                          if (mode == LoadStatus.noMore) {
                                            body = Text(
                                                '- Không còn dữ liệu để hiển thị -');
                                          }

                                          return Container(
                                            height: 50,
                                            child: Center(child: body),
                                          );
                                        }),
                                        onRefresh: () {
                                          couponListBloc.add(CouponLoadList(
                                              page: -1,
                                              status: this.statusFilter));
                                        },
                                        onLoading: () {
                                          if (mounted) {
                                            couponListBloc.add(
                                              CouponLoadList(
                                                  status: this.statusFilter),
                                            );
                                          }
                                        },
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemBuilder: (c, index) {
                                            return GestureDetector(
                                                onTap: () {
                                                  Router.push(
                                                      context,
                                                      Router.COUPON_DETAIL_PAGE,
                                                      {
                                                        "coupon_model":
                                                            couponList
                                                                .data[index]
                                                      });
                                                },
                                                child: Padding(
                                                  child: this.itemCard(
                                                      couponList.data[index]),
                                                  padding: EdgeInsets.only(
                                                      left: this._padding,
                                                      right: this._padding,
                                                      top: 10),
                                                ));
                                          },
                                          itemCount: couponList.data.length,
                                        )));
                              }))),
                ],
              ),
              color: Colors.white,
            ),
          ),
          Positioned(
              child: _dataDisplay.length == 0 ? Center() : scanQRButton())
        ],
      ),
    ));
  }

  bool checkValidate(String scanQR) {
    return (scanQR.length > 0 && scanQR.contains(','));
  }

  _navigatedToPromotionScanSuccessScreen(QrCodeModel rs) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) {
              return PromotionScanSuccessScreen(params: {
                'qr_code_model': rs,
                'callback': (bool refreshData) {
                  if (refreshData) {
                    couponListBloc.add(CouponLoadList(page: -1, status: -1));
                    return;
                  }
                  return;
                }
              });
            },
            settings: RouteSettings(name: Router.COUPON_SCAN_QR_SUCCESS_PAGE),
            fullscreenDialog: true));
  }

  Future _openAndCheckQRCode() async {
    String resultQRCode;

    try {
      resultQRCode = await FlutterBarcodeScanner.scanBarcode(
          "#7a1dff", "Hủy", true, ScanMode.QR);
    } on PlatformException {
      T7GDialog.showContentDialog(context, [showErrorPopup()],
          closeShow: false, barrierDismissible: false);
    }

    if (!mounted) return null;
    if (this.checkValidate(resultQRCode)) {
      String _id = resultQRCode.split(',').first;
      String _code = resultQRCode.split(',').last;

      if (_id != null && _code != null) {
        var rs;
        try {
          var couponRepository = CouponRepository();
          rs = await couponRepository.checkQR(_id, _code);
        } catch (e) {
          T7GDialog.showContentDialog(context, [showErrorPopup()],
              closeShow: false, barrierDismissible: false);
          return;
        }

        if (rs != null) {
          if (rs.isUsed == true) {
            Fluttertoast.showToast(
                msg: "Mã này đã sử dụng!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 5,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            _navigatedToPromotionScanSuccessScreen(rs);
          }
          return;
        }
      }
    }
    T7GDialog.showContentDialog(context, [showErrorPopup()],
        closeShow: false, barrierDismissible: false);
  }

  Widget showErrorPopup() {
    final width = this._screenSize.width * 90 / 100;
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
            width: width,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                SvgPicture.asset(
                  "assets/images/dialogs/ic-scan-failed.svg",
                ),
                SizedBox(height: 20),
                Text(LocalizationsUtil.of(context).translate('Quét thất bại!'),
                    style: TextStyle(
                      fontFamily: ThemeConstant.form_font_family_display,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.38,
                      color: ThemeConstant.black_color,
                    )),
                SizedBox(height: 20),
                Center(
                    child: Text(
                  LocalizationsUtil.of(context).translate(
                      'Mã QR không hợp lệ\nhoặc không tồn tại trong ưu đãi này.\nVui lòng kiểm tra lại thông tin'),
                  style: TextStyle(
                      fontFamily: ThemeConstant.form_font_family_display,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.26,
                      color: ThemeConstant.grey_color),
                  textAlign: TextAlign.center,
                )),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 48.0,
                        child:
                            BaseWidget.buttonThemePink('Thử lại', callback: () {
                          Navigator.of(context).popUntil((route) {
                            return route.isFirst;
                          });
                          this._openAndCheckQRCode();
                        }),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                        child: Container(
                      height: 48.0,
                      child: BaseWidget.buttonOutline('Thoát', callback: () {
                        Navigator.of(context).popUntil((route) {
                          return route.isFirst;
                        });
                      }),
                    )),
                  ],
                )
              ],
            )));
  }

  Widget scanQRButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ButtonScanQRWidget(
        callback: () async {
          _openAndCheckQRCode();
        },
      ),
    );
  }
}
