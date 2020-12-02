import 'package:hive/hive.dart';
import 'package:fullfuel_app/src/entities/fuelstation_list_entity.dart';

class FuelstationsDBRepo {
  Box _fuelstationsBox;

  FuelstationsDBRepo(this._fuelstationsBox);

  Future<void> saveList(List<FuelstationListEntity> list) async {
    list.forEach((fuelstation) async =>
        await _fuelstationsBox.putAt(fuelstation.fuelstationID, fuelstation));
  }

  FuelstationListEntity getById(int key) {
    return _fuelstationsBox.get(key) as FuelstationListEntity;
  }

  Iterable<FuelstationListEntity> getList() {
    final keys = _fuelstationsBox.keys.toList();
    final list = keys.map((key) => getById(key)).toList();
    return list;
  }
}
