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
      body: Column(
        children: [
          _brandBGTop(containerWidth),
          _brandLogoCenterWhite(containerHeigth, containerWidth),
          _loadingBottom()
        ],
      ),
    );
  }

  Container _brandBGTop(double containerWidth) {
    final brandBGTop = "lib/assets/brandBGTop.svg";
    return Container(
      child: SvgPicture.asset(brandBGTop,
          alignment: Alignment.center, width: containerWidth),
    );
  }

  Container _brandLogoCenterWhite(
      double containerHeight, double containerWidth) {
    final logoWhite = "lib/assets/brandWhite.svg";
    return Container(
      margin: EdgeInsets.only(top: containerHeight * .15),
      child: SvgPicture.asset(logoWhite,
          alignment: Alignment.center, width: containerWidth * .25),
    );
  }

  Expanded _loadingBottom() {
    return Expanded(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 80),
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            valueColor:
                new AlwaysStoppedAnimation<Color>(FullfuelColors.primary),
          ),
        )
      ],
    ));
  }
}
