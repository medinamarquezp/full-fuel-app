import 'package:flutter/material.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';

class FormFieldContainerWidget extends StatelessWidget {
  final String label;
  final Widget widget;

  const FormFieldContainerWidget({Key key, this.label, this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labelTextStyles =
        TextStyle(color: FullfuelColors.secondary, fontSize: 13);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18),
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: FullfuelColors.secondary_30, width: 1),
          bottom: BorderSide(color: FullfuelColors.secondary_30, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: labelTextStyles),
          widget,
        ],
      ),
    );
  }
}
