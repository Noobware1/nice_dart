import 'package:nice_dart/src/extensions/map.dart';
import 'package:test/test.dart';

void main() {
  group('MapExtensions', () {
    test('get', () {
      var map = {'key': 'value'};
      expect(map.get('key'), equals('value'));
      expect(map.get('other'), isNull);
    });

    test('add', () {
      var map = <String, String>{};
      expect(map.add('key', 'value').get('key'), equals('value'));
      expect(map.get('other'), isNull);
    });

    test('toJson', () {
      var map = {'key': 'value'};
      expect(map.toJson(), equals('{"key":"value"}'));
    });

    test('getOrDefault', () {
      var map = {'key': 'value'};
      expect(map.getOrDefault('key', 'default'), equals('value'));
      expect(map.getOrDefault('other', 'default'), equals('default'));
    });

    test('forEachIndexed', () {
      var map = {'key1': 'value1', 'key2': 'value2'};
      var keys = [];
      var values = [];
      map.forEachIndexed((index, key, value) {
        keys.add(key);
        values.add(value);
      });
      expect(keys, equals(['key1', 'key2']));
      expect(values, equals(['value1', 'value2']));
    });
  });

  group('OrEmptyMap', () {
    test('orEmpty', () {
      Map<String, String>? map;
      expect(map.orEmpty(), equals({}));

      map = {'key': 'value'};
      expect(map.orEmpty(), equals({'key': 'value'}));
    });
  });
}
