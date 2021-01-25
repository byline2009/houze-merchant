import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      alignment: Alignment.topCenter,
      child: Column(children: <Widget>[
        SizedBox(height: 100),
        Text('Danh sách trống'),
      ]),
    ));
  }
}
