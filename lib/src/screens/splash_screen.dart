import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';
import 'package:fullfuel_app/src/mixins/location_mixim.dart';
import 'package:fullfuel_app/src/repositories/db/fuelstations_db_repo.dart';
import 'package:fullfuel_app/src/repositories/remote/fuelstations_remote_repo.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with LocationMixin {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> _fetchData() async {
    final remoteRepo = FuelstationsRemoteRepo(latitude, longitude);
    final fuelstations = await remoteRepo.fetchFuelstationsListGeo();
    final box = await Hive.openBox('fuelstations');
    final dbRepo = FuelstationsDBRepo(box);
    await dbRepo.saveList(fuelstations);
    return true;
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
                Navigator.of(context).pushReplacementNamed("geolist");
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
        backgroundColor: Colors.white,
        valueColor: new AlwaysStoppedAnimation<Color>(FullfuelColors.primary),
      ),
    );
  }
}
