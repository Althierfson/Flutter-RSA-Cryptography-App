import 'package:crypto/models/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveKeys {
  SharedPreferences shared;

  SaveKeys({required this.shared});

  final String _listKeys = "_listKeys";

  List<Keys> getKeys() {
    final list = shared.getStringList(_listKeys) ?? [];
    return List.from(list.map((e) => Keys.fromJson(e)));
  }

  void saveKeys(List<Keys> keys) {
    shared.setStringList(_listKeys, List.from(keys.map((e) => e.toJson())));
  }
}
