import 'package:flutter/material.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';
import 'package:fullfuel_app/src/widgets/safe_scaffold_widget.dart';
import 'package:fullfuel_app/src/widgets/icon_message_widget.dart';

class NotificationsEmptyScreen extends StatelessWidget {
  const NotificationsEmptyScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeScaffoldWidget(
      pageTitle: "Mis alertas",
      page: IconMessageWidget(
        iconPath: "lib/assets/noNotificationsDashed.svg",
        title: "AÚN NO HAS CONFIGURADO ALERTAS",
      ),
      pageIndex: 2,
      floatingButton: _actionButton(),
    );
  }

  FloatingActionButton _actionButton() {
    return FloatingActionButton(
      onPressed: () => {},
      child: Icon(Icons.add, size: 40, color: FullfuelColors.action),
      backgroundColor: Colors.white,
    );
  }
}
