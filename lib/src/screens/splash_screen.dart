import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final containerHeigth = MediaQuery.of(context).size.height;
    final containerWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: FullfuelColors.primary,
      body: Container(
        width: containerWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _brandBGTop(containerWidth, containerHeigth),
            _brandLogoCenterWhite(),
            _loadingBottom()
          ],
        ),
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
