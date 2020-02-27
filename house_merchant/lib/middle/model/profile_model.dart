class ProfileModel {
  String id;
  String fullname;
  String username;
  int phoneNumber;
  int intlCode;
  String gender;
  String birthday;
  String identityCard;
  String passport;
  String avatar;

  ProfileModel(
      {this.id,
      this.fullname,
      this.username,
      this.phoneNumber,
      this.intlCode,
      this.gender,
      this.birthday,
      this.identityCard,
      this.passport,
      this.avatar});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    username = json['username'];
    phoneNumber = json['phone_number'];
    intlCode = json['intl_code'];
    gender = json['gender'];
    birthday = json['birthday'];
    identityCard = json['identity_card'];
    passport = json['passport'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['username'] = this.username;
    data['phone_number'] = this.phoneNumber;
    data['intl_code'] = this.intlCode;
    data['gender'] = this.gender;
    data['birthday'] = this.birthday;
    data['identity_card'] = this.identityCard;
    data['passport'] = this.passport;
    data['avatar'] = this.avatar;
    return data;
  }
}
