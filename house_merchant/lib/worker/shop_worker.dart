import 'dart:io';

import 'package:dio/dio.dart';
import 'package:house_merchant/constant/api_constant.dart';
import 'package:house_merchant/middle/api/oauth_api.dart';
import 'package:house_merchant/middle/model/image_meta_model.dart';
import 'package:house_merchant/middle/model/shop_model.dart';
import 'package:house_merchant/utils/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArgUpload {
  String? url;
  String? token;
  String? shopId;
  List<String>? imageId;
  SharedPreferences? storageShared;
  File? file;
  ArgUpload(
      {this.shopId,
      this.file,
      this.url,
      this.token,
      this.storageShared,
      this.imageId});
}

class ShopRequest extends OauthAPI {
  ShopRequest(baseUrl, storageShared) : super() {
    APIConstant.baseMerchantUrl = baseUrl;
    Storage.prefs = storageShared;
    OauthAPI.init();
  }

  Future<ImageModel> createImage(
      String? url, String? token, String? shopId, File? image) async {
    try {
      FormData formData = new FormData.fromMap({
        "image": MultipartFile.fromFileSync(image!.path, filename: "image.jpg")
      });

      final response = await this.post(
        "$url$shopId/",
        data: formData,
      );

      final rs = ImageModel.fromJson(response.data);
      return rs;
    } on DioError catch (e) {
      return throw e;
    }
  }

  Future<bool> removeImage(
      String? url, String? token, String? shopId, List<String>? ids) async {
    if (ids!.length == 0) {
      return true;
    }

    try {
      final response =
          await this.post("$url$shopId", data: ImageDeleteRequest(listId: ids));
      print(response);
      return true;
    } on DioError catch (e) {
      return throw e;
    }
  }
}

//Top level function
Future<ImageModel> uploadShopImageWorker(ArgUpload arg) async {
  //Update shop image
  final shopRequest = ShopRequest(arg.url, arg.storageShared);
  final result =
      await shopRequest.createImage(arg.url, arg.token, arg.shopId, arg.file);
  return result;
}

//Top level function
Future<bool> removeShopImageWorker(ArgUpload arg) async {
  //Update shop image
  final shopRequest = ShopRequest(arg.url, arg.storageShared);
  final result = await shopRequest.removeImage(
      arg.url, arg.token, arg.shopId, arg.imageId);
  return result;
}
