import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';

class NetworkErrorScreen extends StatelessWidget {
  const NetworkErrorScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final containerWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: FullfuelColors.primary,
      body: SafeArea(
        child: Column(children: [
          _brandLogoWhite(containerWidth),
          _networkErrorIcon(containerWidth),
          _networkErrorTitle(),
          _networkErrorContent(containerWidth),
          _brandBGBottom(containerWidth)
        ]),
      ),
    );
  }

  Container _brandLogoWhite(double containerWidth) {
    final logoWhite = "lib/assets/brandWhite.svg";
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 60),
      child: SvgPicture.asset(logoWhite,
          alignment: Alignment.center, width: containerWidth * .15),
    );
  }

  Container _networkErrorIcon(double containerWidth) {
    final netOffIcon = "lib/assets/netOff.svg";
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 25, bottom: 20),
        child: SvgPicture.asset(netOffIcon,
            alignment: Alignment.center, width: containerWidth * .5));
  }

  Container _networkErrorTitle() {
    final content = "SIN CONEXIÓN A LA RED";
    final styles = TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20);
    return Container(child: Text(content, style: styles));
  }

  Container _networkErrorContent(double containerWidth) {
    final content =
        "Debes disponer de conexión a la red para utilizar esta aplicación. Comprueba que la conexión de datos móviles o red wifi están habilitados y disponibles.";
    final styles = TextStyle(color: FullfuelColors.secondary_30, fontSize: 18);
    return Container(
        margin: EdgeInsets.only(top: 10),
        width: containerWidth * .85,
        child: Text(
          content,
          textAlign: TextAlign.center,
          style: styles,
        ));
  }

  Expanded _brandBGBottom(double containerWidth) {
    final brandBGBottom = "lib/assets/brandBGBottom.svg";
    return Expanded(
      child: SvgPicture.asset(brandBGBottom,
          alignment: Alignment.bottomCenter, width: containerWidth),
    );
  }
}
