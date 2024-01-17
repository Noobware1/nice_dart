import 'dart:collection';

import 'package:dartx/src/extensions/iterable.dart';

extension MapExtensions<K, V> on Map<K, V> {
  V? get(K key) => this[key];

  V getOrDefault(K key, V defaultValue) => this[key] ?? defaultValue;

  void forEachIndexed(void Function(int index, K key, V value) action) {
    var index = 0;
    return forEach((key, value) {
      action(index++, key, value);
    });
  }
}

extension OrEmptyMap<K, V> on Map<K, V>? {
  Map<K, V> orEmpty() {
    return this ?? {};
  }
}
