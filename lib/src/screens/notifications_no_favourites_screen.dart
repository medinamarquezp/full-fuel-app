import 'package:flutter/material.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';
import 'package:fullfuel_app/src/widgets/safe_scaffold_widget.dart';
import 'package:fullfuel_app/src/widgets/icon_message_widget.dart';

class NotificationsNoFavouritesScreen extends StatelessWidget {
  const NotificationsNoFavouritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeScaffoldWidget(
      pageTitle: "Mis alertas",
      page: IconMessageWidget(
        iconPath: "lib/assets/noFavouritesDashed.svg",
        title: "¿NO TIENES GASOLINERAS FAVORITAS?",
        content:
            "Debes haber marcado, al menos, una gasolinera como favorita para poder crear una nueva alerta ¿a qué estás esperando?",
      ),
      pageIndex: 2,
      floatingButton: _actionButton(),
    );
  }

  FloatingActionButton _actionButton() {
    return FloatingActionButton(
      disabledElevation: .5,
      onPressed: null,
      child: Icon(Icons.add,
          size: 40, color: FullfuelColors.action.withOpacity(0.2)),
      backgroundColor: Colors.white,
    );
  }
}
