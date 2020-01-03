import 'package:flutter/widgets.dart';
import 'package:house_merchant/screen/base/base_scaffold.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key key}) : super(key: key);

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Đơn hàng',
      child: Text('hello world')
    );
  }
}