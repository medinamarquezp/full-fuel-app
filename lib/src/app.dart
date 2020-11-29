import 'package:flutter/material.dart';
import 'package:fullfuel_app/src/routes/app_routes.dart';
import 'package:fullfuel_app/src/services/connection_status.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fullfuel',
      debugShowCheckedModeBanner: false,
      initialRoute: "geolist",
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
      navigatorKey.currentState.pushNamed("geolist");
    }
  }
}
