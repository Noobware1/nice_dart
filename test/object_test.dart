import 'package:dartx/src/extensions/object.dart';
import 'package:test/test.dart';

void main() {
  group('NullableExtenstions', () {
    test('isNull', () {
      expect('not null'.isNull, equals(false));
      expect(null.isNull, equals(true));
    });

    test('isNotNull', () {
      expect('not null'.isNotNull, equals(true));
      expect(null.isNotNull, equals(false));
    });
  });
}
