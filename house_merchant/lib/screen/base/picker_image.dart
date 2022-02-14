// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:christian_picker_image/christian_picker_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

typedef void CallBackUploadHandler(FilePick file);

enum PickerImageType { grid, list }

class FilePick {
  String id;
  String url;
  String urlThumb;
  File file;

  FilePick({this.id, this.file, this.url, this.urlThumb});
}

class PickerImage extends StatefulWidget {
  CallBackUploadHandler callbackUpload;
  CallBackUploadHandler callbackRemove;

  int maxImage;
  double width, height;
  PickerImageType type;
  PickerImageState state = PickerImageState();
  List<FilePick> imagesInit = <FilePick>[];

  PickerImage(
      {Key key,
      this.maxImage = 1,
      this.width,
      this.height,
      this.imagesInit,
      this.type = PickerImageType.grid})
      : super(key: key) {
    if (this.imagesInit == null) {
      this.imagesInit = <FilePick>[];
    }
  }

  void clear() {
    state.clear();
  }

  @override
  PickerImageState createState() => state;
}

class PickerImageState extends State<PickerImage> {
  List<FilePick> filesPick = <FilePick>[];
  //Final pick
  List<FilePick> validationFilesPick = <FilePick>[];
  List<Future<dynamic>> _uploadParallel = <Future<dynamic>>[];

  @override
  void initState() {
    super.initState();
    this.fillWithInitImages();
  }

  void clear() {
    this.filesPick = <FilePick>[];
    setState(() {});
  }

  void fillWithInitImages() {
    this.filesPick = this.filesPick + widget.imagesInit;
    this.validationFilesPick = this.validationFilesPick + widget.imagesInit;
  }

  Future<void> uploadImage(FilePick file) async {
    widget.callbackUpload(file);
  }

  void uploadProcessing(BuildContext context) async {
    List<File> images = <File>[];
    try {
      images = await ChristianPickerImage.pickImages(
          maxImages: widget.maxImage - this.filesPick.length);
      print(images);
    } catch (e) {
      print(e.toString());
    } finally {
      Navigator.of(context).pop();

      setState(() {
        if (images.length > 0) {}

        images.forEach((image) async {
          if (image != null) {
            this.filesPick.insert(0, FilePick(file: image));

            var dir = await getTemporaryDirectory();
            var targetPath = dir.absolute.path + "/" + basename(image.path);

            var compressImage = await FlutterImageCompress.compressAndGetFile(
                image.absolute.path, targetPath,
                minHeight: 1280, minWidth: 1280, quality: 60, keepExif: false);

            if (Platform.isIOS) {
              image.deleteSync();
            }

            _uploadParallel.add(uploadImage(FilePick(file: compressImage)));
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

  Widget photoImage(FilePick f) {
    print(f.urlThumb);
    return Container(
        child: Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10, right: 5),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  f.file != null
                      ? Image.file(
                          f.file,
                          fit: BoxFit.cover,
                          width: widget.width,
                          height: widget.height,
                        )
                      : Container(
                          child: CachedNetworkImage(
                            imageUrl: f.url,
                            placeholder: (context, url) =>
                                Center(child: CupertinoActivityIndicator()),
                            errorWidget: (context, url, error) =>
                                Center(child: Icon(Icons.error)),
                            width: widget.width,
                            height: widget.height,
                            fit: BoxFit.cover,
                          ),
                          width: widget.width,
                          height: widget.height,
                        )
                ],
              )),
        ),

//                CachedNetworkImage(
//                  imageUrl: f.url + "?session=" + DateTime.now().toIso8601String(),
//                  placeholder: (context, url) => Center(child: CupertinoActivityIndicator()),
//                  errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
//                  width: widget.width,
//                  height: widget.height,
//                  fit: BoxFit.cover,
//                ),
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
                  this.validationFilesPick.remove(f);
                  // Clear main picture
                  if (this.filesPick.length == 0) {}
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
                child: Stack(
                  children: <Widget>[
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
                  ],
                ))
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
        ),
      );
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

  List<Future<dynamic>> getUploadParallel() {
    return this._uploadParallel;
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
