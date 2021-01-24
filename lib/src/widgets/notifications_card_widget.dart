import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';
import 'package:fullfuel_app/src/widgets/dialog_widget.dart';
import 'package:fullfuel_app/src/entities/fuel_price_entity.dart';

class NotificationsCardWidget extends StatelessWidget {
  final notificationsBox = Hive.box('notifications');
  final int fuelStationID;
  final String fuelstationName;
  final String fuelType;

  NotificationsCardWidget(
      this.fuelStationID, this.fuelstationName, this.fuelType);

  void _deleteNotification(int notificationID) async {
    await notificationsBox.delete(notificationID);
  }

  @override
  Stack build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => {
            Navigator.pushNamed(context, 'notificationsForm', arguments: {
              'isCreating': false,
              'selectedFuelStation': fuelStationID,
              'selectedFuelType': fuelType
            })
          },
          child: Card(
            elevation: 30,
            shadowColor: FullfuelColors.secondary_5,
            margin: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title(),
                  _content(),
                  _deleteButton(context, fuelStationID),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 20,
          child: _actionButton(context),
        )
      ],
    );
  }

  Container _title() {
    final text = "Avísame cuando...";
    final styles = TextStyle(
        color: FullfuelColors.primary,
        fontWeight: FontWeight.bold,
        fontSize: 16);
    return Container(
      child: Text(text, style: styles, textAlign: TextAlign.left),
    );
  }

  Container _content() {
    final textStyle = TextStyle(fontSize: 16, color: FullfuelColors.primary);
    final highlightTextStyle = TextStyle(
        fontSize: 16,
        color: FullfuelColors.primary,
        fontWeight: FontWeight.bold);
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(text: 'La gasolinera ', style: textStyle),
            TextSpan(
                text: fuelstationName.toUpperCase(), style: highlightTextStyle),
            TextSpan(text: ' baje el precio del ', style: textStyle),
            TextSpan(
                text:
                    FuelPriceEntity.getFuelNameFromType(fuelType).toUpperCase(),
                style: highlightTextStyle),
          ],
        ),
      ),
    );
  }

  TextButton _deleteButton(BuildContext context, int notificationID) {
    return TextButton(
      style: TextButton.styleFrom(
          padding: EdgeInsets.all(0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      onPressed: () => dialogWidget(
          context: context,
          title: "Eliminar notificación",
          content:
              "Si continuas con esta acción, eliminarás la notificación seleccionada ¿quieres realizar esta acción?",
          actionLabel: "Eliminar",
          action: _deleteNotification,
          actionParam: notificationID),
      child: Text(
        "Eliminar".toUpperCase(),
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  FloatingActionButton _actionButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: "modifyNotification_$fuelStationID",
      onPressed: () => {
        Navigator.pushNamed(context, 'notificationsForm', arguments: {
          'isCreating': false,
          'selectedFuelStation': fuelStationID,
          'selectedFuelType': fuelType
        })
      },
      child: Icon(Icons.edit, size: 32, color: FullfuelColors.action),
      backgroundColor: Colors.white,
    );
  }
}
