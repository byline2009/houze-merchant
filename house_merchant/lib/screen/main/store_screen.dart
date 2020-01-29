import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/custom/flutter_skeleton/flutter_skeleton.dart';
import 'package:house_merchant/custom/tags_widget.dart';
import 'package:house_merchant/middle/bloc/shop/index.dart';
import 'package:house_merchant/middle/model/image_meta_model.dart';
import 'package:house_merchant/middle/model/shop_model.dart';
import 'package:house_merchant/router.dart';
import 'package:house_merchant/screen/base/base_scaffold.dart';
import 'package:house_merchant/screen/base/boxes_container.dart';
import 'package:house_merchant/screen/base/image_widget.dart';
import 'package:house_merchant/screen/base/picker_image.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:house_merchant/utils/sqflite.dart';

class StoreScreen extends StatefulWidget {
  StoreScreen({Key key}) : super(key: key);

  @override
  StoreScreenState createState() => StoreScreenState();
}

class StoreScreenState extends State<StoreScreen> {
  Size _screenSize;
  double _padding;

  ShopBloc shopBloc = ShopBloc();

  Widget introStore(ShopModel shopModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 5),
        Text(
            LocalizationsUtil.of(context).translate(
                'Tấm hình đầu tiên sẽ là hình nền của giao diện cửa hàng'),
            style: TextStyle(
                color: ThemeConstant.grey_color,
                fontFamily: ThemeConstant.form_font_family_display,
                fontSize: ThemeConstant.form_font_smaller,
                fontWeight: ThemeConstant.appbar_text_weight)),
        SizedBox(height: 15),
        Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: shopModel.images.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(child: ImageWidget(
                width: 120,
                height: 120,
                imgUrl: shopModel.images[index].imageThumb,
              ), padding: EdgeInsets.only(right: 15),);
            },
            //separatorBuilder: (BuildContext context, int index) => SizedBox(width: 15),)
        ))
      ],
    );
  }

  Widget descriptionStore(ShopModel shopModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 5),
        Text(
            LocalizationsUtil.of(context).translate(
                'Lời văn thật hay để cửa hàng bạn thu hút cư dân nhé!'),
            style: TextStyle(
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
            child: Text(shopModel.description != null && shopModel.description.length > 0
                ? shopModel.description
                : 'Chưa có mô tả'))
      ],
    );
  }

  Widget timeStore(ShopModel shopModel) {
    if (shopModel.hours.length == 0) {
      return Padding(child: Center(child: Text('Chưa có giờ làm việc')), padding: EdgeInsets.only(top:15),);
    }

    final Map<int, bool> disableWeekday = <int,bool>{
      0: true,
      1: true,
      2: true,
      3: true,
      4: true,
      5: true,
      6: true,
    };

    shopModel.hours.forEach((f) {
      disableWeekday[f.weekday] = false;
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 15),
        Container(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                TagsWidget(
                  text: 'T2',
                  isDisable: disableWeekday[0] ?? false,
                ),
                SizedBox(width: 10),
                TagsWidget(
                  text: 'T3',
                  isDisable: disableWeekday[1]?? false,
                ),
                SizedBox(width: 10),
                TagsWidget(
                  text: 'T4',
                  isDisable: disableWeekday[2]?? false,
                ),
                SizedBox(width: 10),
                TagsWidget(
                  text: 'T5',
                  isDisable: disableWeekday[3]?? false,
                ),
                SizedBox(width: 10),
                TagsWidget(
                  text: 'T6',
                  isDisable: disableWeekday[4]?? false,
                ),
                SizedBox(width: 10),
                TagsWidget(
                  text: 'T7',
                  isDisable: disableWeekday[5]?? false,
                ),
                SizedBox(width: 10),
                TagsWidget(
                  text: 'CN',
                  isDisable: disableWeekday[6]?? false,
                ),
              ],
            ),
            height: 40),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
                fit: FlexFit.tight,
                child: Container(
                    padding: EdgeInsets.only(
                        top: 15, bottom: 19, left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: ThemeConstant.background_grey_color,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Center(
                        child: Column(
                      children: <Widget>[
                        Text('Giờ mở cửa',
                            style: TextStyle(
                                color: ThemeConstant.black_color,
                                fontFamily:
                                    ThemeConstant.form_font_family_display,
                                fontSize: ThemeConstant.form_font_small,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 5),
                        Text(shopModel.hours[0].startTime,
                            style: TextStyle(
                                color: ThemeConstant.black_color,
                                fontFamily:
                                    ThemeConstant.form_font_family_display,
                                fontSize: ThemeConstant.sub_header_size,
                                fontWeight:
                                    ThemeConstant.appbar_text_weight_bold))
                      ],
                    )))),
            SizedBox(width: 15),
            Flexible(
                fit: FlexFit.tight,
                child: Container(
                    padding: EdgeInsets.only(
                        top: 15, bottom: 19, left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: ThemeConstant.background_grey_color,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Center(
                        child: Column(
                      children: <Widget>[
                        Text('Giờ đóng cửa',
                            style: TextStyle(
                                color: ThemeConstant.black_color,
                                fontFamily:
                                    ThemeConstant.form_font_family_display,
                                fontSize: ThemeConstant.form_font_small,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 5),
                        Text(shopModel.hours[0].endTime,
                            style: TextStyle(
                                color: ThemeConstant.black_color,
                                fontFamily:
                                    ThemeConstant.form_font_family_display,
                                fontSize: ThemeConstant.sub_header_size,
                                fontWeight:
                                    ThemeConstant.appbar_text_weight_bold))
                      ],
                    )))),
          ],
        )
      ],
    );
  }

  Widget editButton() {
    return Row(
      children: <Widget>[
        Icon(
          Icons.create,
          color: ThemeConstant.primary_color,
          size: 16,
        ),
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
      child: BlocBuilder(
          bloc: shopBloc,
          builder: (BuildContext context, ShopState shopState) {
            if (shopState is ShopInitial) {
              shopBloc.add(ShopGetDetail(id: Sqflite.current_shop));
            }

            if (shopState is ShopGetDetailSuccessful) {
              final shopModel = shopState.result;

              return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                        child: BoxesContainer(
                            child: Padding(
                                padding: EdgeInsets.all(this._padding),
                                child: Text(
                                    LocalizationsUtil.of(context).translate(
                                        'Lưu ý, các tuỳ chỉnh thông số ở dưới sẽ được hiển thị trên ứng dụng của cư dân'),
                                    style: TextStyle(
                                        color: ThemeConstant.grey_color,
                                        fontFamily: ThemeConstant
                                            .form_font_family_display,
                                        fontSize: ThemeConstant.label_font_size,
                                        fontWeight: ThemeConstant
                                            .appbar_text_weight))))),
                    SliverToBoxAdapter(
                        child: BoxesContainer(
                      title: 'Hình ảnh',
                      child: introStore(shopModel),
                      action: InkWell(
                          onTap: () async {
                            Router.push(context, Router.SHOP_IMAGES_PAGE, {
                              "shop_model": shopModel,
                              "callback": (List<FilePick> validationPicks) {
                                shopModel.images = validationPicks.map((f) {
                                  return ImageModel(id: f.id, image: f.url, imageThumb: f.urlThumb);
                                }).toList();
                              }
                            });
                          },
                          child: editButton()),
                      padding: EdgeInsets.all(this._padding),
                    )),
                    SliverToBoxAdapter(
                      child: BoxesContainer(
                      title: 'Mô tả',
                      child: descriptionStore(shopModel),
                      action: InkWell(
                          onTap: () async {
                            Router.push(context, Router.SHOP_DESCRIPTION_PAGE, {
                              "shop_model": shopModel,
                              "callback": (ShopModel _shopModel) {
                                shopModel.description = _shopModel.description;
                              }
                            });
                          },
                          child: editButton()),
                      padding: EdgeInsets.all(this._padding),
                    )),
                    SliverToBoxAdapter(
                        child: BoxesContainer(
                        title: 'Thời gian',
                        child: timeStore(shopModel),
                        action: InkWell(
                            onTap: () {
                              Router.push(context, Router.SHOP_TIME_PAGE, {
                                "shop_model": shopModel
                              });
                            },
                            child: editButton()),
                        padding: EdgeInsets.all(this._padding),
                      )),
                  ]);
            }

            return CardListSkeleton(
              shrinkWrap: true,
              length: 4,
              config: SkeletonConfig(
                theme: SkeletonTheme.Light,
                isShowAvatar: false,
                isCircleAvatar: false,
                bottomLinesCount: 4,
                radius: 0.0,
              ),
            );
          }),
    );
  }
}
