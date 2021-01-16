import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fullfuel_app/src/widgets/safe_scaffold_widget.dart';
import 'package:fullfuel_app/src/widgets/icon_message_widget.dart';
import 'package:fullfuel_app/src/widgets/fuelstation_card_widget.dart';
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
    return SafeScaffoldWidget(
      pageTitle: "Mis gasolineras favoritas",
      page: _buildList(),
      pageIndex: 1,
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
          return IconMessageWidget(
            iconPath: "lib/assets/favouritesDashed.svg",
            title: "NO TIENES GASOLINERAS FAVORITAS",
          );
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
}
