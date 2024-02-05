import 'package:nice_dart/src/extensions/string.dart';
import 'package:test/test.dart';

void main() {
  group('StringExtensions', () {
    test('plus', () {
      expect(''.plus('1'), equals('1'));
      expect('1'.plus(2), equals('12'));
    });

    test('lastIndex', () {
      expect(''.lastIndex, equals(-1));
      expect('12'.lastIndex, equals(1));
    });

    test('get', () {
      expect('12'.get(1), equals('2'));
      expect(() => '12'.get(2), throwsRangeError);
    });

    test('getOrNull', () {
      expect('12'.getOrNull(1), equals('2'));
      expect('12'.getOrNull(2), equals(null));
    });

    test('getOrElse', () {
      expect('12'.getOrElse(1, (index) => '3'), equals('2'));
      expect('12'.getOrElse(2, (index) => '$index'), equals('2'));
    });

    test('max', () {
      expect('abc'.max, equals('c'));
      expect(''.max, isNull);
    });

    test('min', () {
      expect('abc'.min, equals('a'));
      expect(''.min, isNull);
    });

    test('equals', () {
      expect('abc'.equals('abc'), equals(true));
      expect('abc'.equals('ABC', ignoreCase: true), equals(true));
      expect('abc'.equals('ABC'), equals(false));
    });

    test('drop', () {
      expect('abc'.drop(1), equals('bc'));
      expect('abc'.drop(3), equals(''));
    });

    test('dropLast', () {
      expect('abc'.dropLast(1), equals('ab'));
      expect('abc'.dropLast(3), equals(''));
    });

    test('filter', () {
      expect('abc'.filter((it) => it != 'b'), equals('ac'));
    });

    test('filterNot', () {
      expect('abc'.filterNot((it) => it == 'b'), equals('ac'));
    });

    test('dropWhile', () {
      expect('abc'.dropWhile((it) => it != 'b'), equals('bc'));
    });

    test('dropLastWhile', () {
      expect('abc'.dropLastWhile((it) => it != 'b'), equals('ab'));
    });

    test('take', () {
      expect('abc'.take(2), equals('ab'));
      expect('abc'.take(5), equals('abc'));
    });

    test('takeLast', () {
      expect('abc'.takeLast(2), equals('bc'));
      expect('abc'.takeLast(5), equals('abc'));
    });

    test('takeWhile', () {
      expect('abc'.takeWhile((it) => it != 'b'), equals('a'));
    });

    test('takeLastWhile', () {
      expect('abc'.takeLastWhile((it) => it != 'b'), equals('c'));
    });

    test('toRegex', () {
      expect('abc'.toRegex(), isA<RegExp>());
    });

    test('toList', () {
      expect('abc'.toList(), equals(['a', 'b', 'c']));
    });

    test('codeUnitBefore', () {
      expect('abc'.codeUnitBefore(2), equals('abc'.codeUnitAt(1)));
    });

    test('reversed', () {
      expect('abc'.reversed, equals('cba'));
    });
  });

  test('toNum', () {
    expect('123'.toNum(), equals(123));
    expect('123.45'.toNum(), equals(123.45));
  });

  test('toInt', () {
    expect('123'.toInt(), equals(123));
  });

  test('toDouble', () {
    expect('123.45'.toDouble(), equals(123.45));
  });

  test('substringBefore', () {
    expect('abc'.substringBefore('b'), equals('a'));
    expect('abc'.substringBefore('d'), equals('abc'));
  });

  test('substringAfter', () {
    expect('abc'.substringAfter('b'), equals('c'));
    expect('abc'.substringAfter('d'), equals('abc'));
  });

  test('substringBeforeLast', () {
    expect('abcabc'.substringBeforeLast('b'), equals('abca'));
    expect('abcabc'.substringBeforeLast('d'), equals('abcabc'));
  });

  test('substringAfterLast', () {
    expect('abcabc'.substringAfterLast('b'), equals('c'));
    expect('abcabc'.substringAfterLast('d'), equals('abcabc'));
  });

  group('NullableStringExtensions', () {
    test('toNumOrNull', () {
      expect('123'.toNumOrNull(), equals(123));
      expect('abc'.toNumOrNull(), isNull);
    });

    test('toIntOrNull', () {
      expect('123'.toIntOrNull(), equals(123));
      expect('abc'.toIntOrNull(), isNull);
    });

    test('toDoubleOrNull', () {
      expect('123.45'.toDoubleOrNull(), equals(123.45));
      expect('abc'.toDoubleOrNull(), isNull);
    });

    test('orEmpty', () {
      expect('abc'.orEmpty(), equals('abc'));
      expect(null.orEmpty(), equals(''));
    });
  });
}
