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
  void insert(int index, E element) {
    RangeError.checkValidIndex(index, this);
    super.insert(index, element);
  }

  @override
  void add(E element) {
    final index = _list.lastIndexWhere((element) => element != null) + 1;
    return insert(index, element);
  }

  @override
  void addAll(Iterable<E> iterable) {
    iterable.forEach(add);
  }
}
