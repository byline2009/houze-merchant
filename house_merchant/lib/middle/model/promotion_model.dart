class PromotionModel {
  String promotionTitle;
  int status;
  int promotionCurrent;
  int promotionMax;
  String expireStart;
  String expireEnd;
  String imgUrl;

  PromotionModel(
      {this.promotionTitle,
      this.status,
      this.promotionCurrent,
      this.promotionMax,
      this.expireStart,
      this.expireEnd,
      this.imgUrl});

  PromotionModel.fromJson(Map<String, dynamic> json) {
    promotionTitle = json['promotion_title'];
    status = json['status'];
    promotionCurrent = json['promotion_current'];
    promotionMax = json['promotion_max'];
    expireStart = json['expire_start'];
    expireEnd = json['expire_end'];
    imgUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['promotion_title'] = this.promotionTitle;
    data['status'] = this.status;
    data['promotion_current'] = this.promotionCurrent;
    data['promotion_max'] = this.promotionMax;
    data['expire_start'] = this.expireStart;
    data['expire_end'] = this.expireEnd;
    data['image_url'] = this.imgUrl;
    return data;
  }
}