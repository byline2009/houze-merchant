import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/textfield_widget.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
import 'package:house_merchant/screen/base/boxes_container.dart';
import 'package:house_merchant/utils/localizations_util.dart';

class PromotionCreateScreen extends StatefulWidget {

  PromotionCreateScreen({Key key}) : super(key: key);

  @override
  PromotionCreateScreenState createState() => new PromotionCreateScreenState();
}

class PromotionCreateScreenState extends State<PromotionCreateScreen> {

  Size _screenSize;
  BuildContext _context;
  double _padding;

  //Form controller
  final ftitle = TextFieldWidgetController();

  @override
  void initState() {
    super.initState();
  }

  Widget formCreate() {

    final padding = this._screenSize.width * 5 / 100;
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Text(LocalizationsUtil.of(context).translate("* Tiêu đề ưu đãi"),
            style: TextStyle(
              fontFamily: 'SFProText',
              fontSize: 14,
              color: Colors.black,
            )
          ),

          TextFieldWidget(controller: ftitle, defaultHintText: 'Vd: Mua 1 tặng 1 tất cả chi nhánh', callback: (String value) {

          })
        ],
      )
    );
    
  }

  @override
  Widget build(BuildContext context) {
    
    this._screenSize = MediaQuery.of(context).size;
    this._context = context;
    this._padding = this._screenSize.width * 5 / 100;

    return BaseScaffoldNormal(
      title: 'Tạo ưu đãi',
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [

          SliverToBoxAdapter(
            child: BoxesContainer(child: Center(),),
          ),

          SliverToBoxAdapter(
            child: BoxesContainer(title: 'Hình ảnh', child: Text('hello world'), padding: EdgeInsets.all(this._padding),)
          ),

          SliverToBoxAdapter(
            child: BoxesContainer(title: 'Thông tin', child: this.formCreate(), padding: EdgeInsets.all(this._padding),)
          ),
        ]
      ),
    );

  }

  @override
  void dispose() {
    super.dispose();
  }
}