import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_merchant/constant/theme_constant.dart';

class ComingSoonWidget extends StatefulWidget {
  var assetImgPath;
  var description = '';

  ComingSoonWidget({this.assetImgPath, this.description, Key key})
      : super(key: key);

  @override
  ComingSoonWidgetState createState() => new ComingSoonWidgetState();
}

class ComingSoonWidgetState extends State<ComingSoonWidget> {
  var image = '';
  var desc = '';

  @override
  Widget build(BuildContext context) {
    this.image = widget.assetImgPath ?? 'assets/images/ic-comming-soon.svg';
    this.desc = widget.description ??
        'Tính năng đang hoàn thiện\nSẽ ra mắt trong thời gian tới';

    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(top: 140.0),
      child: Column(
        children: <Widget>[
          SvgPicture.asset(
            this.image,
            width: 100.0,
            height: 100.0,
          ),
          SizedBox(height: 20.0),
          Text(
            this.desc,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16.0,
                color: ThemeConstant.grey_color,
                letterSpacing: 0.26,
                fontWeight: ThemeConstant.appbar_text_weight),
          )
        ],
      ),
    );
  }
}
