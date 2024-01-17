import 'package:dartx/src/extensions/list.dart';
import 'package:test/test.dart';

void main() {
  group('ListExtensions', () {
    test('mapList', () {
      expect([1, 2, 3].mapList((e) => e * 2), equals([2, 4, 6]));
    });

    test('mapListIndexed', () {
      expect([1, 2, 3].mapListIndexed((index, e) => e / index),
          equals([double.infinity, 2.0, 1.5]));
    });

    test('lastIndexOf', () {
      expect(['a', 'b', 'c', 'b'].lastIndexOf('b'), equals(3));
      expect(['a', 'b', 'c'].lastIndexOf('d'), equals(-1));
    });

    test('dropWhile', () {
      expect([1, 2, 3, 4, 5].dropWhile((it) => it < 4), equals([4, 5]));
      expect([1, 2, 3].dropWhile((it) => it < 0), equals([1, 2, 3]));
    });

    test('dropLastWhile', () {
      expect([1, 2, 3, 4, 5].dropLastWhile((it) => it > 2), equals([1, 2]));
      expect([1, 2, 3].dropLastWhile((it) => it > 5), equals([1, 2, 3]));
    });

    test('takeAsList', () {
      expect([1, 2, 3].takeAsList(2), equals([1, 2]));
      expect([1, 2, 3].takeAsList(5), equals([1, 2, 3]));
    });

    test('takeLast', () {
      expect([1, 2, 3].takeLast(2), equals([2, 3]));
      expect([1, 2, 3].takeLast(5), equals([1, 2, 3]));
    });

    test('takeWhile', () {
      expect([1, 2, 3, 4, 5].takeWhile((it) => it < 4), equals([1, 2, 3]));
      expect([1, 2, 3].takeWhile((it) => it < 0), equals([]));
    });

    test('takeLastWhile', () {
      expect([1, 2, 3, 4, 5].takeLastWhile((it) => it > 2), equals([3, 4, 5]));
      expect([1, 2, 3].takeLastWhile((it) => it > 5), equals([]));
    });
  });

  group('NonNulls', () {
    test('nonNullableList', () {
      expect([1, null, 2, null, 3].nonNullableList, equals([1, 2, 3]));
    });
  });

  group('MapListNotNull', () {
    test('mapListNotNull', () {
      expect([1, 2, null].mapListNotNull((it) => it + 1), equals([2, 3]));
    });
    test('mapListNotNullIndexed', () {
      expect([1, 2, null, 3].mapListNotNullIndexed((index, it) => it + index),
          equals([1, 3, 6]));
    });
  });

  group('NullableExtenstions', () {
    test('isEmptyOrNull', () {
      expect([].isEmptyOrNull, equals(true));
      expect([1].isEmptyOrNull, equals(false));
      expect(null.isEmptyOrNull, equals(true));
    });

    test('isNotEmptyOrNull', () {
      expect([].isNotEmptyOrNull, equals(false));
      expect([1].isNotEmptyOrNull, equals(true));
      expect(null.isNotEmptyOrNull, equals(false));
    });
  });
}
