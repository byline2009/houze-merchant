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
}
