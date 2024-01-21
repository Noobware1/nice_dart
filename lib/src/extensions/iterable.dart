import 'package:dartx/src/extensions/object.dart';



extension OrEmptyIterable<E> on Iterable<E>? {
  Iterable<E> orEmpty() {
    return this ?? Iterable.empty();
  }
}

extension FaltExtensionsOnIterable<E> on List<List<E>> {
  Iterable<E> flatten() sync* {
    for (final list in this) {
      yield* list;
    }
  }
}

extension MapNotNull<E> on Iterable<E?> {
  Iterable<R> mapNotNull<R>(R Function(E it) transform) sync* {
    for (final element in this) {
      if (element.isNotNull) {
        yield transform(element as E);
      }
    }
  }

  Iterable<R> mapNotNullIndexed<R>(
      R Function(int index, E it) transform) sync* {
    for (var index = 0; index < length; index++) {
      final element = elementAt(index);
      if (element.isNotNull) {
        yield transform(index, element as E);
      }
    }
  }
}

extension IterableExtensions<E> on Iterable<E> {
  E get(int index) => this is List ? (this as List)[index] : elementAt(index);

  E? getOrNull(int index) => index < length ? get(index) : null;

  E getOrElse(int index, E Function(int index) defaultValue) =>
      (index >= 0 && index <= lastIndex) ? get(index) : defaultValue(index);

  int get lastIndex => isEmpty ? -1 : length - 1;

  void forEachIndexed(void Function(int index, E it) action) {
    var index = 0;
    for (final item in this) {
      action(index++, item);
    }
  }

  Iterable<R> mapIndexed<R>(R Function(int index, E it) action) sync* {
    for (var index = 0; index < length; index++) {
      yield action(index, elementAt(index));
    }
  }

  bool containsAll(Iterable<E> elements) {
    for (var i = 0; i < elements.length; i++) {
      if (!contains(elements.elementAt(i))) return false;
    }
    return true;
  }

  List<E> filterIndexed(bool Function(int index, E it) predicate) {
    return filterIndexedTo(<E>[], predicate);
  }

  List<E> filterIndexedTo(
      List<E> destination, bool Function(int index, E it) predicate) {
    forEachIndexed((index, it) {
      if (predicate(index, it)) destination.add(it);
    });
    return destination;
  }

  List<E> filterNot(bool Function(E it) predicate) {
    return filterNotTo(<E>[], predicate);
  }

  List<E> filterNotTo(List<E> destination, bool Function(E it) predicate) {
    for (final element in this) {
      if (!predicate(element)) destination.add(element);
    }
    return destination;
  }
}
