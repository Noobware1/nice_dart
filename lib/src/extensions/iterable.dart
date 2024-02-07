import 'package:nice_dart/src/binary_search.dart' as bin;

extension IterableBinarySearch<T extends Comparable<T>> on List<T> {
  int binarySearch(T targetKey) {
    return bin.binarySearch(this, targetKey);
  }
}

extension IterableOrEmpty<E> on Iterable<E>? {
  Iterable<E> orEmpty() {
    return this ?? Iterable.empty();
  }
}

extension IterableFlatten<E> on Iterable<Iterable<E>> {
  Iterable<E> flatten() sync* {
    for (final list in this) {
      yield* list;
    }
  }
}

extension IterableFlatMap<E> on Iterable<Iterable<E>> {
  List<R> flatMap<R>(R Function(E it) transform) => [
        for (final list in this)
          for (var it in list) transform(it)
      ];
}

extension IterableMapNotNull<E> on Iterable<E?> {
  Iterable<R> mapNotNull<R>(R Function(E it) transform) sync* {
    for (final element in this) {
      if (element != null) {
        yield transform(element);
      }
    }
  }
}

extension IterableMapNotNullIndexed<E> on Iterable<E?> {
  Iterable<R> mapNotNullIndexed<R>(
      R Function(int index, E it) transform) sync* {
    for (var index = 0; index < length; index++) {
      final element = elementAt(index);
      if (element != null) {
        yield transform(index, element);
      }
    }
  }
}

extension IterableMapList<E> on Iterable<E> {
  /// slower than map but faster then calling .toList() on the mapped iterable
  List<T> mapList<T>(T Function(E e) toElement) =>
      [for (final e in this) toElement(e)];
}

extension IterableMapListIndexed<E> on Iterable<E> {
  List<T> mapListIndexed<T>(T Function(int index, E e) toElement) {
    final l = <T>[];
    for (var i = 0; i < length; i++) {
      l.add(toElement(i, elementAt(i)));
    }
    return l;
  }
}

extension IterableGet<E> on Iterable<E> {
  E get(int index) => this is List ? (this as List)[index] : elementAt(index);
}

extension IterableGetOrNull<E> on Iterable<E> {
  E? getOrNull(int index) => index < length ? get(index) : null;
}

extension IterableGetOrElse<E> on Iterable<E> {
  E getOrElse(int index, E Function(int index) defaultValue) =>
      (index >= 0 && index <= lastIndex) ? get(index) : defaultValue(index);
}

extension IterableLastIndex<E> on Iterable<E> {
  int get lastIndex => isEmpty ? -1 : length - 1;
}

extension IterableForEachIndexed<E> on Iterable<E> {
  void forEachIndexed(void Function(int index, E it) action) {
    var index = 0;
    for (final item in this) {
      action(index++, item);
    }
  }
}

extension IterableMapIndexed<E> on Iterable<E> {
  Iterable<R> mapIndexed<R>(R Function(int index, E it) action) sync* {
    for (var index = 0; index < length; index++) {
      yield action(index, elementAt(index));
    }
  }
}

extension IterableContainsAll<E> on Iterable<E> {
  bool containsAll(Iterable<E> elements) {
    for (var i = 0; i < elements.length; i++) {
      if (!contains(elements.elementAt(i))) return false;
    }
    return true;
  }
}

extension IterableFilterIndexed<E> on Iterable<E> {
  List<E> filterIndexed(bool Function(int index, E it) predicate) {
    return filterIndexedTo(<E>[], predicate);
  }
}

extension IterableFilterIndexedTo<E> on Iterable<E> {
  List<E> filterIndexedTo(
      List<E> destination, bool Function(int index, E it) predicate) {
    forEachIndexed((index, it) {
      if (predicate(index, it)) destination.add(it);
    });
    return destination;
  }
}

extension IterableFilterNot<E> on Iterable<E> {
  List<E> filterNot(bool Function(E it) predicate) {
    return filterNotTo(<E>[], predicate);
  }
}

extension IterableFilterNotTo<E> on Iterable<E> {
  List<E> filterNotTo(List<E> destination, bool Function(E it) predicate) {
    for (final element in this) {
      if (!predicate(element)) destination.add(element);
    }
    return destination;
  }
}

extension IterableIsEmptyOrNull<E> on Iterable<E>? {
  bool get isEmptyOrNull => this == null || this!.isEmpty;
}

extension IterableIsNotEmptyOrNull<E> on Iterable<E>? {
  bool get isNotEmptyOrNull => this != null && this!.isNotEmpty;
}
