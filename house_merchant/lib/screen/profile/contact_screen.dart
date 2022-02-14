import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/screen/base/base_scaffold_normal.dart';
import 'package:house_merchant/utils/localizations_util.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreenWidget extends StatelessWidget {
  Widget itemContact(BuildContext context, String title, String image,
      String content, Function onTap) {
    return Container(
        padding:
            EdgeInsets.only(left: 20.0, right: 15.0, top: 20.0, bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              children: <Widget>[
                SvgPicture.asset(image, width: 20, height: 20),
                SizedBox(width: 10.0),
                Expanded(
                  child: Text(title,
                      style: TextStyle(
                          letterSpacing: 0.26,
                          color: ThemeConstant.black_color,
                          fontFamily: ThemeConstant.form_font_family_display,
                          fontSize: ThemeConstant.form_font_title,
                          fontWeight: ThemeConstant.appbar_text_weight)),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: onTap,
              child: Text(
                content,
                style: TextStyle(
                    color: ThemeConstant.primary_color,
                    fontFamily: ThemeConstant.form_font_family_display,
                    fontSize: ThemeConstant.label_font_size,
                    fontWeight: ThemeConstant.fontWeightBold),
              ),
            ),
          ],
        ));
  }

  Widget contactBody(BuildContext context) {
    return CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
      SliverToBoxAdapter(
          child: Container(
              color: Colors.white,
              child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                          LocalizationsUtil.of(context).translate(
                              'Nếu có bất kì thắc mắc hay vấn đề trong quá trình sử dụng. Vui lòng liên hệ với chúng tôi qua các kênh sau:'),
                          style: TextStyle(
                              color: ThemeConstant.grey_color,
                              fontFamily:
                                  ThemeConstant.form_font_family_display,
                              fontSize: ThemeConstant.form_font_smaller,
                              fontWeight: ThemeConstant.appbar_text_weight)),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                          padding: EdgeInsets.only(bottom: 20.0),
                          decoration: BoxDecoration(
                            color: ThemeConstant.background_grey_color,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                          ),
                          child: Column(
                            children: <Widget>[
                              itemContact(
                                  context,
                                  'Điện thoại',
                                  'assets/icons/ic-phone.svg',
                                  '(+84) 35 482 9688', () {
                                launch('tel://(+84) 35 482 9688');
                              }),
                              itemContact(
                                  context,
                                  'Email',
                                  'assets/icons/ic-mail.svg',
                                  'support@housemap.vn', () {
                                launch('mailto:support@housemap.vn');
                              }),
                              itemContact(
                                  context,
                                  'Facebook',
                                  'assets/icons/ic-facebook.svg',
                                  '/zrooms.asia', () {
                                launch('https://www.facebook.com/zrooms.asia');
                              }),
                            ],
                          )),
                    ],
                  ))))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldNormal(
        title: 'Liên hệ Houze Merchant',
        child: SafeArea(
          child: Container(
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                        child: Container(
                            color: ThemeConstant.background_grey_color),
                      ),
                      Expanded(child: contactBody(context)),
                    ],
                  )
                ],
              )),
        ));
  }
}
