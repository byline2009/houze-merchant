import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_create_widget.dart';
import 'package:house_merchant/custom/group_radio_tags_widget.dart';
import 'package:house_merchant/custom/text_limit_widget.dart';
import 'package:house_merchant/middle/model/promotion_model.dart';
import 'package:house_merchant/router.dart';
import 'package:house_merchant/screen/base/base_scaffold.dart';
import 'package:house_merchant/screen/base/image_widget.dart';

class PromotionScreen extends StatefulWidget {
  PromotionScreen({Key key}) : super(key: key);

  @override
  PromotionScreenState createState() => PromotionScreenState();
}

class PromotionScreenState extends State<PromotionScreen> {
  Size _screenSize;
  double _padding;

  List<PromotionModel> products = [
    PromotionModel(
        promotionTitle: "Mua 1 tặng 1 dành cho menu nước Chào Xuân",
        status: 0,
        promotionCurrent: 2,
        promotionMax: 20,
        expireStart: "2019-11-17T09:37:21Z",
        expireEnd: "2020-6-19T09:37:21Z",
        imgUrl:
            "https://anhdaostorage.blob.core.windows.net/qa-media/facility/20191114014531987127/bbq-pmh.jpg"),
    PromotionModel(
        promotionTitle: "Ưu đãi 25% mừng Lễ Giáng Sinh 2019",
        status: 1,
        promotionCurrent: 21,
        promotionMax: 50,
        expireStart: "2019-11-17T09:37:21Z",
        expireEnd: "2020-6-19T09:37:21Z",
        imgUrl:
            "https://anhdaostorage.blob.core.windows.net/qa-media/facility/20191114014630397045/meeting-room.jpg"),
    PromotionModel(
        promotionTitle: "Tặng ngay 20 mã khuyến mãi cho khách hàng nữ",
        status: 2,
        promotionCurrent: 20,
        promotionMax: 20,
        expireStart: "2019-11-17T09:37:21Z",
        expireEnd: "2020-6-19T09:37:21Z",
        imgUrl: ""),
  ];

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
    return Center();
  }

  Widget itemCard(PromotionModel promotionModel) {
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
                      imgUrl: promotionModel.imgUrl, width: 80, height: 80),
                  width: 80,
                  height: 80,
                  color: ThemeConstant.background_grey_color),
              SizedBox(width: 12),
              Expanded(
                  child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        TextLimitWidget(promotionModel.promotionTitle,
                            maxLines: 2,
                            style: new TextStyle(
                              fontSize: ThemeConstant.form_font_title,
                              fontFamily:
                                  ThemeConstant.form_font_family_display,
                              color: ThemeConstant.black_color,
                            )),
                      ],
                    ),
                    SizedBox(height: 5),
                    statusProduct(promotionModel.status),
                  ],
                ),
              ))
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('0/40',
                  style: new TextStyle(
                    fontSize: ThemeConstant.label_font_size,
                    fontFamily: ThemeConstant.form_font_family_display,
                    color: ThemeConstant.black_color,
                  )),
              Text('Từ 12:00 - 01/01/2020',
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
              Text('Đến 23:59 - 20/10/2019',
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

    return BaseScaffold(
        title: 'Ưu đãi',
        trailing: Padding(
            child: ButtonCreateWidget(
              title: "Tạo mới",
              callback: () {
                Router.pushNoParams(context, Router.PROMOTION_CREATE);
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 25.0,
              ),
            ),
            padding: EdgeInsets.only(right: this._padding)),
        child: Column(
          children: <Widget>[
            this.tags(),
            Expanded(
              child: Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (c, index) {
                      return GestureDetector(
                          onTap: () {
                            Router.pushNoParams(
                                context, Router.PROMOTION_DETAIL_PAGE);
                          },
                          child: Padding(
                            child: this.itemCard(products[index]),
                            padding: EdgeInsets.only(
                                left: this._padding,
                                right: this._padding,
                                top: 10,
                                bottom: 10),
                          ));
                    },
                    itemCount: products.length,
                  ),
                  color: ThemeConstant.background_grey_color),
            )
          ],
        ));
  }
}
