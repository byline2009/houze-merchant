import 'package:flutter/material.dart';
import 'package:house_merchant/constant/theme_constant.dart';

class ChoiceChipsWidget extends StatefulWidget {
  final List choiceChipList;
  final Function(List<int>) onSelectionChanged;

  ChoiceChipsWidget(this.choiceChipList, {this.onSelectionChanged});

  @override
  _ChoiceChipsWidgetState createState() => _ChoiceChipsWidgetState();
}

class _ChoiceChipsWidgetState extends State<ChoiceChipsWidget> {
  List<int> selectedChoices = List();

  _buildChoiceList() {
    List<Widget> choices = List();

    widget.choiceChipList.forEach((item) {
      choices.add(Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: selectedChoices.contains(item.key)
                  ? ThemeConstant.listview_selected_color
                  : ThemeConstant.white_color,
              border: Border.all(
                color: selectedChoices.contains(item.key)
                    ? Colors.transparent
                    : ThemeConstant.form_border_normal,
                width: 1,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          child: ChoiceChip(
              padding: EdgeInsets.all(0),
              backgroundColor: Colors.white,
              selectedColor: ThemeConstant.listview_selected_color,
              disabledColor: Colors.transparent,
              selectedShadowColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: StadiumBorder(
                  side: BorderSide(color: Colors.transparent, width: 0.0)),
              label: Text(
                item.value,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.26,
                    color: selectedChoices.contains(item.key)
                        ? ThemeConstant.primary_color
                        : ThemeConstant.grey_color),
              ),
              selected: selectedChoices.contains(item.key),
              onSelected: (selected) {
                setState(() {
                  selectedChoices.contains(item.key)
                      ? selectedChoices.remove(item.key)
                      : selectedChoices.add(item.key);
                  widget.onSelectionChanged(selectedChoices);
                });
              })));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
