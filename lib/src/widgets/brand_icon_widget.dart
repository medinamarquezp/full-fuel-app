import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';

class BrandIconWidget extends StatelessWidget {
  final String brandLogo;
  final String size;

  const BrandIconWidget({Key key, this.brandLogo = "", this.size = "SMALL"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _radius = (size == "BIG") ? 30.0 : 22.0;
    final _iconSize = (size == "BIG") ? 24.0 : 18.0;
    final _apiURL = DotEnv().env['API_URL'];
    final fuelStationIcon = "lib/assets/gasStationIcon.svg";
    final noBrandIcon = CircleAvatar(
      radius: _radius,
      backgroundColor: FullfuelColors.secondary_20,
      child: SvgPicture.asset(fuelStationIcon,
          alignment: Alignment.center, width: _iconSize),
    );
    final brandIcon = (brandLogo == "")
        ? noBrandIcon
        : CircleAvatar(
            radius: _radius,
            backgroundImage: NetworkImage(_apiURL + brandLogo),
            backgroundColor: Colors.transparent);
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: brandIcon,
    );
  }
}
