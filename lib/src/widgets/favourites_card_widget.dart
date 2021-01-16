import 'package:flutter/material.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';

class FavouritesCardWidget extends StatelessWidget {
  final String fuelstationName;
  final String fuelType;

  FavouritesCardWidget(this.fuelstationName, this.fuelType);

  @override
  Stack build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => {
            Navigator.pushNamed(context, 'detail', arguments: {'name': 'value'})
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
                  _deleteButton(),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 20,
          child: _actionButton(),
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
            TextSpan(text: fuelType.toUpperCase(), style: highlightTextStyle),
          ],
        ),
      ),
    );
  }

  TextButton _deleteButton() {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
      onPressed: () => {},
      child: Text(
        "Eliminar".toUpperCase(),
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  FloatingActionButton _actionButton() {
    return FloatingActionButton(
      onPressed: () => {},
      child: Icon(Icons.edit, size: 32, color: FullfuelColors.action),
      backgroundColor: Colors.white,
    );
  }
}
