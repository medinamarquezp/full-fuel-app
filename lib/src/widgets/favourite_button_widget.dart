import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';
import 'package:fullfuel_app/src/entities/fuelstation_list_entity.dart';
import 'package:fullfuel_app/src/repositories/db/favourites_db_repo.dart';

class FavouriteButtonWidget extends StatefulWidget {
  final id;
  final fuelstation;
  FavouriteButtonWidget({Key key, this.id, this.fuelstation}) : super(key: key);

  @override
  _FavouriteButtonWidget createState() => _FavouriteButtonWidget();
}

class _FavouriteButtonWidget extends State<FavouriteButtonWidget> {
  final Color action = FullfuelColors.action;
  final Color white = Colors.white;
  FavouritesDBRepo favouritesDBRepo;
  Color buttonBackgroundColor;
  Color iconColor;
  bool isFavourite;

  @override
  void initState() {
    super.initState();
    buttonBackgroundColor = white;
    _init();
  }

  _init() async {
    final box = await Hive.openBox<FuelstationListEntity>('favourites');
    favouritesDBRepo = FavouritesDBRepo(box);
    isFavourite = favouritesDBRepo.isFavourite(widget.id);
    setState(() {
      buttonBackgroundColor = (isFavourite) ? action : white;
      iconColor = (isFavourite) ? white : action;
    });
  }

  @override
  FloatingActionButton build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      backgroundColor: buttonBackgroundColor,
      onPressed: () => _toggleState(),
      child: Icon(Icons.favorite, size: 30, color: iconColor),
    );
  }

  _toggleState() {
    setState(() {
      _toggleFavourite(widget.id, widget.fuelstation);
      isFavourite = !isFavourite;
      buttonBackgroundColor = (isFavourite) ? action : white;
      iconColor = (isFavourite) ? white : action;
    });
  }

  _toggleFavourite(int id, FuelstationListEntity fuelstation) async {
    await favouritesDBRepo.toggleFavourite(id, fuelstation);
  }
}