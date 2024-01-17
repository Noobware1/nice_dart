import 'package:dartx/src/extensions/scopes.dart';
import 'package:test/test.dart';

class TestClass {
  int value;
  TestClass(this.value);
}

void main() {
  group('Scopes', () {
    test('apply', () {
      final testClass = TestClass(0);
      expect(testClass.apply((it) => it.value += 10).value, equals(10));
    });

    test('also', () {
      final testClass = TestClass(0);
      final value = testClass.also((it) {
        it.value = 26;
      }).value;
      expect(value, equals(26));
    });

    test('let', () {
      var value = 1;
      expect(value.let((it) => it + 1), equals(2));
    });

    test('takeIf', () {
      var value = 1;
      expect(value.takeIf((it) => it == 1), equals(1));
      expect(value.takeIf((it) => it == 2), isNull);
    });

    test('takeUnless', () {
      var value = 1;
      expect(value.takeUnless((it) => it == 1), isNull);
      expect(value.takeUnless((it) => it == 2), equals(1));
    });
  });
}
