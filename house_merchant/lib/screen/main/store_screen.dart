import 'package:flutter/widgets.dart';
import 'package:house_merchant/screen/base/base_scaffold.dart';

class StoreScreen extends StatefulWidget {
  StoreScreen({Key key}) : super(key: key);

  @override
  StoreScreenState createState() => StoreScreenState();
}

class StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Cửa hàng',
      child: Text('hello world')
    );
  }
}