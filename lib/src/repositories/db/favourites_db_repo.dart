import 'package:hive/hive.dart';

class FavouritesDBRepo {
  Box _favouriteBox;

  FavouritesDBRepo(this._favouriteBox);

  Future<void> toggleFavourite(int key, String value) async {
    await toggle(key, value);
  }

  Future<void> toggle(int key, String value) async {
    if (isFavourite(key)) {
      await _favouriteBox.delete(key);
    } else {
      await _favouriteBox.put(key, value);
    }
  }

  bool isFavourite(int key) {
    return this._favouriteBox.containsKey(key);
  }
}
