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
import 'package:house_merchant/screen/base/sc_image_view.dart';
import 'package:house_merchant/screen/store/list/widget_description_box.dart';
import 'package:house_merchant/screen/store/store_edit_description_screen.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:house_merchant/utils/sqflite.dart';

class StoreEditArgument {
  final CallBackHandler callback;
  final ShopModel shopModel;
  StoreEditArgument({@required this.callback, @required this.shopModel});
}

class StoreScreen extends StatefulWidget {
  StoreScreen({Key key}) : super(key: key);

  @override
  StoreScreenState createState() => StoreScreenState();
}

class StoreScreenState extends State<StoreScreen> {
  Size _screenSize;
  double _padding;

  final shopBloc = ShopBloc(ShopInitial());

  Widget introStore(List<ImageModel> images) {
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
              itemCount: images.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    List<String> _imgs = [];

                    images.forEach((element) => _imgs.add(element.image));

                    AppRouter.pushDialog(context, AppRouter.IMAGE_VIEW_SCREEN,
                        ImageViewScreenArgument(images: _imgs));
                  },
                  child: Container(
                    child: ImageWidget(
                      width: 120,
                      height: 120,
                      imgUrl: images[index].imageThumb.length > 0
                          ? images[index].imageThumb
                          : "https://anhdaostorage.blob.core.windows.net/qa-media/facility/20191114014630397045/meeting-room.jpg",
                    ),
                    padding: EdgeInsets.only(right: 15),
                  ),
                );
              },
            ))
      ],
    );
  }

  Widget timeStore(List<Hours> hours) {
    if (hours.length == 0) {
      return Padding(
        child: Center(child: Text('Chưa có giờ làm việc')),
        padding: EdgeInsets.only(top: 15),
      );
    }

    final Map<int, bool> disableWeekday = <int, bool>{
      0: true,
      1: true,
      2: true,
      3: true,
      4: true,
      5: true,
      6: true,
    };

    hours.forEach((f) {
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
                  isDisable: disableWeekday[1] ?? false,
                ),
                SizedBox(width: 10),
                TagsWidget(
                  text: 'T4',
                  isDisable: disableWeekday[2] ?? false,
                ),
                SizedBox(width: 10),
                TagsWidget(
                  text: 'T5',
                  isDisable: disableWeekday[3] ?? false,
                ),
                SizedBox(width: 10),
                TagsWidget(
                  text: 'T6',
                  isDisable: disableWeekday[4] ?? false,
                ),
                SizedBox(width: 10),
                TagsWidget(
                  text: 'T7',
                  isDisable: disableWeekday[5] ?? false,
                ),
                SizedBox(width: 10),
                TagsWidget(
                  text: 'CN',
                  isDisable: disableWeekday[6] ?? false,
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
                        Text(hours[0].startTime,
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
                        Text(hours[0].endTime,
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
    return Container(
        height: 44,
        child: Row(
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
        ));
  }

  @override
  void dispose() {
    super.dispose();
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
            print(shopState.toString().toUpperCase());
            if (shopState is ShopInitial) {
              shopBloc.add(ShopGetDetail(id: Sqflite.current_shop));
            }

            if (shopState is ShopGetDetailSuccessful) {
              final shopModel = shopState.result;
              List<ImageModel> _images = shopState.result.images;
              List<Hours> _hours = shopState.result.hours;
              String _description = shopModel.description;
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
                      child: introStore(_images),
                      action: InkWell(
                          onTap: () async {
                            AppRouter.push(
                                context,
                                AppRouter.SHOP_IMAGES_PAGE,
                                StoreEditArgument(
                                    callback: (shop) {
                                      setState(() {
                                        _images = shop.images;
                                      });
                                    },
                                    shopModel: shopModel));
                          },
                          child: editButton()),
                      padding: EdgeInsets.all(this._padding),
                    )),
                    SliverToBoxAdapter(
                        child: BoxesContainer(
                      title: 'Mô tả',
                      child: DescriptionBox(description: _description),
                      action: InkWell(
                          onTap: () async {
                            AppRouter.push(
                                context,
                                AppRouter.SHOP_DESCRIPTION_PAGE,
                                StoreEditArgument(
                                    callback: (shop) {
                                      if (shop.description.toLowerCase() !=
                                          _description.toLowerCase()) {
                                        print(shop.description);
                                        setState(() {
                                          _description = shop.description;
                                        });
                                      }
                                    },
                                    shopModel: shopModel));
                          },
                          child: editButton()),
                      padding: EdgeInsets.all(this._padding),
                    )),
                    SliverToBoxAdapter(
                        child: BoxesContainer(
                      title: 'Thời gian',
                      child: timeStore(_hours),
                      action: InkWell(
                          onTap: () {
                            AppRouter.push(
                                context,
                                AppRouter.SHOP_TIME_PAGE,
                                StoreEditArgument(
                                    callback: (shop) {
                                      if (shop.hours != shopModel.hours) {
                                        print(shop.hours);
                                        setState(() {
                                          _hours = shop.hours;
                                        });
                                      }
                                    },
                                    shopModel: shopModel));
                          },
                          child: editButton()),
                      padding: EdgeInsets.all(this._padding),
                    )),
                  ]);
            }

            if (shopState is ShopFailure) {
              return Center();
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
