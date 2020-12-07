import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';
import 'package:fullfuel_app/src/widgets/favourite_button_widget.dart';
import 'package:fullfuel_app/src/services/geolocation.dart';
import 'package:fullfuel_app/src/entities/fuel_price_entity.dart';
import 'package:fullfuel_app/src/entities/fuelstation_list_entity.dart';

class FuelstationCardWidget extends StatelessWidget {
  final FuelstationListEntity fuelstation;
  final double appLatitude;
  final double appLongitude;
  final _apiURL = DotEnv().env['API_URL'];

  FuelstationCardWidget(this.fuelstation, this.appLatitude, this.appLongitude);

  @override
  Stack build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => {
            Navigator.pushNamed(context, 'detail',
                arguments: {'fuelstationID': fuelstation.fuelstationID})
          },
          child: Card(
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
                                _cardFuelIconBrand(
                                    brandLogo: fuelstation.brandImage),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _cardTitle(fuelstation.name),
                                    Container(
                                      margin: EdgeInsets.only(top: 2),
                                      child: Row(
                                        children: [
                                          _cardFuelStationDistance(
                                              Geolocation.getDistance(
                                            appLatitude,
                                            appLongitude,
                                            fuelstation.latitude,
                                            fuelstation.longitude,
                                          )),
                                          _cardFuelStationIsOpen(
                                              fuelstation.isNowOpen)
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
                        for (final fuelprice in fuelstation.fuelPrices)
                          _cardFuelPrices(
                              FuelPriceEntity.getFuelNameFromType(
                                  fuelprice.fuelType),
                              fuelprice.price,
                              fuelprice.evolution)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 20,
          child: FavouriteButtonWidget(
              id: fuelstation.fuelstationID, fuelstation: fuelstation),
        )
      ],
    );
  }

  Container _cardFuelIconBrand({String brandLogo}) {
    final fuelStationIcon = "lib/assets/gasStationIcon.svg";
    final noBrandIcon = CircleAvatar(
      backgroundColor: FullfuelColors.secondary_20,
      child: SvgPicture.asset(fuelStationIcon,
          alignment: Alignment.center, width: 18),
    );
    final brandIcon = (brandLogo == "")
        ? noBrandIcon
        : CircleAvatar(
            backgroundImage: NetworkImage(_apiURL + brandLogo),
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
              Text(fuelName, style: nameTextStyles),
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
}
