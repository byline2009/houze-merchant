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

  PromotionPickerImage({Key key}) : super(key: key);

  @override
  PromotionPickerImageState createState() => new PromotionPickerImageState();
}

class PromotionPickerImageState extends State<PromotionPickerImage> {

  List<File> filesPick;

  @override
  void initState() {
    super.initState();
    this.filesPick = new List<File>();
  }

  void uploadProcessing(BuildContext context) async {

    List<File> images = new List<File>();
    try {
      images = await ChristianPickerImage.pickImages(maxImages: 1-this.filesPick.length);
    } catch(e) {
    } finally {
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
    return GestureDetector(
      onTap: () {
        this.pickImage(context);
      }, child: DottedBorder(
        borderType: BorderType.RRect,
        dashPattern: [2, 2],
        color: ThemeConstant.border_color,
        radius: Radius.circular(5),
        child: Container(
          width: 120,
          height: 110,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset("assets/images/ic-add-picture.svg", width: 31, height: 32,),
            ],
          )
        ),
      ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}