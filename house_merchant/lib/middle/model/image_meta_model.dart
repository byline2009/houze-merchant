import 'package:equatable/equatable.dart';

class ImageMetaModel extends Equatable {
  final String id;
  final String url;

  ImageMetaModel({
    this.id,
    this.url,
  });

  factory ImageMetaModel.fromJson(Map<String, dynamic> json) => json != null
      ? new ImageMetaModel(
          id: json['id'],
          url: json['url'] ?? json['image'],
        )
      : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
      };
}

class ImageModel {
  String id;
  String image;
  String imageThumb;

  ImageModel({
    this.id,
    this.image,
    this.imageThumb,
  });

  ImageModel.map(dynamic obj) {
    this.id = obj['id'];
    this.image = obj['image'];
    this.imageThumb = obj['image_thumb'];
  }

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
        id: json['id'], image: json['image'], imageThumb: json['image_thumb']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'image_thumb': imageThumb,
      };
}

class ImageUploadModel {
  String id;

  ImageUploadModel({this.id});

  ImageUploadModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
