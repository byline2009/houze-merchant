import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/button_create_widget.dart';
import 'package:house_merchant/custom/group_radio_tags_widget.dart';
import 'package:house_merchant/middle/model/category_model.dart';
import 'package:house_merchant/middle/model/product_model.dart';
import 'package:house_merchant/screen/base/base_scaffold.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key key}) : super(key: key);

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {

  Size _screenSize;
  double _padding;
  final formatter = new NumberFormat("#,###");

  List<CategoryModel> categories = [
    CategoryModel(
      id: "24568638763824686845366",
      categoryName: "Coffee Flavour",
    ),
    CategoryModel(
      id: "24568638763824686845367",
      categoryName: "TEA",
    ),
  ];

  List<ProductModel> products = [
    ProductModel(
      id: "24568638763824686845366",
      title: "Trà sữa Socola (M)",
      desc: "Trà ô long kết hợp Socola...",
      price: 40000,
      status: 1,
      imgUrl: "https://anhdaostorage.blob.core.windows.net/qa-media/facility/20191114014531987127/bbq-pmh.jpg"
    ),
    ProductModel(
      id: "24568638763824686845366",
      title: "Trà hạt phỉ Macchiato (L)",
      desc: "Món này tuỳ vào bên bán hạt",
      price: 55000,
      status: 1,
      imgUrl: "https://anhdaostorage.blob.core.windows.net/qa-media/facility/20191114014630397045/meeting-room.jpg"
    ),
    ProductModel(
      id: "24568638763824686845366",
      title: "Trà sữa Socola (M)",
      desc: "Trà ô long kết hợp Socola...",
      price: 40000,
      status: 0,
      imgUrl: ""
    ),
    ProductModel(
      id: "24568638763824686845366",
      title: "Cà phê sữa đá Thức tỉnh ngày mới!",
      desc: "",
      price: 40000,
      status: 1,
      imgUrl: ""
    ),
    ProductModel(
      id: "24568638763824686845366",
      title: "Cappuchino nóng / đá",
      desc: "",
      price: 35000,
      status: 0,
      imgUrl: ""
    ),
    ProductModel(
      id: "24568638763824686845366",
      title: "Trà sữa Socola (M)",
      desc: "Trà ô long kết hợp Socola...",
      price: 40000,
      status: 1,
      imgUrl: ""
    ),
  ];

  Widget tags() {
    return GroupRadioTagsWidget(tags: <GroupRadioTags>[
        GroupRadioTags(id: -1, title: "Tất cả",),
        GroupRadioTags(id: 0, title: "Đang bán"),
        GroupRadioTags(id: 1, title: "Tạm ngưng"),
      ], callback: (dynamic index) {
      },
      defaultIndex: 0,
    );
  }

  Widget statusProduct(int status) {
    switch (status) {
      case 0:
        return Text('TẠM NGƯNG', 
          style: TextStyle(
            color: ThemeConstant.unselected_color,
            fontFamily: ThemeConstant.form_font_family_display,
            fontSize: ThemeConstant.form_font_smaller,
            fontWeight: ThemeConstant.appbar_text_weight_bold)); 
      case 1:
        return Text('ĐANG BÁN',
          style: TextStyle(
            color: ThemeConstant.status_approved,
            fontFamily: ThemeConstant.form_font_family_display,
            fontSize: ThemeConstant.form_font_smaller,
            fontWeight: ThemeConstant.appbar_text_weight_bold));
    }
    return Center();
  }

  Widget menuItem(ProductModel product) {
    return GestureDetector(
      onTap: () async {
        print('ok testing');
      },
      child: Container(child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Container(child: ClipRRect(
            borderRadius: new BorderRadius.all(Radius.circular(4.0)),
            child: Stack(
              overflow: Overflow.clip,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: product.imgUrl,
                  placeholder: (context, url) => Center(child: CupertinoActivityIndicator()),
                  errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ]
          )), width: 60, height: 60, color: ThemeConstant.background_grey_color),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(product.title,
                  style: TextStyle(
                    color: ThemeConstant.normal_color,
                    fontFamily: ThemeConstant.form_font_family_display,
                    fontSize: ThemeConstant.label_font_size,
                    fontWeight: ThemeConstant.appbar_text_weight)),
                Text(product.desc, style: TextStyle(
                  color: Color(0xff838383),
                  fontFamily: ThemeConstant.form_font_family_display,
                  fontSize: ThemeConstant.form_font_small,
                  fontWeight: ThemeConstant.appbar_text_weight)),
                SizedBox(height: 3),
                this.statusProduct(product.status),
              ],
            ),
          ),

          Text("${formatter.format(product.price)} đ", style: TextStyle(
            color: ThemeConstant.black_color,
            fontFamily: ThemeConstant.form_font_family_display,
            fontSize: ThemeConstant.form_font_small,
            fontWeight: ThemeConstant.appbar_text_weight))
        ],
      ), color: ThemeConstant.background_white_color)
    );
  }

  @override
  Widget build(BuildContext context) {

    this._screenSize = MediaQuery.of(context).size;
    this._padding = this._screenSize.width * 5 / 100;

    return BaseScaffold(
      title: 'Menu',
      trailing: Padding(child: ButtonCreateWidget(title: "Tạo mới", callback: () {
        print('tạo mới');
      }, icon: Icon(
        Icons.add,
        color: Colors.white,
        size: 25.0,
      ),),
      padding: EdgeInsets.only(right: this._padding) ),
      child: Column(
        children: <Widget>[
          this.tags(),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (c, index) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        color: ThemeConstant.background_grey_color,
                        child: Text(categories[index].categoryName, 
                        style: TextStyle(
                          color: ThemeConstant.unselected_color,
                          fontFamily: ThemeConstant.form_font_family,
                          fontSize: ThemeConstant.sub_header_size,
                          fontWeight: ThemeConstant.appbar_text_weight)
                        ),
                        padding: EdgeInsets.only(left: this._padding, right: this._padding, top: 20, bottom: 5),
                      ),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: products.length,
                        separatorBuilder: (BuildContext context, int index) => Divider(height: 10),
                        itemBuilder: (c, index) {
                          return Padding(padding: EdgeInsets.only(top: 10, bottom: 10, left: this._padding, right: this._padding), child: menuItem(products[index]));
                        })
                    ],
                  )
                );
              },
              itemCount: categories.length,
            )
          )
        ],
      )
    );
  }
}