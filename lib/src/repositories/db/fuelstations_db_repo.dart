import 'package:hive/hive.dart';
import 'package:fullfuel_app/src/entities/fuelstation_list_entity.dart';

class FuelstationsDBRepo {
  Box _fuelstationsBox;

  FuelstationsDBRepo(this._fuelstationsBox);

  Future<void> saveList(List<FuelstationListEntity> list) async {
    list.forEach((fuelstation) async =>
        {await upsert(fuelstation.fuelstationID, fuelstation)});
  }

  Future<void> clearOnInit() async {
    await _fuelstationsBox.clear();
  }

  Future<void> upsert(int key, FuelstationListEntity fuelstation) async {
    if (this._fuelstationsBox.containsKey(key)) {
      await _fuelstationsBox.putAt(key, fuelstation);
    } else {
      await _fuelstationsBox.put(key, fuelstation);
    }
  }

  FuelstationListEntity getById(int key) {
    return _fuelstationsBox.get(key) as FuelstationListEntity;
  }

  Iterable<FuelstationListEntity> getList() {
    final keys = _fuelstationsBox.keys.toList();
    final list = keys.map((key) => getById(key)).toList();
    list.sort((a, b) => a.distance.compareTo(b.distance));
    return list;
  }
}
