import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key key}) : super(key: key);
  final barHeight = 70.0;

  @override
  AppBar build(BuildContext context) {
    final logoPrimary = "lib/assets/brandPrimary.svg";
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: barHeight,
      title:
          SvgPicture.asset(logoPrimary, alignment: Alignment.center, width: 50),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(barHeight);
}
