import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/utils/localizations_util.dart';

class PromotionCreateScreen extends StatefulWidget {

  PromotionCreateScreen({Key key}) : super(key: key);

  @override
  PromotionCreateScreenState createState() => new PromotionCreateScreenState();
}

class PromotionCreateScreenState extends State<PromotionCreateScreen> {

  Size _screenSize;
  BuildContext _context;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    this._screenSize = MediaQuery.of(context).size;
    this._context = context;

    return new Scaffold(
      appBar: AppBar(
        title: Text(LocalizationsUtil.of(context).translate('Gửi yêu cầu'),
          style: TextStyle(
          fontSize: ThemeConstant.appbar_font_title,
          color: ThemeConstant.appbar_text_color,
          fontWeight: ThemeConstant.appbar_text_weight)),
      backgroundColor: ThemeConstant.appbar_background_color,
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: ThemeConstant.appbar_icon_color,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      )),
      body: Text('create promotion')
    );

  }

  @override
  void dispose() {
    super.dispose();
  }
}