import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/middle/model/shop_model.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
import 'package:house_merchant/screen/base/boxes_container.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:house_merchant/utils/progresshub.dart';

typedef void CallBackHandler(ShopModel shopModel);

class ShopUpdateImagesScreen extends StatefulWidget {

  ShopUpdateImagesScreen({Key key}) : super(key: key);

  @override
  ShopUpdateImagesScreenState createState() => new ShopUpdateImagesScreenState();
}

class ShopUpdateImagesScreenState extends State<ShopUpdateImagesScreen> {

  ProgressHUD progressToolkit = Progress.instanceCreate();
  Size _screenSize;
  BuildContext _context;
  double _padding;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    this._screenSize = MediaQuery.of(context).size;
    this._context = context;
    this._padding = this._screenSize.width * 5 / 100;

    return BaseScaffoldNormal(
      title: 'Chỉnh sửa cửa hàng',
      child: Column(
        children: <Widget>[
          BoxesContainer(child: Center(),),
          BoxesContainer(
            title: 'Hình ảnh (3/4 tấm)',
            child: Column(
              children: <Widget>[
                SizedBox(height: 5),
                Text(LocalizationsUtil.of(context).translate('Hình ảnh đẹp sẽ để lại một ấn tượng tốt cho khách hàng'),
                style: TextStyle(
                    color: ThemeConstant.grey_color,
                    fontFamily: ThemeConstant.form_font_family_display,
                    fontSize: ThemeConstant.form_font_smaller,
                    fontWeight: ThemeConstant.appbar_text_weight)),
              ],
            ),
            padding: EdgeInsets.all(this._padding),
            noLine: true,
          )
        ],
      )
    );

  }

  @override
  void dispose() {
    super.dispose();
  }
}