import 'package:nice_dart/src/functions.dart';
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

    test('run', () {
      var count = 1;
      count = run(() {
        count++;
        return count;
      });
      expect(count, equals(2));
    });
  });
}
