String buildString(void Function(StringBuffer it) action) {
  final it = StringBuffer();
  action(it);
  return it.toString();
}

List<E> buildList<E>(void Function(List<E> it) action,
    {bool unmodifiable = true}) {
  final it = <E>[];
  action(it);
  return unmodifiable ? List.unmodifiable(it) : it;
}

Set<E> buildSet<E>(void Function(Set<E> it) action,
    {bool unmodifiable = true}) {
  final it = <E>{};
  action(it);
  return unmodifiable ? Set.unmodifiable(it) : it;
}

Map<K, V> buildMap<K, V>(void Function(Map<K, V> it) action,
    {bool unmodifiable = true}) {
  final it = <K, V>{};
  action(it);
  return unmodifiable ? Map.unmodifiable(it) : it;
}
