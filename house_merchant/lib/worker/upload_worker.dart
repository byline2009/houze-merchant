import 'dart:io';

import 'package:dio/dio.dart';
import 'package:house_merchant/constant/api_constant.dart';
import 'package:house_merchant/constant/common_constant.dart';
import 'package:house_merchant/middle/api/base_api.dart';
import 'package:house_merchant/middle/api/oauth_api.dart';
import 'package:house_merchant/middle/model/image_meta_model.dart';
import 'package:house_merchant/utils/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArgUpload {
  String url;
  String token;
  String shopId;
  SharedPreferences storageShared;
  File file;
  ArgUpload({this.shopId, this.file, this.url, this.token, this.storageShared});
}

class ShopRequest extends OauthAPI {

  ShopRequest(baseUrl, storageShared) : super() {
    APIConstant.baseMerchantUrl = baseUrl;
    Storage.prefs = storageShared;
    OauthAPI.init();
  }

  Future<dynamic> createImage(String url, String token, String shopId, File image) async {
    try {
      FormData formData =
      new FormData.from({"image": new UploadFileInfo(image, "image.jpg")});

      final response = await this.post(
        "${url}${shopId}/",
        data: formData,
      );

      final rs = ImageModel.fromJson(response.data);
      return rs;
    } on DioError catch (e) {
      return throw e;
    }
  }
}

//Top level function
Future<bool> uploadShopImageWorker(ArgUpload arg) async {
  //Update shop image
  final shopReuest = ShopRequest(arg.url, arg.storageShared);
  final result = await shopReuest.createImage(arg.url, arg.token, arg.shopId, arg.file);
  return result!=null;
}