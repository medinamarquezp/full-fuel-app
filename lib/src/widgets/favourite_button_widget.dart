import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';
import 'package:fullfuel_app/src/widgets/dialog_widget.dart';
import 'package:fullfuel_app/src/entities/fuelstation_list_entity.dart';
import 'package:fullfuel_app/src/repositories/db/favourites_db_repo.dart';
import 'package:fullfuel_app/src/repositories/remote/subscriptions_remote_repo.dart';

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
  final favouritesBox = Hive.box<FuelstationListEntity>('favourites');
  final notificationsBox = Hive.box('notifications');
  FavouritesDBRepo favouritesDBRepo;
  Color buttonBackgroundColor;
  Color iconColor;
  bool isFavourite;

  @override
  FloatingActionButton build(BuildContext context) {
    favouritesDBRepo = FavouritesDBRepo(favouritesBox);
    isFavourite = favouritesDBRepo.isFavourite(widget.id);
    buttonBackgroundColor = (isFavourite) ? action : white;
    iconColor = (isFavourite) ? white : action;
    return FloatingActionButton(
      heroTag: null,
      backgroundColor: buttonBackgroundColor,
      onPressed: () => _toggleState(context),
      child: Icon(Icons.favorite, size: 30, color: iconColor),
    );
  }

  _toggleState(BuildContext context) {
    setState(() {
      isFavourite = !isFavourite;
      _toggleFavourite(context, widget.id, widget.fuelstation);
      buttonBackgroundColor = (isFavourite) ? action : white;
      iconColor = (isFavourite) ? white : action;
    });
  }

  _toggleFavourite(
      BuildContext context, int id, FuelstationListEntity fuelstation) async {
    if (!isFavourite && notificationsBox.containsKey(id)) {
      dialogWidget(
          context: context,
          title: "¡Cuidado!",
          content:
              "Actualmente dispones de notificaciones activas para la gasolinera ${fuelstation.name}. Si la eliminas de favoritos, también eliminarás sus notificaciones ¿Quieres eliminar la gasolinera de favoritos y sus notificaciones?",
          actionLabel: "Eliminar",
          action: _deleteNotification,
          actionParam: id);
      return;
    }
    await favouritesDBRepo.toggleFavourite(id, fuelstation);
  }

  Future<void> _deleteNotification(int fuelstationID) async {
    final fuelType = notificationsBox.get(fuelstationID);
    final subscriptionRepo = new SubscriptionsRemoteRepo();
    await subscriptionRepo.unsubscribe(
        fuelstationID: fuelstationID, fuelType: fuelType);
    await notificationsBox.delete(fuelstationID);
    final fuelstation = favouritesBox.get(fuelstationID);
    await favouritesDBRepo.toggleFavourite(fuelstationID, fuelstation);
  }
}
