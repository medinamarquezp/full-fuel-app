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

  Future<void> saveList(List<FuelstationListEntity> list) async {
    list.forEach((favourite) async =>
        {await _favouriteBox.put(favourite.fuelstationID, favourite)});
  }

  Future<void> clearOnInit() async {
    await _favouriteBox.clear();
  }

  bool isFavourite(int key) {
    return this._favouriteBox.containsKey(key);
  }

  FuelstationListEntity getById(int key) {
    return _favouriteBox.get(key) as FuelstationListEntity;
  }

  Iterable<FuelstationListEntity> getList() {
    final keys = _favouriteBox.keys.toList();
    final list = keys.map((key) => getById(key)).toList();
    list.sort((a, b) => a.distance.compareTo(b.distance));
    return list;
  }
}
