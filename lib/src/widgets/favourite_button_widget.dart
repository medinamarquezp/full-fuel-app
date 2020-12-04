import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';
import 'package:fullfuel_app/src/repositories/db/favourites_db_repo.dart';

class FavouriteButtonWidget extends StatefulWidget {
  final id;
  final name;
  FavouriteButtonWidget({Key key, this.id, this.name}) : super(key: key);

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
    final box = await Hive.openBox('favourites');
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
      _toggleFavourite(widget.id, widget.name);
      isFavourite = !isFavourite;
      buttonBackgroundColor = (isFavourite) ? action : white;
      iconColor = (isFavourite) ? white : action;
    });
  }

  _toggleFavourite(int id, String name) async {
    await favouritesDBRepo.toggleFavourite(id, name);
  }
}
