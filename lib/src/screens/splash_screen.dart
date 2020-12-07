import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';
import 'package:fullfuel_app/src/services/geolocation.dart';
import 'package:fullfuel_app/src/entities/fuelstation_list_entity.dart';
import 'package:fullfuel_app/src/repositories/db/favourites_db_repo.dart';
import 'package:fullfuel_app/src/repositories/db/fuelstations_db_repo.dart';
import 'package:fullfuel_app/src/repositories/remote/fuelstations_remote_repo.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> _fetchData() async {
    final fuelstations = await _getRemoteFuelstations();
    final favourites = await _getRemoteFavourites();
    await _cacheFuelstations(fuelstations);
    await _cacheFavourites(favourites);
    return true;
  }

  Future<FuelstationsRemoteRepo> _initRemote() async {
    Geolocation currentLocation = await _getLocation();
    return FuelstationsRemoteRepo(
        currentLocation.latitude, currentLocation.longitude);
  }

  Future<Geolocation> _getLocation() async {
    Geolocation currentLocation = await Geolocation.getCurrentLocation();
    final configBox = Hive.box('config');
    await configBox.putAll({
      'latitude': currentLocation.latitude,
      'longitude': currentLocation.longitude
    });
    return currentLocation;
  }

  Future<List<FuelstationListEntity>> _getRemoteFuelstations() async {
    FuelstationsRemoteRepo remote = await _initRemote();
    final fuelstations = await remote.fetchFuelstationsListGeo();
    return fuelstations;
  }

  Future<List<FuelstationListEntity>> _getRemoteFavourites() async {
    FuelstationsRemoteRepo remote = await _initRemote();
    final favouritesBox = Hive.box<FuelstationListEntity>('favourites');
    final favouritesIDs = favouritesBox.keys.toList();
    final favourites =
        await remote.fetchFuelstationsListIDs(listIDs: favouritesIDs);
    return favourites;
  }

  Future<void> _cacheFuelstations(
      List<FuelstationListEntity> fuelstations) async {
    final fuelstationsBox = Hive.box<FuelstationListEntity>('fuelstations');
    final dbRepo = FuelstationsDBRepo(fuelstationsBox);
    await dbRepo.clearOnInit();
    await dbRepo.saveList(fuelstations);
  }

  Future<void> _cacheFavourites(List<FuelstationListEntity> favourites) async {
    final favouritesBox = Hive.box<FuelstationListEntity>('favourites');
    FavouritesDBRepo favouritesDBRepo = FavouritesDBRepo(favouritesBox);
    await favouritesDBRepo.clearOnInit();
    await favouritesDBRepo.saveList(favourites);
  }

  @override
  Widget build(BuildContext context) {
    final containerHeight = MediaQuery.of(context).size.height;
    final containerWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: FullfuelColors.primary,
      body: FutureBuilder(
        future: _fetchData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            Future.delayed(
              Duration.zero,
              () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("geolist", (route) => false);
              },
            );
          } else if (snapshot.hasError) {
            // TODO: Catch error
            print(snapshot.error);
          }
          return _appContainer(containerWidth, containerHeight);
        },
      ),
    );
  }

  Container _appContainer(double containerWidth, double containerHeight) {
    return Container(
      width: containerWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _brandBGTop(containerWidth, containerHeight),
          _brandLogoCenterWhite(),
          _loadingBottom()
        ],
      ),
    );
  }

  SvgPicture _brandBGTop(double containerWidth, double containerHeight) {
    final brandBGTop = "lib/assets/brandBGTop.svg";
    return SvgPicture.asset(brandBGTop,
        alignment: Alignment.topCenter,
        width: containerWidth,
        height: containerHeight);
  }

  Container _brandLogoCenterWhite() {
    final logoWhite = "lib/assets/brandWhite.svg";
    return Container(
      child:
          SvgPicture.asset(logoWhite, alignment: Alignment.center, width: 80),
    );
  }

  Positioned _loadingBottom() {
    return Positioned(
      bottom: 60,
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}
