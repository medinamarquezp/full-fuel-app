import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';

class IconMessageWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final String content;

  const IconMessageWidget(
      {Key key, this.iconPath, this.title, this.content = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _icon(),
      _title(),
      _content(),
    ]);
  }

  Container _icon() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 40, bottom: 20),
      child:
          SvgPicture.asset(iconPath, alignment: Alignment.center, width: 220),
    );
  }

  Container _title() {
    final styles = TextStyle(
        color: FullfuelColors.primary,
        fontWeight: FontWeight.bold,
        fontSize: 16);
    return Container(
      child: Text(title, style: styles, textAlign: TextAlign.center),
    );
  }

  Container _content() {
    final styles = TextStyle(color: FullfuelColors.secondary, fontSize: 15);
    return Container(
      width: 300,
      margin: EdgeInsets.only(top: 10, bottom: 50),
      child: Text(
        content,
        textAlign: TextAlign.center,
        style: styles,
      ),
    );
  }
}
