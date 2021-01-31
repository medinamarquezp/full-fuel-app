import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter/services.dart';
import 'package:fullfuel_app/src/widgets/dialog_widget.dart';
import 'package:fullfuel_app/src/routes/app_routes.dart';
import 'package:fullfuel_app/src/services/connection_status.dart';
import 'package:fullfuel_app/src/services/geolocation.dart';
import 'package:fullfuel_app/src/services/push_notifications.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    notificationsHandler();
    return MaterialApp(
      title: 'Fullfuel',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: getAppRoutes(),
      navigatorKey: navigatorKey,
    );
  }

  @override
  initState() {
    super.initState();
    ConnectionStatus connectionStatus = ConnectionStatus.getInstance();
    connectionStatus.initialize();
    connectionStatus.connectionChange.listen(connectionChanged);
  }

  void connectionChanged(dynamic hasConnection) {
    if (!hasConnection) {
      navigatorKey.currentState.pushNamed("networkError");
    } else {
      navigatorKey.currentState.pushNamed("/");
    }
  }

  void notificationsHandler() {
    final pushNotifications = new PushNotifications();
    pushNotifications.initNotifications();
    pushNotifications.streamMessages.listen((data) {
      final action = data["action"];
      final fuelstationID =
          int.parse(data["data"]["topic"].toString().split("-")[0]);
      final title = data["data"]["title"];
      final message = data["data"]["message"];

      if (action == "onMessage") {
        return dialogWidget(
          context: navigatorKey.currentState.overlay.context,
          title: title,
          content: message,
          actionLabel: "Muéstramelo",
          action: _goToFuelstationDetail,
          actionParam: fuelstationID,
        );
      } else {
        _goToFuelstationDetail(fuelstationID);
      }
    });
  }

  void _goToFuelstationDetail(int fuelstationID) async {
    final location = await _getLocation();
    navigatorKey.currentState.pushNamed('detail', arguments: {
      'appLatitude': location.latitude,
      'appLongitude': location.longitude,
      'fuelstationID': fuelstationID
    });
  }

  Future<Geolocation> _getLocation() async {
    final configBox = Hive.box('config');
    Geolocation currentLocation = await Geolocation.getCurrentLocation();
    await configBox.putAll({
      'latitude': currentLocation.latitude,
      'longitude': currentLocation.longitude
    });
    return currentLocation;
  }
}
