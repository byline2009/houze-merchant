import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:house_merchant/constant/theme_constant.dart';

class ImageWidget extends StatelessWidget {
  Widget child;
  String imgUrl;
  double width = 50;
  double height = 50;

  ImageWidget({@required this.imgUrl, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
          borderRadius: new BorderRadius.all(Radius.circular(10.0)),
          child: Stack(overflow: Overflow.clip, children: <Widget>[
            CachedNetworkImage(
              imageUrl: this.imgUrl,
              placeholder: (context, url) =>
                  Center(child: CupertinoActivityIndicator()),
              errorWidget: (context, url, error) =>
                  Center(child: Icon(Icons.error)),
              width: this.width,
              height: this.height,
              fit: BoxFit.cover,
            ),
          ])),
      width: this.width,
      height: this.height,
      color: ThemeConstant.background_grey_color,
    );
  }
}
