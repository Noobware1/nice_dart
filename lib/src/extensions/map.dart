import 'dart:convert';

import 'package:nice_dart/src/extensions/scopes.dart';

extension MapGet<K, V> on Map<K, V> {
  V? get(K key) => this[key];
}

extension MapGetOrElse<K, V> on Map<K, V> {
  V getOrElse(K key, V Function(K key) orElse) => this[key] ?? orElse(key);
}

extension MapGetOrDefault<K, V> on Map<K, V> {
  V getOrDefault(K key, V defaultValue) => this[key] ?? defaultValue;
}

extension MapAdd<K, V> on Map<K, V> {
  Map add(K key, V value) => apply((it) {
        it[key] = value;
      });
}

extension MapForEachIndexed<K, V> on Map<K, V> {
  void forEachIndexed(void Function(int index, K key, V value) action) {
    var index = 0;
    return forEach((key, value) {
      action(index++, key, value);
    });
  }
}

extension MapFlatMap<K, V> on Map<K, V> {
  List<R> flatMap<R>(R Function(K key, V value) transform) =>
      [for (var entry in entries) transform(entry.key, entry.value)];
}

extension MapToJson<K, V> on Map<K, V> {
  String toJson() => jsonEncode(this);
}

extension MapOrEmpty<K, V> on Map<K, V>? {
  Map<K, V> orEmpty() {
    return this ?? {};
  }
}

extension MapIsEmptyOrNull<K, V> on Map<K, V>? {
  bool get isEmptyOrNull => this == null || this!.isEmpty;
}

extension MapIsNotEmptyOrNull<K, V> on Map<K, V>? {
  bool get isNotEmptyOrNull => this != null && this!.isNotEmpty;
}
