import 'package:flutter/widgets.dart';
import 'package:house_merchant/screen/base/base_scaffold.dart';

class PromotionScreen extends StatefulWidget {
  PromotionScreen({Key key}) : super(key: key);

  @override
  PromotionScreenState createState() => PromotionScreenState();
}

class PromotionScreenState extends State<PromotionScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Ưu đãi',
      child: Text('hello world')
    );
  }
}