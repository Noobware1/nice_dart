extension MapExtensions<K, V> on Map<K, V> {
  V? get(K key) => this[key];

  V getOrDefault(K key, V defaultValue) => this[key] ?? defaultValue;

  bool equals(dynamic other) => this == other;

  void forEachIndexed(void Function(int index, K key, V value) action) {
    var index = 0;
    return forEach((key, value) {
      action(index++, key, value);
    });
  }
}
