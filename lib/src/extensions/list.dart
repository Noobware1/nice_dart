import 'package:dartx/src/extensions/iterable.dart';

extension OrEmptyList<E> on List<E>? {
  List<E> orEmpty() {
    return this ?? [];
  }
}

extension FaltExtensions<E> on List<List<E>> {
  List<E> flatten() => [for (final list in this) ...list];
}

extension ToIterable<E> on List<E>? {
  Iterable<E> toIterable() {
    return this == null
        ? Iterable.empty()
        : Iterable.generate(this!.length, (i) => this![i]);
  }
}

extension MapListNotNull<E> on Iterable<E?> {
  List<R> mapListNotNull<R>(R Function(E it) transform) {
    final l = <R>[];
    for (final element in this) {
      if (element != null) {
        l.add(transform(element));
      }
    }
    return l;
  }

  List<R> mapListNotNullIndexed<R>(R Function(int index, E it) transform) {
    final l = <R>[];
    for (var index = 0; index < length; index++) {
      final element = elementAt(index);
      if (element != null) {
        l.add(transform(index, element));
      }
    }
    return l;
  }

}

extension NullableListExtensions<E> on List<E>? {
  bool get isEmptyOrNull => this == null || this!.isEmpty;

  bool get isNotEmptyOrNull => this != null && this!.isNotEmpty;
}

extension NonNulls<E> on List<E?> {
  List<E> get nonNullableList {
    return [
      for (final e in this)
        if (e != null) e
    ];
  }
}

extension ListExtensions<E> on List<E> {
  int lastIndexOf(E element) {
    for (var i = lastIndex; i >= 0; i--) {
      if (this[i] == element) return i;
    }
    return -1;
  }

  List<E> dropWhile(bool Function(E it) predicate) {
    for (var index = 0; index < length; index++) {
      if (!predicate(this[index])) return sublist(index);
    }
    return <E>[];
  }

  List<E> dropLastWhile(bool Function(E it) predicate) {
    for (var index = length - 1; index > 0; index--) {
      if (!predicate(this[index])) return sublist(0, index + 1);
    }
    return <E>[];
  }

  List<E> takeAsList(int n) => n > length ? this : sublist(0, n);

  List<E> takeLast(int n) => n > length ? this : sublist(length - n, length);

  List<E> takeWhile(bool Function(E it) predicate) {
    for (var index = 0; index < length; index++) {
      if (!predicate(this[index])) return sublist(0, index);
    }
    return this;
  }

  List<E> takeLastWhile(bool Function(E it) predicate) {
    for (var index = length - 1; index > 0; index--) {
      if (!predicate(this[index])) return sublist(index + 1, length);
    }
    return this;
  }
}
