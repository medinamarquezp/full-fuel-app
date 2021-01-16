import 'package:flutter/material.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';

class ScreenTitle extends StatelessWidget {
  final String title;

  const ScreenTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final styles = TextStyle(color: FullfuelColors.primary, fontSize: 16);
    return Container(
      margin: EdgeInsets.only(top: 30, left: 20),
      width: double.infinity,
      child:
          Text(title.toUpperCase(), style: styles, textAlign: TextAlign.left),
    );
  }
}
