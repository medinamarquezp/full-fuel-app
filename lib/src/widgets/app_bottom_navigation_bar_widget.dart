import 'package:flutter/material.dart';
import 'package:fullfuel_app/src/routes/app_routes.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';

class AppBottomNavigationBarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  final int index;

  const AppBottomNavigationBarWidget({Key key, this.index}) : super(key: key);

  @override
  _AppBottomNavigationBarWidgetState createState() =>
      _AppBottomNavigationBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(0);
}

class _AppBottomNavigationBarWidgetState
    extends State<AppBottomNavigationBarWidget> {
  void _onItemTapped(BuildContext context, int index) {
    final route = getNavigationRouteName(index);
    Navigator.pushNamed(context, route);
  }

  @override
  BottomNavigationBar build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.reorder, size: 30), label: "Listado"),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite, size: 30), label: "Favoritas"),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications, size: 30), label: "Notificaciones"),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 30), label: "Configuración"),
      ],
      currentIndex: widget.index,
      selectedItemColor: FullfuelColors.primary,
      unselectedItemColor: FullfuelColors.secondary_50,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (int index) {
        _onItemTapped(context, index);
      },
    );
  }
}
