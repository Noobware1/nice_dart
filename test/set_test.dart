import 'package:nice_dart/src/extensions/set.dart';
import 'package:test/test.dart';

void main() {
  group('Set', () {
    test('OrEmpty', () {
      Set<int>? s = {1, 2, 3};
      expect(s.orEmpty(), equals({1, 2, 3}));
      s = null;
      expect(s.orEmpty(), equals(<int>{}));
    });
  });
}
