import 'package:house_merchant/middle/api/profile_api.dart';
import 'package:house_merchant/middle/model/profile_model.dart';

class ProfileRepository {
  final profileAPI = new ProfileAPI();

  Future<ProfileModel> getProfile() async {
    final rs = await profileAPI.getProfile();
    return rs;
  }
}
