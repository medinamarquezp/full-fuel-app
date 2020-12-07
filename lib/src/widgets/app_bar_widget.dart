import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key key}) : super(key: key);
  final barHeight = 70.0;

  @override
  AppBar build(BuildContext context) {
    final logoPrimary = "lib/assets/brandPrimary.svg";
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: Navigator.canPop(context)
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: FullfuelColors.primary,
                size: 36,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
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
