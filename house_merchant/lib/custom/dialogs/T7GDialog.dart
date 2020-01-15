import 'package:flutter/material.dart';
import 'package:house_merchant/utils/localizations_util.dart';

typedef SubmitFunc = Future Function(BuildContext context);

class T7GDialog {
  static void showAlertDialog(
      BuildContext context, String title, String message,
      {SubmitFunc submit}) {
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: title != null
                ? Text(LocalizationsUtil.of(context).translate(title))
                : Center(),
            content: Text(
              LocalizationsUtil.of(context).translate(message),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  if (submit != null) {
                    await submit(context);
                  }
                },
              ),
            ],
          );
        });
  }

  static Future<String> showContentDialog(
      BuildContext context, List<Widget> widgets,
      {String title,
      bool closeShow = true,
      bool barrierDismissible = true}) async {
    return await showDialog<String>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            titlePadding: EdgeInsets.all(0),
            title: closeShow == true
                ? Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ))
                : Center(),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            content: Container(
                padding: EdgeInsets.all(0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: widgets)));
      },
    );
  }

  static void showSimpleDialog(BuildContext context, List<Widget> widgets,
      {String title, bool barrierDismissible = true}) async {
    showDialog<Null>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        if (title != null) {
          return SimpleDialog(
            title: Text(
              LocalizationsUtil.of(context).translate(title),
            ),
            children: widgets,
          );
        }

        return SimpleDialog(
          children: widgets,
        );
      },
    );
  }
}
