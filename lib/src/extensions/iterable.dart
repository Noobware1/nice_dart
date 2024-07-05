import 'package:nice_dart/src/binary_search.dart' as bin;
import 'dart:math' as math;

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
  Iterable<R> mapNotNull<R extends Object>(R? Function(E it) transform) sync* {
    for (var element in this) {
      if (element != null) {
        var result = transform(element);
        if (result != null) {
          yield result;
        }
      }
    }
  }
}

extension IterableMapNotNullIndexed<E> on Iterable<E?> {
  Iterable<R> mapNotNullIndexed<R extends Object>(
      R? Function(int index, E it) transform) sync* {
    var index = 0;
    for (var element in this) {
      if (element != null) {
        var result = transform(index, element);
        if (result != null) {
          yield result;
        }
      }
      index++;
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
    var index = 0;
    return [for (final e in this) toElement(index++, e)];
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

extension IterableSecondLast<E> on Iterable<E> {
  E get secondLast => get(lastIndex - 1);
}

extension IterableSecondLastOrNull<E> on Iterable<E> {
  E? get secondLastOrNull => getOrNull(lastIndex - 1);
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
    var index = 0;
    for (final item in this) {
      yield action(index++, item);
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

extension IterableJoinTo<E> on Iterable<E> {
  StringBuffer joinTo(StringBuffer buffer,
      {String separator = ', ',
      String prefix = '',
      String postfix = '',
      int limit = -1,
      String truncated = '...',
      String Function(E)? transform}) {
    buffer.write(prefix);
    var count = 0;
    for (var element in this) {
      if (++count > 1) buffer.write(separator);
      if (limit < 0 || count <= limit) {
        if (transform != null) {
          buffer.write(transform(element));
        } else {
          buffer.write(element);
        }
      } else {
        break;
      }
    }
    if (limit >= 0 && count > limit) buffer.write(truncated);
    buffer.write(postfix);
    return buffer;
  }
}

extension IterableMin<E extends num> on Iterable<E> {
  E min() {
    var min = first;
    for (var e in this) {
      min = math.min(min, e);
    }
    return min;
  }
}

extension IterableMinOrNull<E extends num> on Iterable<E> {
  E? minOrNull() {
    if (isEmpty) return null;
    return min();
  }
}

extension IterableMax<E extends num> on Iterable<E> {
  E max() {
    var max = first;
    for (var e in this) {
      max = math.max(max, e);
    }
    return max;
  }
}

extension IterableMaxOrNull<E extends num> on Iterable<E> {
  E? maxOrNull() {
    if (isEmpty) return null;
    return max();
  }
}
