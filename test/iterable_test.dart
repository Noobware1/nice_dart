import 'package:dartx/src/extensions/iterable.dart';
import 'package:test/test.dart';

void main() {
  group('IterableExtensions', () {
    test('get', () {
      expect([1, 2, 3].get(1), equals(2));
      expect(() => [1, 2, 3].get(4), throwsRangeError);
    });

    test('getOrNull', () {
      expect([1, 2, 3].getOrNull(1), equals(2));
      expect([1, 2, 3].getOrNull(3), isNull);
    });

    test('getOrElse', () {
      expect([1, 2, 3].getOrElse(1, (index) => 0), equals(2));
      expect([1, 2, 3].getOrElse(3, (index) => 0), equals(0));
    });
    test('forEachIndexed', () {
      var result = '';
      ['a', 'b', 'c'].forEachIndexed((index, it) => result += '$index$it');
      expect(result, equals('0a1b2c'));
    });

    test('mapIndexed', () {
      expect(
          [1, 2, 3].mapIndexed((index, it) => it + index), equals([1, 3, 5]));
    });

    test('lastIndex', () {
      expect([1, 2, 3].lastIndex, equals(2));
      expect([].lastIndex, equals(-1));
    });

    test('containsAll', () {
      expect([1, 2, 3].containsAll([1, 2]), equals(true));
      expect([1, 2, 3].containsAll([4, 5]), equals(false));
    });

    test('filterIndexed', () {
      expect([1, 2, 3, 4, 5].filterIndexed((index, it) => index % 2 == 0),
          equals([1, 3, 5]));
      expect(
          [1, 2, 3].filterIndexed((index, it) => index % 2 != 0), equals([2]));
    });

    test('filterIndexedTo', () {
      var destination = <int>[];
      [1, 2, 3, 4, 5]
          .filterIndexedTo(destination, (index, it) => index % 2 == 0);
      expect(destination, equals([1, 3, 5]));
    });

    test('filterNot', () {
      expect([1, 2, 3, 4, 5].filterNot((it) => it % 2 == 0), equals([1, 3, 5]));
      expect([1, 2, 3].filterNot((it) => it % 2 != 0), equals([2]));
    });

    test('filterNotTo', () {
      var destination = <int>[];
      [1, 2, 3, 4, 5].filterNotTo(destination, (it) => it % 2 == 0);
      expect(destination, equals([1, 3, 5]));
    });
  });

  group('MapNotNull', () {
    test('mapNotNull', () {
      expect([1, 2, null].mapNotNull((it) => it + 1), equals([2, 3]));
    });
    test('mapNotNullIndexed', () {
      expect([1, 2, null, 3].mapNotNullIndexed((index, it) => it + index),
          equals([1, 3, 6]));
    });
  });
}
