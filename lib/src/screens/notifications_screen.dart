import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';
import 'package:fullfuel_app/src/screens/notifications_no_favourites_screen.dart';
import 'package:fullfuel_app/src/widgets/icon_message_widget.dart';
import 'package:fullfuel_app/src/widgets/safe_scaffold_widget.dart';
import 'package:fullfuel_app/src/widgets/notifications_card_widget.dart';
import 'package:fullfuel_app/src/entities/fuelstation_list_entity.dart';
import 'package:fullfuel_app/src/repositories/db/favourites_db_repo.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({Key key}) : super(key: key);

  @override
  _NotificationsScreen createState() => _NotificationsScreen();
}

class _NotificationsScreen extends State<NotificationsScreen> {
  final favouritesBox = Hive.box<FuelstationListEntity>('favourites');
  final notificationsBox = Hive.box('notifications');
  List<FuelstationListEntity> _favouritesList;
  List<dynamic> _notificationsList;

  @override
  void initState() {
    super.initState();
    _favouritesList = _getFavouritesList();
  }

  List<FuelstationListEntity> _getFavouritesList() {
    FavouritesDBRepo favouritesRepo = FavouritesDBRepo(favouritesBox);
    return favouritesRepo.getList().toList();
  }

  List<dynamic> _getNotificationsList() {
    var notificationsList = [];
    final keys = notificationsBox.keys.toList();
    for (var key in keys) {
      var fuelType = notificationsBox.get(key);
      var favourite = favouritesBox.get(key);
      notificationsList.add({
        'fuelstationID': key,
        'fuelstationName': favourite.name,
        'fuelType': fuelType
      });
    }
    return notificationsList;
  }

  @override
  Widget build(BuildContext context) {
    if (_favouritesList.isEmpty) {
      return NotificationsNoFavouritesScreen();
    }
    return _notificationsPage();
  }

  SafeScaffoldWidget _notificationsPage() {
    return SafeScaffoldWidget(
      pageTitle: "Mis notificaciones",
      page: _buildList(),
      pageIndex: 2,
      floatingButton: _actionButton(context),
    );
  }

  ValueListenableBuilder _buildList() {
    return ValueListenableBuilder(
      valueListenable: notificationsBox.listenable(),
      builder: (context, notificationsBox, _) {
        if (notificationsBox.values.isEmpty && _favouritesList.isNotEmpty) {
          return IconMessageWidget(
            iconPath: "lib/assets/noNotificationsDashed.svg",
            title: "AÚN NO HAS CONFIGURADO ALERTAS",
          );
        } else {
          return ListView.builder(
            itemCount: notificationsBox.values.length,
            itemBuilder: (context, index) {
              _notificationsList = _getNotificationsList();
              final notification = _notificationsList[index];
              return NotificationsCardWidget(notification['fuelstationID'],
                  notification['fuelstationName'], notification['fuelType']);
            },
          );
        }
      },
    );
  }

  FloatingActionButton _actionButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: "newNotification",
      onPressed: () => {
        Navigator.pushNamed(context, 'notificationsForm',
            arguments: {'isCreating': true})
      },
      child: Icon(Icons.add, size: 40, color: FullfuelColors.action),
      backgroundColor: Colors.white,
    );
  }
}
