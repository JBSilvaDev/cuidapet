import '../local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceLocalStorageImpl implements LocalStorage {
  Future<SharedPreferences> get _intance => SharedPreferences.getInstance();

  @override
  Future<void> clear<V>() async {
    final sharedPreferences = await _intance;
    sharedPreferences.clear();
  }

  @override
  Future<void> contains<V>(String key) async {
    final sharedPreferences = await _intance;
    sharedPreferences.containsKey(key);
  }

  @override
  Future<V?> read<V>(String key) async {
    final sharedPreferences = await _intance;
    return sharedPreferences.get(key) as V?;
  }

  @override
  Future<void> remove<V>(String key) async {
    final sharedPreferences = await _intance;
    sharedPreferences.remove(key);
  }

  @override
  Future<void> write<V>(String key, V value) async {
    final sharedPreferences = await _intance;
    switch (V) {
      case String:
        await sharedPreferences.setString(key, value as String);
      case int:
        await sharedPreferences.setInt(key, value as int);
      case bool:
        await sharedPreferences.setBool(key, value as bool);
      case double:
        await sharedPreferences.setDouble(key, value as double);
      case List:
        await sharedPreferences.setStringList(key, value as List<String>);
      default:
        throw Exception('Tipo nao suportado');
    }
  }
}
