import 'package:dio/dio.dart';
import 'package:house_merchant/constant/api_constant.dart';
import 'package:house_merchant/middle/api/oauth_api.dart';
import 'package:house_merchant/middle/model/profile_model.dart';

class ProfileAPI extends OauthAPI {
  ProfileAPI() : super();

  Future<ProfileModel> getProfile() async {
    final response = await this.get(
      APIConstant.baseMerchantUrlProfile,
    );

    return ProfileModel.fromJson(response.data);
  }

  Future<String> changePassword(String oldPass, String newPass) async {
    try {
      final response = await this.put(
        APIConstant.baseMerchantUrlChangepass,
        data: {"old_password": oldPass, "new_password": newPass},
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response.statusCode != 200) throw ("Mật khẩu cũ không hợp lệ");
      return 'Mật khẩu cũ không hợp lệ';
    }
  }
}
