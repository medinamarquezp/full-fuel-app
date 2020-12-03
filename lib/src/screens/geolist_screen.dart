import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';
import 'package:fullfuel_app/src/widgets/app_bar_widget.dart';
import 'package:fullfuel_app/src/widgets/fuelstation_card_widget.dart';
import 'package:fullfuel_app/src/widgets/app_bottom_navigation_bar_widget.dart';
import 'package:fullfuel_app/src/mixins/location_mixim.dart';
import 'package:fullfuel_app/src/entities/fuelstation_list_entity.dart';
import 'package:fullfuel_app/src/repositories/db/fuelstations_db_repo.dart';

class GeolistScreen extends StatefulWidget {
  GeolistScreen({Key key}) : super(key: key);

  @override
  _GeolistScreenState createState() => _GeolistScreenState();
}

class _GeolistScreenState extends State<GeolistScreen> with LocationMixin {
  FuelstationsDBRepo dbRepo;
  List<FuelstationListEntity> fuelstationsList;

  @override
  void initState() {
    super.initState();
  }

  Future<List<FuelstationListEntity>> _getFuelstations() async {
    final box = await Hive.openBox('fuelstations');
    final dbRepo = FuelstationsDBRepo(box);
    return dbRepo.getList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: FullfuelColors.secondary_5,
        appBar: AppBarWidget(),
        body: Column(
          children: [
            _distance(),
            Expanded(
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: FullfuelColors.primary,
                child: _buildList(),
              ),
            ),
          ],
        ),
        bottomNavigationBar: AppBottomNavigationBarWidget(),
      ),
    );
  }

  Widget _buildList() {
    return FutureBuilder(
      future: _getFuelstations(),
      builder: (context, AsyncSnapshot<List<FuelstationListEntity>> snapshot) {
        if (snapshot.hasData) {
          return _fuelstationsList(snapshot.data);
        } else if (snapshot.hasError) {
          // TODO: Catch error
          print("ERROR: ${snapshot.error}");
        }
        return Scaffold();
      },
    );
  }

  ListView _fuelstationsList(List<FuelstationListEntity> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return FuelstationCardWidget(list[index]);
      },
    );
  }

  Row _distance() {
    final label = "15 km.";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ActionChip(
          backgroundColor: FullfuelColors.secondary_20,
          labelStyle: TextStyle(color: FullfuelColors.secondary, fontSize: 16),
          padding: EdgeInsets.all(10),
          avatar: Icon(Icons.room, color: FullfuelColors.secondary, size: 20),
          label: Text(label),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
