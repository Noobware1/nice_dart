String buildString(void Function(StringBuffer it) action) {
  final it = StringBuffer();
  action(it);
  return it.toString();
}

List<E> buildList<E>(void Function(List<E> it) action) {
  final it = <E>[];
  action(it);
  return List.unmodifiable(it);
}

Set<E> buildSet<E>(void Function(Set<E> it) action) {
  final it = <E>{};
  action(it);
  return Set.unmodifiable(it);
}

Map<K, V> buildMap<K, V>(void Function(Map<K, V> it) action) {
  final it = <K, V>{};
  action(it);
  return Map.unmodifiable(it);
}
