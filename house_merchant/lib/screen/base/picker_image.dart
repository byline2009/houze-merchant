import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:christian_picker_image/christian_picker_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

typedef void callBackUploadHandler(File file);

enum PickerImageType { grid, list }

class PickerImage extends StatefulWidget {
  callBackUploadHandler callbackUpload;
  callBackUploadHandler callbackRemove;

  int maxImage;
  double width, height;
  PickerImageType type;
  PickerImageState state = new PickerImageState();

  PickerImage(
      {Key key,
      this.maxImage = 1,
      this.width,
      this.height,
      this.type = PickerImageType.grid})
      : super(key: key);

  void clear() {
    state.clear();
  }

  @override
  PickerImageState createState() => state;
}

class PickerImageState extends State<PickerImage> {
  List<File> filesPick = new List<File>();
  File _fileSelected;
  List<Future<dynamic>> _uploadParrallel = new List<Future<dynamic>>();

  @override
  void initState() {
    super.initState();
  }

  void clear() {
    this.filesPick = new List<File>();
    this._fileSelected = null;
    setState(() {});
  }

  Future<void> uploadImage(File file) async {
    widget.callbackUpload(file);
  }

  void uploadProcessing(BuildContext context) async {
    List<File> images = new List<File>();
    try {
      images = await ChristianPickerImage.pickImages(
          maxImages: widget.maxImage - this.filesPick.length);
    } catch (e) {} finally {
      Navigator.of(context).pop();

      setState(() {
        if (images.length > 0) {
          _fileSelected = images[0];
        }

        images.forEach((image) async {
          if (image != null) {
            this.filesPick.insert(0, image);

            var dir = await getTemporaryDirectory();
            var targetPath = dir.absolute.path + "/" + basename(image.path);

            var compressImage = await FlutterImageCompress.compressAndGetFile(
                image.absolute.path, targetPath,
                minHeight: 1280, minWidth: 1280, quality: 60, keepExif: false);

            image.deleteSync();
            _uploadParrallel.add(uploadImage(compressImage));
          }
        });
      });
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

  Widget photoImage(File f) {
    return Container(
        child: Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(top: 10, right: 5),
            child: ClipRRect(
                borderRadius: new BorderRadius.circular(4.0),
                child: Stack(
                  overflow: Overflow.clip,
                  children: <Widget>[
                    Image.file(
                      f,
                      fit: BoxFit.cover,
                      width: widget.width,
                      height: widget.height,
                    ),
                  ],
                )),),
        Positioned(
            top: -10,
            right: -10,
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/ic-close-bgred.svg',
                width: 30.0,
                height: 30.0,
              ),
              iconSize: 35,
              color: Colors.red[700],
              onPressed: () {
                setState(() {
                  this.filesPick.remove(f);
                  // Clear main picture
                  if (this.filesPick.length == 0) {
                    this._fileSelected = null;
                  }
                  widget.callbackRemove(f);
                });
              },
            ))
      ],
    ));
  }

  Widget listImage(BuildContext context) {
    var listImages = [];

    if (this.filesPick.length >= widget.maxImage) {
      listImages = this.filesPick.map((f) => this.photoImage(f)).toList();
    } else {
      listImages = [
            Container(
                padding: EdgeInsets.only(top: 10, right: 5),
                child: Stack(children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        this.pickImage(context);
                      },
                      child: DottedBorder(
                          borderType: BorderType.RRect,
                          dashPattern: [2, 2],
                          color: ThemeConstant.border_color,
                          radius: Radius.circular(5),
                          child: Container(
                              width: widget.width ?? double.infinity,
                              height: widget.height ?? double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    "assets/images/ic-add-picture.svg",
                                    width: 31,
                                    height: 32,
                                  ),
                                ],
                              ))))
                ],))
          ] +
          List<Container>.from(this.filesPick.length > 0
              ? this.filesPick.map((f) => this.photoImage(f)).toList()
              : []);
    }

    if (widget.type == PickerImageType.grid) {
      return Container(
          child: GridView.builder(
        itemCount: listImages.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: listImages[index],
          );
        },
      ));
    }

    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: listImages.length,
          itemBuilder: (c, index) {
            return listImages[index];
          }),
      height: widget.height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return listImage(context);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
