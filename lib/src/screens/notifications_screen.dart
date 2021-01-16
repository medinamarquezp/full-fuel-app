import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:fullfuel_app/src/widgets/safe_scaffold_widget.dart';
import 'package:fullfuel_app/src/screens/notifications_empty_screen.dart';
import 'package:fullfuel_app/src/screens/notifications_no_favourites_screen.dart';
import 'package:fullfuel_app/src/widgets/favourites_card_widget.dart';
import 'package:fullfuel_app/src/entities/fuelstation_list_entity.dart';
import 'package:fullfuel_app/src/repositories/db/favourites_db_repo.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({Key key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final favouritesBox = Hive.box<FuelstationListEntity>('favourites');
  final notificationsBox = Hive.box('notifications');
  List<FuelstationListEntity> _favouritesList;
  List<dynamic> _notificationsList;

  @override
  void initState() {
    super.initState();
    _favouritesList = _getFavouritesList();
    _notificationsList = List.empty();
  }

  List<FuelstationListEntity> _getFavouritesList() {
    FavouritesDBRepo favouritesRepo = FavouritesDBRepo(favouritesBox);
    return favouritesRepo.getList().toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_favouritesList.isEmpty) {
      return NotificationsNoFavouritesScreen();
    }
    if (_favouritesList.isNotEmpty && _notificationsList.isEmpty) {
      return NotificationsEmptyScreen();
    }
    return _notificationsPage();
  }

  SafeScaffoldWidget _notificationsPage() {
    return SafeScaffoldWidget(
      pageTitle: "Mis alertas",
      page: _notifications(),
      pageIndex: 2,
    );
  }

  Column _notifications() {
    return Column(
      children: [FavouritesCardWidget("PREMIRA ENERGIA NORTE, S.L.", "Gasoil")],
    );
  }
}
