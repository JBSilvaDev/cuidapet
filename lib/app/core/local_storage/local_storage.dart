abstract interface class LocalStorage {
  Future<V?> read <V>(String key);
  Future<void>write<V>(String key, V value);
  Future<void>contains<V>(String key);
  Future<void>clear<V>();
  Future<void>remove<V>(String key);

}

abstract interface class LocalSecureStorage {

}