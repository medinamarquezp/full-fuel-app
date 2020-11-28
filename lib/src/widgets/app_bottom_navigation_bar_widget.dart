import 'package:flutter/material.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';

class AppBottomNavigationBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBottomNavigationBarWidget({Key key}) : super(key: key);

  @override
  BottomNavigationBar build(BuildContext context) {
    return BottomNavigationBar(
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
      currentIndex: 1,
      selectedItemColor: FullfuelColors.primary,
      unselectedItemColor: FullfuelColors.secondary_50,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(0);
}
