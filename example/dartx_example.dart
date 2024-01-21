import 'package:dartx/dartx.dart';

void main() {
  var plus = '1'.plus('2').plus(3);
  print(plus); // 123

  var lastIndex = '123'.lastIndex;
  print(lastIndex); // 2

  var get = '123'.get(1);
  print(get); // 2

  var getOrNull = '123'.getOrNull(1);
  print(getOrNull); // 2

  var getOrElse = '123'.getOrElse(1, (index) => '3');
  print(getOrElse); // 2

  var max = 'abc'.max;
  print(max); // c

  var min = 'abc'.min;
  print(min); // a

  var equals = 'abc'.equals('abc');
  print(equals); // true

  var drop = 'abc'.drop(1);
  print(drop); // bc

  var dropLast = 'abc'.dropLast(1);
  print(dropLast); // ab

  var filter = 'abc'.filter((it) => it != 'b');
  print(filter); // ac

  var filterNot = 'abc'.filterNot((it) => it == 'b');
  print(filterNot); // ac

  var dropWhile = 'abc'.dropWhile((it) => it != 'b');
  print(dropWhile); // bc

  var dropLastWhile = 'abc'.dropLastWhile((it) => it != 'b');
  print(dropLastWhile); // ab

  var take = 'abc'.take(2);
  print(take); // ab

  var takeLast = 'abc'.takeLast(2);
  print(takeLast); // bc

  var takeWhile = 'abc'.takeWhile((it) => it != 'b');
  print(takeWhile); // a

  var takeLastWhile = 'abc'.takeLastWhile((it) => it != 'b');
  print(takeLastWhile); // c

  var toRegex = 'abc'.toRegex();
  print(toRegex.pattern); // abc

  var toList = 'abc'.toList();
  print(toList); // [a, b, c]

  var codeUintBrefore = 'abc'.codeUnitBefore(2);
  print(codeUintBrefore); // 98

  var reversed = 'abc'.reversed;
  print(reversed); // cba

  var toNum = '123'.toNum();
  print(toNum); // 123

  var toNumOrNull = 'null'.toNumOrNull();
  print(toNumOrNull); // 123

  var toInt = '123'.toInt();
  print(toInt); // 123

  var toIntOrNull = 'null'.toIntOrNull();
  print(toIntOrNull); // null

  var toDouble = '123.45'.toDouble();
  print(toDouble); // 123.45

  var toDoubleOrNull = 'null'.toDoubleOrNull();
  print(toDoubleOrNull); // null

  var substringBefore = 'abc'.substringBefore('b');
  print(substringBefore); // a

  var substringAfter = 'abc'.substringAfter('b');
  print(substringAfter); // c

  var substringBeforeLast = 'abcabc'.substringBeforeLast('b');
  print(substringBeforeLast); // abca

  var substringAfterLast = 'abcabc'.substringAfterLast('b');
  print(substringAfterLast); // c

  final List<int>? a = null;
  final Iterable<int>? b = null;
  final Map<String, int>? c = null;
  final String? d = null;
  print(a.orEmpty());
  print(b.orEmpty());
  print(c.orEmpty());
  print(d.orEmpty());
  print(test(a));
}

List<int> test(List<int>? list) {
  return list
      .let((it) => it?.mapListIndexed((index, e) => e * index))
      .orEmpty();
}
