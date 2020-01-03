import 'package:flutter/widgets.dart';
import 'package:house_merchant/screen/base/base_scaffold.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key key}) : super(key: key);

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Menu',
      child: Text('hello world')
    );
  }
}