import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:christian_picker_image/christian_picker_image.dart';

typedef void callBackUploadHandler(File file);

class PromotionPickerImage extends StatefulWidget {
  callBackUploadHandler callbackUpload;
  callBackUploadHandler callbackRemove;

  PromotionPickerImage({Key key, double widthItem, double heightItem})
      : super(key: key);

  @override
  PromotionPickerImageState createState() => new PromotionPickerImageState();
}

class PromotionPickerImageState extends State<PromotionPickerImage> {
  List<File> filesPick;
  Size _screenSize;

  @override
  void initState() {
    super.initState();
    this.filesPick = new List<File>();
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

  @override
  Widget build(BuildContext context) {
    this._screenSize = MediaQuery.of(context).size;

    double _width = _screenSize.width * (160 / 375);
    double _height = _screenSize.height * (140 / 812);
    return GestureDetector(
        onTap: () {
          this.pickImage(context);
        },
        child: DottedBorder(
            borderType: BorderType.RRect,
            dashPattern: [2, 2],
            color: ThemeConstant.border_color,
            radius: Radius.circular(4),
            child: Container(
              width: _width,
              height: _height,
              child: Center(
                child: SvgPicture.asset(
                  "assets/images/ic-add-picture.svg",
                  width: 40,
                  height: 40,
                ),
              ),
            )
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: <Widget>[
            //     SvgPicture.asset(
            //       "assets/images/ic-add-picture.svg",
            //       width: 40,
            //       height: 40,
            //     ),
            //   ],
            // )),
            ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
