import 'package:dartx/src/builders.dart';
import 'package:test/test.dart';


void main() {
  group('Builders', () {
    test('buildString', () {
      var result = buildString((it) {
        it.write('Hello');
        it.write(' ');
        it.write('World');
      });
      expect(result, equals('Hello World'));
    });

    test('buildList', () {
      var result = buildList<int>((it) {
        it.add(1);
        it.add(2);
        it.add(3);
      });
      expect(result, equals([1, 2, 3]));
    });

    test('buildSet', () {
      var result = buildSet<int>((it) {
        it.add(1);
        it.add(2);
        it.add(3);
      });
      expect(result, equals({1, 2, 3}));
    });

    test('buildMap', () {
      var result = buildMap<String, int>((it) {
        it['one'] = 1;
        it['two'] = 2;
        it['three'] = 3;
      });
      expect(result, equals({'one': 1, 'two': 2, 'three': 3}));
    });
  });
}
