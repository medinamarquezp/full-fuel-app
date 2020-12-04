import 'package:hive/hive.dart';
import 'package:fullfuel_app/src/entities/fuelstation_list_entity.dart';

class FavouritesDBRepo {
  Box _favouriteBox;

  FavouritesDBRepo(this._favouriteBox);

  Future<void> toggleFavourite(
      int key, FuelstationListEntity fuelstation) async {
    await toggle(key, fuelstation);
  }

  Future<void> toggle(int key, FuelstationListEntity fuelstation) async {
    if (isFavourite(key)) {
      await _favouriteBox.delete(key);
    } else {
      await _favouriteBox.put(key, fuelstation);
    }
  }

  bool isFavourite(int key) {
    return this._favouriteBox.containsKey(key);
  }
}
