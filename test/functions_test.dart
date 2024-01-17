import 'package:dartx/src/functions.dart';
import 'package:test/test.dart';

void main() {
  group('Functions', () {
    test('require', () {
      expect(require(true), equals(true));
      expect(() => require(false), throwsA(isA<ArgumentError>()));
      expect(() => require(false, 'Condition failed'),
          throwsA(isA<ArgumentError>()));
    });

    test('repeat', () {
      var count = 0;
      repeat(5, (index) => count++);
      expect(count, equals(5));
    });
  });
}
