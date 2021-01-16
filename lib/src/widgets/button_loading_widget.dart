import 'package:flutter/material.dart';
import 'package:progress_indicator_button/progress_button.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';

class ButtonLoadingWidget extends StatelessWidget {
  final String label;
  final Function fn;

  const ButtonLoadingWidget({Key key, this.label, this.fn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labelTextStyles = TextStyle(fontSize: 16, color: Colors.white);
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 60,
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 40),
          child: ProgressButton(
            color: FullfuelColors.action,
            borderRadius: BorderRadius.all(Radius.circular(4)),
            child: Text(
              label.toUpperCase(),
              style: labelTextStyles,
            ),
            onPressed: (AnimationController controller) async {
              await fn(controller);
            },
          ),
        ),
      ),
    );
  }
}
