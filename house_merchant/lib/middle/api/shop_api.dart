
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:house_merchant/constant/api_constant.dart';
import 'package:house_merchant/middle/api/oauth_api.dart';
import 'package:house_merchant/middle/model/base_model.dart';
import 'package:house_merchant/middle/model/image_meta_model.dart';
import 'package:house_merchant/middle/model/shop_model.dart';

class ShopAPI extends OauthAPI {

  ShopAPI() : super();

  Future<List<ShopModel>> getShops({int page=0}) async {

    final response = await this.get(
      APIConstant.baseMerchantUrlShop,
      queryParameters: {}
    );

    return (PageModel.map(response.data).results as List).map((i) {
      return ShopModel.fromJson(i);
    }).toList();
  }

  Future<ShopModel> getShop(String id) async {

    final response = await this.get(
      "${APIConstant.baseMerchantUrlShop}${id}/",
      queryParameters: {}
    );

    return ShopModel.fromJson(response.data);
  }

  Future<ShopModel> updateImages(String id, List<ImageModel> images) async {

    final response = await this.patch(
        "${APIConstant.baseMerchantUrlShop}${id}/",
        data: ShopModel(
          images: images
        )
    );

    return ShopModel.fromJson(response.data);
  }

  Future<dynamic> createImage(String shopId, File image) async {
    try {
      FormData formData =
      new FormData.from({"image": new UploadFileInfo(image, "image.jpg")});

      final String url = APIConstant.baseMerchantUrlShopImageCreate;

      final response = await this.post(
        "${url}${shopId}/",
        data: formData,
      );

      final rs = ImageModel.fromJson(response.data);
      return rs;
    } on DioError catch (e) {
      print(e);
      return throw e;
    }
  }

}