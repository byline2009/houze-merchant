import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/tags_widget.dart';
import 'package:house_merchant/screen/base/base_scaffold.dart';
import 'package:house_merchant/screen/base/boxes_container.dart';
import 'package:house_merchant/screen/base/image_widget.dart';
import 'package:house_merchant/utils/localizations_util.dart';

class StoreScreen extends StatefulWidget {
  StoreScreen({Key key}) : super(key: key);

  @override
  StoreScreenState createState() => StoreScreenState();
}

class StoreScreenState extends State<StoreScreen> {

  Size _screenSize;
  double _padding;

  Widget introStore() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 5),
        Text(LocalizationsUtil.of(context).translate('Tấm hình đầu tiên sẽ là hình nền của giao diện cửa hàng'), style: TextStyle(
          color: ThemeConstant.grey_color,
          fontFamily: ThemeConstant.form_font_family_display,
          fontSize: ThemeConstant.form_font_smaller,
          fontWeight: ThemeConstant.appbar_text_weight)),
        SizedBox(height: 15),
        Container(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              ImageWidget(width: 120, height: 120, imgUrl: "https://anhdaostorage.blob.core.windows.net/qa-media/facility/20191114014531987127/bbq-pmh.jpg",),
              SizedBox(width: 15),
              ImageWidget(width: 120, height: 120, imgUrl: "https://anhdaostorage.blob.core.windows.net/qa-media/facility/20191114014630397045/meeting-room.jpg",),
              SizedBox(width: 15),
              ImageWidget(width: 120, height: 120, imgUrl: "",),
            ],
          ),
        )
      ],
    );
  }

  Widget descriptionStore() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 5),
        Text(LocalizationsUtil.of(context).translate('Lời văn thật hay để cửa hàng bạn thu hút cư dân nhé!'), style: TextStyle(
          color: ThemeConstant.grey_color,
          fontFamily: ThemeConstant.form_font_family_display,
          fontSize: ThemeConstant.form_font_smaller,
          fontWeight: ThemeConstant.appbar_text_weight)),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.only(top: 15, bottom: 19, left: 10, right: 10),
          decoration: BoxDecoration(
            color: ThemeConstant.background_grey_color,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Text('This is a description - Body text. Lorem ipsum do sit amet, consectetur adipiscing elito veliada.\nMy store is everything you want!'))
      ],
    );
  }

  Widget timeStore() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        SizedBox(height: 15),
        Container(child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            TagsWidget(text: 'T2'),
            SizedBox(width: 10),
            TagsWidget(text: 'T3'),
            SizedBox(width: 10),
            TagsWidget(text: 'T4'),
            SizedBox(width: 10),
            TagsWidget(text: 'T5'),
            SizedBox(width: 10),
            TagsWidget(text: 'T6'),
            SizedBox(width: 10),
            TagsWidget(text: 'T7', isDisable: true,),
            SizedBox(width: 10),
            TagsWidget(text: 'CN', isDisable: true),
          ],
        ), height: 40),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              child: Container(
              padding: EdgeInsets.only(top: 15, bottom: 19, left: 10, right: 10),
              decoration: BoxDecoration(
                color: ThemeConstant.background_grey_color,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Center(child: Column(
                  children: <Widget>[
                    Text('Giờ mở cửa', style: TextStyle(
                      color: ThemeConstant.black_color,
                      fontFamily: ThemeConstant.form_font_family_display,
                      fontSize: ThemeConstant.form_font_small,
                      fontWeight: FontWeight.w600)),
                    SizedBox(height: 5),
                    Text('08:00', style: TextStyle(
                      color: ThemeConstant.black_color,
                      fontFamily: ThemeConstant.form_font_family_display,
                      fontSize: ThemeConstant.sub_header_size,
                      fontWeight: ThemeConstant.appbar_text_weight_bold))
                  ],
                ))
              )
            ),

            SizedBox(width: 15),

            Flexible(
              fit: FlexFit.tight,
              child: Container(
              padding: EdgeInsets.only(top: 15, bottom: 19, left: 10, right: 10),
              decoration: BoxDecoration(
                color: ThemeConstant.background_grey_color,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Center(child: Column(
                  children: <Widget>[
                    Text('Giờ đóng cửa', style: TextStyle(
                      color: ThemeConstant.black_color,
                      fontFamily: ThemeConstant.form_font_family_display,
                      fontSize: ThemeConstant.form_font_small,
                      fontWeight: FontWeight.w600)),
                    SizedBox(height: 5),
                    Text('08:00', style: TextStyle(
                      color: ThemeConstant.black_color,
                      fontFamily: ThemeConstant.form_font_family_display,
                      fontSize: ThemeConstant.sub_header_size,
                      fontWeight: ThemeConstant.appbar_text_weight_bold))
                  ],
                ))
              )
            ),
        ],)
      ],
    );
  }

  Widget editButton() {
    return Row(
      children: <Widget>[
        Icon(Icons.create, color: ThemeConstant.primary_color, size: 16,),
        SizedBox(width: 5),
        Text(LocalizationsUtil.of(context).translate('Chỉnh sửa'),
        style: TextStyle(
          color: ThemeConstant.primary_color,
          fontFamily: ThemeConstant.form_font_family_display,
          fontSize: ThemeConstant.form_font_smaller,
          fontWeight: FontWeight.w600))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    this._screenSize = MediaQuery.of(context).size;
    this._padding = this._screenSize.width * 5 / 100;

    return BaseScaffold(
      title: 'Cửa hàng',
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: BoxesContainer(child: Padding(padding: EdgeInsets.all(this._padding), child:
              Text(
                LocalizationsUtil.of(context).translate('Lưu ý, các tuỳ chỉnh thông số ở dưới sẽ được hiển thị trên ứng dụng của cư dân'),
                style: TextStyle(
                  color: ThemeConstant.grey_color,
                  fontFamily: ThemeConstant.form_font_family_display,
                  fontSize: ThemeConstant.label_font_size,
                  fontWeight: ThemeConstant.appbar_text_weight)
              )
            ))
          ),

          SliverToBoxAdapter(
            child: BoxesContainer(title: 'Hình ảnh', child: introStore(), action: InkWell(onTap: () async {}, child: editButton()), padding: EdgeInsets.all(this._padding),)
          ),

          SliverToBoxAdapter(
            child: BoxesContainer(title: 'Mô tả', child: descriptionStore(), action: InkWell(onTap: () async {}, child: editButton()), padding: EdgeInsets.all(this._padding),)
          ),

          SliverToBoxAdapter(
            child: BoxesContainer(title: 'Thời gian', child: timeStore(), action: InkWell(onTap: () async {}, child: editButton()), padding: EdgeInsets.all(this._padding),)
          ),

        ]
      )
    );
  }
}