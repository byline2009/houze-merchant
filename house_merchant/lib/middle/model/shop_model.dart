class ShopModel {
  String id;
  String name;
  String description;
  int status;
  double lat;
  double long;

  ShopModel(
    {this.id,
    this.name,
    this.description,
    this.status,
    this.lat,
    this.long});

  ShopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}