import 'dart:async';
import 'dart:io';

import 'package:christian_picker_image/christian_picker_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_widget.dart';
import 'package:house_merchant/middle/model/promotion_model.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
import 'package:house_merchant/screen/base/image_widget.dart';
import 'package:house_merchant/screen/promotion/promotion_picker_image.dart';
import 'package:house_merchant/utils/localizations_util.dart';

class StoreEditScreen extends StatefulWidget {
  StoreEditScreen({Key key}) : super(key: key);

  @override
  StoreEditScreenState createState() => new StoreEditScreenState();
}

class StoreEditScreenState extends State<StoreEditScreen> {
  Size _screenSize;
  BuildContext _context;
  double _padding;
  StreamController<ButtonSubmitEvent> saveButtonController =
      new StreamController<ButtonSubmitEvent>.broadcast();
  final imagePicker = new PromotionPickerImage();

  List<File> filesPick;

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
        imgUrl:
            "https://images.adsttc.com/media/images/51d4/84a8/b3fc/4bea/e100/01d6/large_jpg/Portada.jpg?1372882078"),
  ];
  @override
  void initState() {
    super.initState();
    this.filesPick = new List<File>();
  }

  Widget titleInSection(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: ThemeConstant.titleLargeStyle(Colors.black),
        ),
        SizedBox(height: 5),
        Text(
          subtitle,
          style: ThemeConstant.subtitleStyle(ThemeConstant.grey_color),
        )
      ],
    );
  }

  Widget photoItem(int index) {
    double _width = _screenSize.width * (160 / 375);
    double _height = _screenSize.height * (140 / 812);

    return GestureDetector(
      onTap: () {
        print(index);
      },
      child: Container(
          decoration: ThemeConstant.borderOutline(Colors.transparent),
          width: _width,
          height: _height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: ImageWidget(
                  imgUrl: products[index - 1].imgUrl,
                  width: _width,
                  height: _height,
                ),
              ),
            ],
          )),
    );
  }

  Widget _gridList() {
    return GridView.builder(
      itemCount: products.length + 1,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              child: index == 0 ? imagePicker : photoItem(index),
              onTap: () {},
            ));
      },
    );
  }

  void uploadProcessing(BuildContext context) async {
    List<File> images = new List<File>();
    try {
      images = await ChristianPickerImage.pickImages(
          maxImages: 1 - this.filesPick.length);
    } catch (e) {} finally {
      Navigator.of(context).pop();
      print('Upload okkk');
    }
  }

  Future pickImage(BuildContext context) async {
    var isShow = false;
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (!isShow) {
            isShow = true;
            uploadProcessing(context);
          }
          return Center();
        });
  }

  Widget buildBody() {
    return Positioned(
        right: 0.0,
        left: 0,
        bottom: 0,
        top: 10.0,
        child: Container(
          decoration: BoxDecoration(color: ThemeConstant.white_color),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              titleInSection('Hình ảnh (3/4 tấm)',
                  'Hình ảnh đẹp sẽ để lại một ấn tượng tốt cho khách hàng'),
              SizedBox(height: 15),
              // imagePicker,
              Expanded(
                child: _gridList(),
              )
            ],
          ),
          padding: EdgeInsets.all(_padding),
        ));
  }

  @override
  Widget build(BuildContext context) {
    this._screenSize = MediaQuery.of(context).size;
    this._context = context;
    this._padding = this._screenSize.width * 5 / 100;

    final buttonBottom = Positioned(
      bottom: 20.0,
      left: 20.0,
      right: 20.0,
      child: ButtonWidget(
          controller: saveButtonController,
          defaultHintText:
              LocalizationsUtil.of(_context).translate('Lưu thay đổi'),
          callback: () async {}),
    );
    // TODO: implement build
    return BaseScaffoldNormal(
      title: 'Chỉnh sửa cửa hàng',
      child: Stack(
        children: <Widget>[
          Container(
            decoration:
                BoxDecoration(color: ThemeConstant.background_grey_color),
          ),
          buildBody(),
          buttonBottom
        ],
      ),
    );
  }
}
