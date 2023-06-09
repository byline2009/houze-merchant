import 'package:dio/dio.dart';
import 'package:house_merchant/constant/api_constant.dart';
import 'package:house_merchant/middle/api/base_api.dart';
import 'package:house_merchant/middle/model/token_model.dart';

class LoginAPI extends BaseApi {
  Dio? dio;

  LoginAPI() : super(APIConstant.baseMerchantUrlLogin!);

  Future<TokenModel> login({username: String, password: String}) async {
    try {
      final response = await dio!.post(
        this.baseUrl,
        data: {"username": username, "password": password},
      );
      return TokenModel.fromJson(response.data);
    } on DioError catch (e) {
      print(e.message.toString().toUpperCase());
      if (e.response != null && e.response!.statusCode != 200)
        throw ("Sai tài khoản hoặc mật khẩu");
      else {
        throw ("Lỗi kết nối máy chủ");
      }
    }
  }
}
