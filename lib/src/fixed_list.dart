import 'dart:collection';

class FixedList<E> extends ListBase<E> {
  final List<E?> _list;

  FixedList(this.length)
      : assert(length > 0),
        _list = List<E?>.filled(length, null);

  @override
  final int length;

  @override
  E operator [](int index) {
    return _list[index] ?? (throw StateError('No element at index $index'));
  }

  @override
  void operator []=(int index, E value) {
    _list[index] = value;
  }

  @override
  set length(int newLength) {
    throw UnsupportedError('Cannot change the length of a FixedList');
  }

  @override
  void add(E element) {
    throw UnsupportedError('Cannot add to a FixedList');
  }

  @override
  void addAll(Iterable<E> iterable) {
    throw UnsupportedError('Cannot add to a FixedList');
  }
}
