import 'package:nice_dart/src/nice_regexp.dart';
import 'package:test/test.dart';

void main() {
  group('NiceRegExp', () {
    test('constructor and matchers', () {
      var niceRegExp = NiceRegExp('abc');
      expect(niceRegExp.hasMatch('abc'), equals(true));
      expect(niceRegExp.hasMatch('def'), equals(false));

      niceRegExp = NiceRegExp.fromRegExp(RegExp('abc'));
      expect(niceRegExp.hasMatch('abc'), equals(true));
      expect(niceRegExp.hasMatch('def'), equals(false));
    });

    test('matcher', () {
      var niceRegExp = NiceRegExp('abc').matcher('abc');
      expect(niceRegExp.hasMatch(), equals(true));
    });

    test('allMatches and firstMatch', () {
      var niceRegExp = NiceRegExp('a');
      var allMatches = niceRegExp.allMatches('aaa');
      expect(allMatches.length, equals(3));

      var firstMatch = niceRegExp.firstMatch('aaa');
      expect(firstMatch!.group(0), equals('a'));
    });

    test('region', () {
      var niceRegExp = NiceRegExp(r'(abc)').matcher('abcd').region(0, 3);
      expect(niceRegExp.hasMatch(), equals(true));
      expect(niceRegExp.hasMatch('abd'), equals(false));
    });

    test('useRegExp and usePattern', () {
      var niceRegExp = NiceRegExp('abc').useRegExp(RegExp('def'));
      expect(niceRegExp.hasMatch('def'), equals(true));

      niceRegExp = NiceRegExp('abc').usePattern('def');
      expect(niceRegExp.hasMatch('def'), equals(true));
    });

    test('group', () {
      var niceRegExp = NiceRegExp('a(b)c').matcher('abc');
      expect(niceRegExp.group(1), equals('b'));
    });
  });
}
