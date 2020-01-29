import 'package:flutter/material.dart';
import 'package:house_merchant/constant/theme_constant.dart';

class ChoiceChipsWidget extends StatefulWidget {
  final List choiceChipList;
  final Function(List<int>) onSelectionChanged;
  List<int> selectedChoices = List();

  ChoiceChipsWidget(this.choiceChipList, {this.onSelectionChanged, this.selectedChoices});

  @override
  _ChoiceChipsWidgetState createState() => _ChoiceChipsWidgetState();
}

class _ChoiceChipsWidgetState extends State<ChoiceChipsWidget> {

  _buildChoiceList() {
    List<Widget> choices = List();

    widget.choiceChipList.forEach((item) {
      choices.add(Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: widget.selectedChoices.contains(item.key)
                  ? ThemeConstant.listview_selected_color
                  : ThemeConstant.white_color,
              border: Border.all(
                color: widget.selectedChoices.contains(item.key)
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
                    color: widget.selectedChoices.contains(item.key)
                        ? ThemeConstant.primary_color
                        : ThemeConstant.grey_color),
              ),
              selected: widget.selectedChoices.contains(item.key),
              onSelected: (selected) {
                setState(() {
                  widget.selectedChoices.contains(item.key)
                      ? widget.selectedChoices.remove(item.key)
                      : widget.selectedChoices.add(item.key);
                  widget.onSelectionChanged(widget.selectedChoices);
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
