import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:house_merchant/constant/api_constant.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_widget.dart';
import 'package:house_merchant/middle/api/oauth_api.dart';
import 'package:house_merchant/middle/api/shop_api.dart';
import 'package:house_merchant/middle/model/shop_model.dart';
import 'package:house_merchant/middle/repository/shop_repository.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
import 'package:house_merchant/screen/base/picker_image.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:house_merchant/utils/progresshub.dart';
import 'package:house_merchant/utils/sqflite.dart';
import 'package:house_merchant/utils/storage.dart';
import 'package:house_merchant/worker/upload_worker.dart';
import 'package:worker_manager/executor.dart';

class StoreEditImageScreen extends StatefulWidget {

  dynamic params;

  StoreEditImageScreen({this.params, Key key}) : super(key: key);

  @override
  StoreEditImageScreenState createState() => new StoreEditImageScreenState();
}

class StoreEditImageScreenState extends State<StoreEditImageScreen> {

  ProgressHUD progressToolkit = Progress.instanceCreate();
  Size _screenSize;
  BuildContext _context;
  double _padding;
  StreamController<ButtonSubmitEvent> saveButtonController = new StreamController<ButtonSubmitEvent>.broadcast();
  PickerImage imagePicker;
  int maxImage = 4;
  int initImageCount = 0;
  final StreamController<String> statusPickedText = new StreamController<String>();
  ShopRepository shopRepository = ShopRepository();
  var shopModel = ShopModel(images: []);
  List<File> filesCompressedPick = new List<File>();

  Future<dynamic> runTaskUpload(File f) async {
    var completer = new Completer();

    String currentShop = await Sqflite.currentShop();

    final task = Task(function: uploadShopImageWorker, arg: ArgUpload(
        url: APIConstant.baseMerchantUrlShopImageCreate,
        token: OauthAPI.token,
        shopId: currentShop,
        storageShared: Storage.prefs,
        file: f)
    );

    Executor().addTask(task: task,).listen((result) async {
      completer.complete(result);
    }).onError((error) {
      completer.completeError(error);
    });

    return completer.future;
  }

  Future sendData() async {
    //Fetch all picked lasted
    Future.wait(this.filesCompressedPick.map((file) {
      return runTaskUpload(file);
    }).toList()).then((List responses) async {
      print('Upload successful');
    });
  }

  @override
  void initState() {
    ShopModel shopModel = widget.params['shop_model'];

    print("EDIT IMAGE INIT STATE");

    final initImages = shopModel.images.map((f) => FilePick(url: f.image),).toList();
    initImageCount = initImages.length;

    imagePicker = new PickerImage(width: 160, height: 140, type: PickerImageType.grid,
        maxImage: maxImage, imagesInit: initImages );

    imagePicker.callbackUpload = (FilePick f) async {
      statusPickedText.add(imagePicker.state.filesPick.length.toString());
      this.filesCompressedPick.add(f.file);
      this.checkValidation();
    };

    imagePicker.callbackRemove = (FilePick f) async {
      statusPickedText.add(imagePicker.state.filesPick.length.toString());
      this.filesCompressedPick.remove(f.file);
      this.checkValidation();
    };

    super.initState();
  }

  Widget titleInSection(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        StreamBuilder(
          stream: statusPickedText.stream,
            initialData: title,
            builder: (BuildContext context, AsyncSnapshot snapshot)
          {
            return Text(
              'Hình ảnh (${snapshot.data}/${this.maxImage} tấm)',
              style: ThemeConstant.titleLargeStyle(Colors.black),
            );
        }),
        SizedBox(height: 5),
        Text(
          subtitle,
          style: ThemeConstant.subtitleStyle(ThemeConstant.grey_color),
        )
      ],
    );
  }

  Widget buildBody() {
    return Container(
        decoration: BoxDecoration(color: ThemeConstant.white_color),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            titleInSection(initImageCount.toString(),
                'Hình ảnh đẹp sẽ để lại một ấn tượng tốt cho khách hàng'),
            SizedBox(height: 15),
            Expanded(
              child: imagePicker,
            )
          ],
        ),
      );
  }

  bool checkValidation() {
    var isActive = false;
    if (imagePicker.state.filesPick.length > 0) {
      isActive = true;
    }
    saveButtonController.sink.add(ButtonSubmitEvent(isActive));
    return isActive;
  }

  void clearForm() {
    this.imagePicker.clear();
  }

  @override
  Widget build(BuildContext context) {
    this._screenSize = MediaQuery.of(context).size;
    this._context = context;
    this._padding = this._screenSize.width * 5 / 100;

    final buttonBottom = ButtonWidget(
      controller: saveButtonController,
      defaultHintText:
      LocalizationsUtil.of(_context).translate('Lưu thay đổi'),
      callback: () async {
        ShopModel shopModel = widget.params['shop_model'];

        try {
          progressToolkit.state.show();
          await sendData();
          //Clear all
          this.clearForm();
          Navigator.of(context).pop();
          Fluttertoast.showToast(
            msg: 'Cập nhật hình ảnh thành công',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 5,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 14.0
          );
        } catch (e) {
          Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 5,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 14.0
          );
        } finally {
          progressToolkit.state.dismiss();
        }

      });

    print("IMAGE BUILD BODY");

    // TODO: implement build
    return BaseScaffoldNormal(
        title: 'Chỉnh sửa cửa hàng',
        child: SafeArea(
          child: Stack(children: <Widget>[
            Container(padding: EdgeInsets.all(this._padding), child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: buildBody()
                ),
                buttonBottom
              ],
            ), color: ThemeConstant.background_white_color,),
            progressToolkit
        ])
    ));
  }
}