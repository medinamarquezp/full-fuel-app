import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';
import 'package:fullfuel_app/src/services/geolocation.dart';
import 'package:fullfuel_app/src/services/open_maps.dart';
import 'package:fullfuel_app/src/widgets/app_bar_widget.dart';
import 'package:fullfuel_app/src/widgets/linear_chart_widget.dart';
import 'package:fullfuel_app/src/widgets/brand_icon_widget.dart';
import 'package:fullfuel_app/src/widgets/app_bottom_navigation_bar_widget.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double appLatitude;
  double appLongitude;
  int fuelstationID;

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    appLatitude = arguments['appLatitude'];
    appLongitude = arguments['appLongitude'];
    fuelstationID = arguments['fuelstationID'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(),
      body: SafeArea(
        child: ListView(
          children: [
            _headData(
                name: "Estación de servicio Galp",
                address: "CL MANISITU, 9. ALEGRIA-DULANTZI, ÁLAVA",
                lat: 39.557861,
                lng: 2.682333,
                timetable: "L-D: 24h"),
            _content()
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBarWidget(index: 0),
    );
  }

  Container _content() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(vertical: 20),
      color: FullfuelColors.secondary_5,
      width: double.infinity,
      child: Column(
        children: [
          _pricesContainer(),
          _priceEvolutionChart(),
          _bestMomentsCharts()
        ],
      ),
    );
  }

  Container _bestMomentsCharts() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: [_bestDay(6), _bestMoment("nigth")],
      ),
    );
  }

  Container _bestDay(int day) {
    final title = "Mejor día";
    final iconPath = "lib/assets/dayChart/$day.svg";
    const weekDays = [
      "DOMINGO",
      "LUNES",
      "MARTES",
      "MIÉRCOLES",
      "JUEVES",
      "VIERNES",
      "SÁBADO"
    ];
    return _bestContainer(title, iconPath, weekDays[day]);
  }

  Container _bestMoment(String moment) {
    final title = "Mejor momento";
    final iconPath = "lib/assets/momentsChart/$moment.svg";
    String content;
    if (moment == "morning") {
      content = "Mañana";
    } else if (moment == "afternoom") {
      content = "Tarde";
    } else {
      content = "Noche";
    }

    return _bestContainer(title, iconPath, content);
  }

  Container _bestContainer(String title, String iconPath, String content) {
    final titleTextStyles =
        TextStyle(color: FullfuelColors.secondary, fontSize: 12);
    final contentTextStyles = TextStyle(
        color: FullfuelColors.primary,
        fontSize: 22,
        fontWeight: FontWeight.bold);
    return Container(
      width: 165,
      color: Colors.white,
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(), style: titleTextStyles),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: SvgPicture.asset(iconPath,
                alignment: Alignment.center, height: 50),
          ),
          Text(content.toUpperCase(), style: contentTextStyles)
        ],
      ),
    );
  }

  Container _priceEvolutionChart() {
    final title = "Evolución de precios";
    final titleTextStyles =
        TextStyle(color: FullfuelColors.primary, fontSize: 16);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(),
              style: titleTextStyles, textAlign: TextAlign.left),
          Container(
            width: double.infinity,
            height: 220,
            child: LinearChartWidget.withSampleData(),
          )
        ],
      ),
    );
  }

  Row _pricesContainer() {
    return Row(
      children: [
        _priceContainer(fuelName: "Gasoil", price: 1.234, status: "UP"),
        _priceContainer(fuelName: "Gasolina 95", price: 1.234, status: "DOWN"),
        _priceContainer(fuelName: "Gasolina 98", price: 1.234, status: "EQUALS")
      ],
    );
  }

  Container _priceContainer({String fuelName, double price, String status}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Colors.white),
      padding: EdgeInsets.only(top: 14, left: 8, bottom: 14, right: 8),
      margin: EdgeInsets.only(left: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _price(fuelName, price, status),
          _priceEvolution("Mín.", 1.23),
          _priceEvolution("Med.", 1.23),
          _priceEvolution("Max.", 1.23)
        ],
      ),
    );
  }

  Container _priceEvolution(String type, double price) {
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 34,
            child: Text(
              type,
              style: TextStyle(color: FullfuelColors.primary),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 4),
            child: Text(
              "....",
              style: TextStyle(color: FullfuelColors.primary),
            ),
          ),
          Container(
            child: Text(
              "${price.toString()}€",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: FullfuelColors.primary),
            ),
          )
        ],
      ),
    );
  }

  Container _price(String fuelName, double price, String status) {
    final priceTextStyles = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 21,
        color: FullfuelColors.primary);
    final nameTextStyles =
        TextStyle(fontSize: 13, color: FullfuelColors.primary);
    return Container(
      margin: EdgeInsets.only(right: 12, bottom: 6),
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
                    child: _pricesArrow(status),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Icon _pricesArrow(String status) {
    if (status == "DOWN") {
      return Icon(Icons.arrow_downward, size: 28, color: FullfuelColors.down);
    }
    if (status == "UP") {
      return Icon(Icons.arrow_upward, size: 28, color: FullfuelColors.up);
    }
    return Icon(Icons.import_export, size: 28, color: FullfuelColors.secondary);
  }

  Container _headData(
      {String name, String address, double lat, double lng, String timetable}) {
    final _titleTextStyles = TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: FullfuelColors.primary);

    final _addressTextStyles =
        TextStyle(fontSize: 15, color: FullfuelColors.primary);
    return Container(
      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BrandIconWidget(size: "BIG"),
          Expanded(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(name, style: _titleTextStyles),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(address, style: _addressTextStyles),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: _getDistance(lat, lng),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: _isOpen(true, timetable),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _getDistance(double latitude, double longitude) {
    final _distance = Geolocation.getDistance(
      appLatitude,
      appLongitude,
      latitude,
      longitude,
    );
    return Container(
      child: Row(
        children: [
          Icon(Icons.room, size: 18, color: FullfuelColors.secondary),
          Text(
            _distance,
            style: TextStyle(color: FullfuelColors.secondary, fontSize: 15),
          ),
          Container(
            margin: EdgeInsets.only(left: 5),
            child: InkWell(
              child: Text(
                "Google Maps",
                style: TextStyle(
                    color: FullfuelColors.primary,
                    fontSize: 15,
                    decoration: TextDecoration.underline),
              ),
              onTap: () => OpenMaps.open(latitude, longitude),
            ),
          )
        ],
      ),
    );
  }

  Container _isOpen(bool isOpen, String timetable) {
    final isOpenContent = (isOpen) ? "ABIERTA" : "CERRADA";
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 3),
            child: Icon(Icons.watch_later,
                size: 15, color: FullfuelColors.secondary),
          ),
          Text(
            isOpenContent,
            style: TextStyle(color: FullfuelColors.secondary, fontSize: 15),
          ),
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Text(timetable,
                style: TextStyle(color: FullfuelColors.primary, fontSize: 15)),
          )
        ],
      ),
    );
  }
}
