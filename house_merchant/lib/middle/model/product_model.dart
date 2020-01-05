class ProductModel {
  String id;
  String title;
  String desc;
  double price;
  int status;
  String imgUrl;

  ProductModel({this.id, this.title, this.desc, this.price, this.status, this.imgUrl});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    price = json['price'];
    status = json['status'];
    imgUrl = json['img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['price'] = this.price;
    data['status'] = this.status;
    data['img_url'] = this.imgUrl;
    return data;
  }
}