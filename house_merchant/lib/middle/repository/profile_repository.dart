import 'package:house_merchant/middle/api/profile_api.dart';
import 'package:house_merchant/middle/model/profile_model.dart';

class ProfileRepository {
  final profileAPI = new ProfileAPI();

  Future<ProfileModel> getProfile() async {
    final rs = await profileAPI.getProfile();
    return rs;
  }

  Future<String> changePassword(String old_pass, String new_pass) async {
    try {
      final rs = await profileAPI.changePassword(old_pass, new_pass);
      return rs;
    } catch (e) {
      return throw(e.toString());
    }
  }
}
