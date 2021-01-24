import 'package:flutter/material.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';

void dialogWidget({
  BuildContext context,
  String title,
  String content,
  String actionLabel,
  dynamic action,
  dynamic actionParam,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(title),
        content: new Text(content),
        actions: <Widget>[
          new TextButton(
            child: new Text(
              "Cancelar".toUpperCase(),
              style: TextStyle(color: FullfuelColors.primary, fontSize: 15),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new TextButton(
            child: new Text(
              actionLabel.toUpperCase(),
              style: TextStyle(color: Colors.red, fontSize: 15),
            ),
            onPressed: () {
              action(actionParam);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
