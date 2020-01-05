import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/utils/localizations_util.dart';

typedef void CallBackHandler(dynamic value);

class GroupRadioTags {
  dynamic id;
  String title;
  Widget icon;

  GroupRadioTags({this.id, this.title, this.icon});
}

class GroupRadioTagsWidget extends StatefulWidget {

  StreamController<dynamic> controller;
  List<GroupRadioTags> tags;
  CallBackHandler callback;
  CallBackHandler callBackIndex;
  int defaultIndex = 0;

  GroupRadioTagsWidget({
    this.callback,
    this.callBackIndex,
    this.tags,
    this.controller,
    this.defaultIndex,
  });

  GroupRadioTagsWidgetState createState() => GroupRadioTagsWidgetState();
}

class GroupRadioTagsWidgetState extends State<GroupRadioTagsWidget> {


  Widget buttonIcon({index, id, title, icon, isSelected=false}) {

    return Padding(padding: EdgeInsets.only(left: 15, right: 15), child: FlatButton(
      color: isSelected ? ThemeConstant.listview_selected_color : Colors.white,
      onPressed: () {
        setState(() {
          widget.defaultIndex = index;
        });
        if (widget.callback!=null) widget.callback(id);
        if (widget.callBackIndex!=null) widget.callBackIndex(index);
      },
      shape: new RoundedRectangleBorder(
        borderRadius: ThemeConstant.button_radius,
        side: BorderSide(color: isSelected ? ThemeConstant.listview_selected_color : ThemeConstant.form_border_small)
      ),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(LocalizationsUtil.of(context).translate(title), style: TextStyle(
              color: isSelected ? ThemeConstant.link_color : ThemeConstant.normal_color
            ),),
            icon != null ? icon: Center()
          ],
        )
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {

    if (widget.controller == null)
      widget.controller = new StreamController<dynamic>();

    return Container(
      height: 73,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(top: 15, bottom: 20),
          physics: const BouncingScrollPhysics(),
          itemCount: widget.tags.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == widget.defaultIndex) {
              return buttonIcon(id: widget.tags[index].id, index: index, title: widget.tags[index].title, icon: widget.tags[index].icon, isSelected: true);
            }
            return buttonIcon(id: widget.tags[index].id, index: index, title: widget.tags[index].title, icon: widget.tags[index].icon);
          },
      ),
    );
   
  }
}
