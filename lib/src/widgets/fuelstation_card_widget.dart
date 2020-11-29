import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';

class FuelstationCardWidget extends StatelessWidget {
  const FuelstationCardWidget({Key key}) : super(key: key);

  @override
  Card build(BuildContext context) {
    return Card(
      elevation: 30,
      shadowColor: FullfuelColors.secondary_5,
      margin: EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _cardFuelIconBrand(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _cardTitle("Estación de servicio Galp"),
                              Container(
                                margin: EdgeInsets.only(top: 2),
                                child: Row(
                                  children: [
                                    _cardFuelStationDistance("0.9 KM"),
                                    _cardFuelStationIsOpen(true)
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _cardFuelPrices("Gasolina 95", 1.259, "UP"),
                  _cardFuelPrices("Gasolina 98", 1.259, "DOWN"),
                  _cardFuelPrices("Gasoil", 1.259, "EQUALS"),
                ],
              ),
            ),
            Align(
              alignment: Alignment(1.04, 0.1),
              heightFactor: 0,
              child: _cardActionButton(),
            ),
          ],
        ),
      ),
    );
  }

  Container _cardFuelIconBrand({String brandLogo}) {
    final fuelStationIcon = "lib/assets/gasStationIcon.svg";
    final noBrandIcon = CircleAvatar(
      backgroundColor: FullfuelColors.secondary_20,
      child: SvgPicture.asset(fuelStationIcon,
          alignment: Alignment.center, width: 18),
    );
    final brandIcon = (brandLogo == null)
        ? noBrandIcon
        : CircleAvatar(
            backgroundImage: NetworkImage(brandLogo),
            backgroundColor: Colors.transparent);
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: brandIcon,
    );
  }

  Container _cardTitle(String fuelStationName) {
    final titleTextStyles = TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: FullfuelColors.primary);
    return Container(
      child: Text(fuelStationName, style: titleTextStyles),
    );
  }

  Container _cardFuelStationDistance(String distance) {
    return Container(
      child: Row(
        children: [
          Icon(Icons.room, size: 15, color: FullfuelColors.secondary),
          Text(
            distance,
            style: TextStyle(color: FullfuelColors.secondary, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Container _cardFuelStationIsOpen(bool isOpen) {
    final isOpenContent = (isOpen) ? "ABIERTA" : "CERRADA";
    return Container(
      margin: EdgeInsets.only(left: 12),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 3),
            child: Icon(Icons.watch_later,
                size: 13, color: FullfuelColors.secondary),
          ),
          Text(
            isOpenContent,
            style: TextStyle(color: FullfuelColors.secondary, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Container _cardFuelPrices(String fuelName, double price, String status) {
    final priceTextStyles = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: FullfuelColors.primary);
    final nameTextStyles =
        TextStyle(fontSize: 12, color: FullfuelColors.primary);
    return Container(
      margin: EdgeInsets.only(right: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(fuelName.toUpperCase(), style: nameTextStyles),
              Row(
                children: [
                  Text(price.toString(), style: priceTextStyles),
                  Container(
                    child: _cardFuelPricesArrow(status),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Icon _cardFuelPricesArrow(String status) {
    if (status == "DOWN") {
      return Icon(Icons.arrow_downward, color: FullfuelColors.down);
    }
    if (status == "UP") {
      return Icon(Icons.arrow_upward, color: FullfuelColors.up);
    }
    return Icon(Icons.import_export, color: FullfuelColors.secondary);
  }

  FloatingActionButton _cardActionButton() {
    return FloatingActionButton(
      heroTag: null,
      backgroundColor: Colors.white,
      onPressed: null,
      child: Icon(Icons.favorite, size: 30, color: FullfuelColors.action),
    );
  }
}
