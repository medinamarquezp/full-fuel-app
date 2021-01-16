import 'package:flutter/material.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';
import 'package:fullfuel_app/src/widgets/app_bar_widget.dart';
import 'package:fullfuel_app/src/widgets/app_bottom_navigation_bar_widget.dart';
import 'package:fullfuel_app/src/widgets/screen_title.dart';

class SafeScaffoldWidget extends StatelessWidget {
  final Widget page;
  final int pageIndex;
  final String pageTitle;
  final dynamic floatingButton;

  const SafeScaffoldWidget({
    Key key,
    this.page,
    this.pageTitle = "",
    this.pageIndex,
    this.floatingButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: FullfuelColors.secondary_5,
        appBar: AppBarWidget(),
        body: Column(
          children: [
            ScreenTitle(title: pageTitle),
            Expanded(
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: FullfuelColors.primary,
                child: page,
              ),
            ),
          ],
        ),
        floatingActionButton:
            (floatingButton is FloatingActionButton) ? floatingButton : null,
        bottomNavigationBar: AppBottomNavigationBarWidget(index: pageIndex),
      ),
    );
  }
}
