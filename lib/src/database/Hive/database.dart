import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fullfuel_app/src/entities/fuel_price_entity.dart';
import 'package:fullfuel_app/src/entities/fuelstation_list_entity.dart';

class Database {
  static init() async {
    final appRootDir = await getApplicationDocumentsDirectory();
    Hive
      ..init(appRootDir.path)
      ..registerAdapter(FuelstationListEntityAdapter())
      ..registerAdapter(FuelPriceEntityAdapter());
    await Hive.openBox<FuelstationListEntity>('fuelstations');
    await Hive.openBox<FuelstationListEntity>('favourites');
    await Hive.openBox('config');
  }
}
