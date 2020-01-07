import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/screen/base/base_scaffold.dart';
import 'package:house_merchant/utils/localizations_util.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key key}) : super(key: key);

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen>
    with SingleTickerProviderStateMixin {
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
          new Tab(
            child: Text(LocalizationsUtil.of(context).translate("Đơn mới"),
                style: TextStyle(
                    fontFamily: ThemeConstant.form_font_family,
                    fontSize: ThemeConstant.label_font_size,
                    fontWeight: ThemeConstant.appbar_text_weight)),
          ),
          new Tab(
            child: Text(LocalizationsUtil.of(context).translate("Đang xử lý"),
                style: TextStyle(
                    fontFamily: ThemeConstant.form_font_family,
                    fontSize: ThemeConstant.label_font_size,
                    fontWeight: ThemeConstant.appbar_text_weight)),
          ),
          new Tab(
            child: Text(LocalizationsUtil.of(context).translate("Đã xong"),
                style: TextStyle(
                    fontFamily: ThemeConstant.form_font_family,
                    fontSize: ThemeConstant.label_font_size,
                    fontWeight: ThemeConstant.appbar_text_weight)),
          ),
        ],
        indicatorColor: ThemeConstant.primary_color,
        indicatorSize: TabBarIndicatorSize.tab,
        controller: _tabController);
  }

  Widget _orderEmpty = Container(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset('assets/images/ic-order-empty.svg',
              width: 80.0, height: 80.0),
          SizedBox(height: 10.0),
          Text(
            'Chưa có đơn hàng nào',
            style: TextStyle(
                fontSize: 16.0,
                color: ThemeConstant.grey_color,
                letterSpacing: 0.26,
                fontWeight: ThemeConstant.appbar_text_weight),
          )
        ],
      ),
    ),
  );

  Widget contentOrder() {
    return TabBarView(
      children: [_orderEmpty, _orderEmpty, _orderEmpty],
      controller: _tabController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        title: 'Đơn hàng', bottom: this.tabBar(), child: this.contentOrder());
  }
}
