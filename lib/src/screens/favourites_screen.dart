import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';
import 'package:fullfuel_app/src/widgets/app_bar_widget.dart';
import 'package:fullfuel_app/src/widgets/fuelstation_card_widget.dart';
import 'package:fullfuel_app/src/widgets/app_bottom_navigation_bar_widget.dart';
import 'package:fullfuel_app/src/entities/fuelstation_list_entity.dart';
import 'package:fullfuel_app/src/repositories/db/favourites_db_repo.dart';

class FavouritesScreen extends StatefulWidget {
  FavouritesScreen({Key key}) : super(key: key);

  @override
  _FavouritesScreen createState() => _FavouritesScreen();
}

class _FavouritesScreen extends State<FavouritesScreen> {
  final configBox = Hive.box('config');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: FullfuelColors.secondary_5,
        appBar: AppBarWidget(),
        body: Column(
          children: [
            _favouritesTitle(),
            Expanded(
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: FullfuelColors.primary,
                child: _buildList(),
              ),
            ),
          ],
        ),
        bottomNavigationBar: AppBottomNavigationBarWidget(index: 1),
      ),
    );
  }

  ValueListenableBuilder _buildList() {
    final latitude = configBox.get('latitude');
    final longitude = configBox.get('longitude');
    return ValueListenableBuilder(
      valueListenable:
          Hive.box<FuelstationListEntity>('favourites').listenable(),
      builder: (context, box, _) {
        if (box.values.isEmpty) {
          return _noFavourites();
        } else {
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              FavouritesDBRepo favouritesRepo = FavouritesDBRepo(box);
              final orderedList = favouritesRepo.getList().toList();
              final fuelstation = orderedList[index];
              return FuelstationCardWidget(fuelstation, latitude, longitude);
            },
          );
        }
      },
    );
  }

  Container _favouritesTitle() {
    final content = "Mis gasolineras favoritas";
    final styles = TextStyle(color: FullfuelColors.primary, fontSize: 16);
    return Container(
      margin: EdgeInsets.only(top: 30, left: 20),
      width: double.infinity,
      child:
          Text(content.toUpperCase(), style: styles, textAlign: TextAlign.left),
    );
  }

  Column _noFavourites() {
    return Column(children: [_favouritesDashed(), _noFavouritesTitle()]);
  }

  Container _favouritesDashed() {
    final favouritesDashed = "lib/assets/favouritesDashed.svg";
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 40, bottom: 20),
      child: SvgPicture.asset(favouritesDashed,
          alignment: Alignment.center, width: 220),
    );
  }

  Container _noFavouritesTitle() {
    final content = "NO TIENES GASOLINERAS FAVORITAS";
    final styles = TextStyle(
        color: FullfuelColors.primary,
        fontWeight: FontWeight.bold,
        fontSize: 16);
    return Container(
      child: Text(content, style: styles, textAlign: TextAlign.center),
    );
  }
}
