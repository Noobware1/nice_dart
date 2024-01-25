import 'dart:convert';

import 'package:dartx/dartx.dart';

extension MapExtensions<K, V> on Map<K, V> {
  V? get(K key) => this[key];

  Map add(K key, V value) => apply((it) {
        it[key] = value;
      });

  V getOrDefault(K key, V defaultValue) => this[key] ?? defaultValue;

  void forEachIndexed(void Function(int index, K key, V value) action) {
    var index = 0;
    return forEach((key, value) {
      action(index++, key, value);
    });
  }

  String toJson() => jsonEncode(this);
}

extension OrEmptyMap<K, V> on Map<K, V>? {
  Map<K, V> orEmpty() {
    return this ?? {};
  }
}
