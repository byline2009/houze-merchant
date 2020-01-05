import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/screen/base/base_scaffold.dart';
import 'package:house_merchant/utils/localizations_util.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key key}) : super(key: key);

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  Widget tabBar() {
    return TabBar(
      unselectedLabelColor: ThemeConstant.unselected_color,
      labelColor: ThemeConstant.primary_color,
      tabs: [
        new Tab(child: Text(LocalizationsUtil.of(context).translate("Đơn mới"), style: TextStyle(
          fontFamily: ThemeConstant.form_font_family,
          fontSize: ThemeConstant.label_font_size,
          fontWeight: ThemeConstant.appbar_text_weight)),),
        new Tab(child: Text(LocalizationsUtil.of(context).translate("Đang xử lý"), style: TextStyle(
          fontFamily: ThemeConstant.form_font_family,
          fontSize: ThemeConstant.label_font_size,
          fontWeight: ThemeConstant.appbar_text_weight)),),
        new Tab(child: Text(LocalizationsUtil.of(context).translate("Đã xong"), style: TextStyle(
          fontFamily: ThemeConstant.form_font_family,
          fontSize: ThemeConstant.label_font_size,
          fontWeight: ThemeConstant.appbar_text_weight)),),
      ],
      indicatorColor: ThemeConstant.primary_color,
      indicatorSize: TabBarIndicatorSize.tab,
      controller: _tabController
    );
  }

  Widget contentOrder() {
    return TabBarView(
      children: [
        Container(child: Center(child: Text('Chưa có đơn hàng nào'))),
        Container(child: Center(child: Text('Chưa có đơn hàng nào'))),
        Container(child: Center(child: Text('Chưa có đơn hàng nào'))),
      ],
      controller: _tabController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Đơn hàng',
      bottom: this.tabBar(),
      child: this.contentOrder()
    );
  }
}