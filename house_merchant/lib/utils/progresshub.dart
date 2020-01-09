import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/utils/localizations_util.dart';

class ProgressHUD extends StatefulWidget {
  final Color backgroundColor;
  final Color color;
  final Color containerColor;
  final double borderRadius;
  String text;
  final bool loading;
  _ProgressHUDState state;

  ProgressHUD(
      {Key key,
      this.backgroundColor = Colors.black54,
      this.color = Colors.white,
      this.containerColor = Colors.transparent,
      this.borderRadius = 10.0,
      this.text,
      this.loading = false})
      : super(key: key);

  @override
  _ProgressHUDState createState() {
    state = new _ProgressHUDState();

    return state;
  }
}

class _ProgressHUDState extends State<ProgressHUD> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();

    _visible = widget.loading;
  }

  void dismiss() {
    setState(() {
      this._visible = false;
    });
  }

  void show() {
    setState(() {
      this._visible = true;
    });
  }

  void clear() {
    widget.text = "Loading ...";
  }

  void update(double percent) {
    if (widget.text != null) {
      setState(() {
        widget.text = "${percent.ceil()} %";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_visible) {
      return new Scaffold(
          backgroundColor: widget.backgroundColor,
          body: new Stack(
            children: <Widget>[
              new Center(
                child: new Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: new BoxDecoration(
                      color: widget.containerColor,
                      borderRadius: new BorderRadius.all(
                          new Radius.circular(widget.borderRadius))),
                ),
              ),
              new Center(
                child: _getCenterContent(context),
              )
            ],
          ));
    } else {
      return new Container();
    }
  }

  Widget _getCenterContent(BuildContext context) {
    if (widget.text == null || widget.text.isEmpty) {
      return _getCircularProgress();
    }

    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getCircularProgress(),
          new Container(
            margin: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
            child: new Text(
              LocalizationsUtil.of(context).translate(widget.text),
              style: new TextStyle(color: widget.color),
            ),
          )
        ],
      ),
    );
  }

  Widget _getCircularProgress() {
    return SpinKitFadingCircle(
      color: Colors.white,
      size: 50.0,
    );
  }
}

class Progress {
  
  static ProgressHUD instance = new ProgressHUD(
    backgroundColor: Colors.black12,
    color: Colors.white,
    containerColor: ThemeConstant.primary_color,
    borderRadius: 20.0,
    text: 'Loading...',
  );

  static ProgressHUD instanceCreate() {
    return new ProgressHUD(
      backgroundColor: Colors.black12,
      color: Colors.white,
      containerColor: ThemeConstant.primary_color,
      borderRadius: 20.0,
      text: 'Loading...',
    );
  }

  static ProgressHUD instanceCreateWithNormal() {
    return new ProgressHUD(
      backgroundColor: Colors.transparent,
      color: Colors.white,
      containerColor: Colors.transparent,
      borderRadius: 5.0
    );
  }
}