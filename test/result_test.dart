import 'package:nice_dart/src/result.dart';
import 'package:test/test.dart';

void main() {
  group('Result', () {
    test('success', () {
      var result = Result.success(1);
      expect(result.isSuccess, equals(true));
      expect(result.getOrNull(), equals(1));
      expect(result.toString(), equals('Success(1)'));
    });

    test('failure', () {
      var result = Result.failure(Exception('Error'));
      expect(result.isFailure, equals(true));
      expect(result.exceptionOrNull(), isA<Exception>());
      expect(result.toString(), startsWith('Failure'));
    });

    test('runCatching', () {
      var result = runCatching<int>(() => 1);

      expect(result.isSuccess, equals(true));
      expect(result.getOrNull(), equals(1));

      result = runCatching<int>(() => throw Exception('Error'));
      expect(result.isFailure, equals(true));
      expect(result.exceptionOrNull(), isA<Exception>());
      var b = 1;
      result = b.runCatching(() => b ~/ 0);
      expect(result.isFailure, equals(true));
      expect(result.exceptionOrNull(), isA<Exception>());
    });

    test('getOrThrow', () {
      var result = Result.success(1);
      expect(result.getOrThrow(), equals(1));

      result = Result.failure(Exception('Error'));
      expect(() => result.getOrThrow(), throwsA(isA<Exception>()));
    });

    test('getOrElse', () {
      var result = Result.success(1);
      expect(result.getOrElse((e) => 0), equals(1));

      result = Result.failure(Exception('Error'));
      expect(result.getOrElse((e) => 0), equals(0));
    });

    test('getOrDefault', () {
      var result = Result.success(1);
      expect(result.getOrDefault(0), equals(1));

      result = Result.failure(Exception('Error'));
      expect(result.getOrDefault(0), equals(0));
    });

    test('fold', () {
      var result = Result.success(1);
      expect(result.fold((v) => v, (e) => 0), equals(1));

      result = Result.failure(Exception('Error'));
      expect(result.fold((v) => v, (e) => 0), equals(0));
    });

    test('map', () {
      var result = Result.success(1);
      expect(result.map((v) => v + 1).getOrNull(), equals(2));

      result = Result.failure(Exception('Error'));
      expect(result.map((v) => v + 1).isFailure, equals(true));
    });

    test('mapCatching', () {
      var result = Result.success(1);
      expect(result.mapCatching((v) => v + 1).getOrNull(), equals(2));

      result = Result.failure(Exception('Error'));
      expect(result.mapCatching((v) => v + 1).isFailure, equals(true));
    });

    test('recover', () {
      var result = Result.success(1);
      expect(result.recover((e) => 0).getOrNull(), equals(1));

      result = Result.failure(Exception('Error'));
      expect(result.recover((e) => 0).getOrNull(), equals(0));
    });

    test('recoverCatching', () {
      var result = Result.success(1);
      expect(result.recoverCatching((e) => 0).getOrNull(), equals(1));

      result = Result.failure(Exception('Error'));
      expect(result.recoverCatching((e) => 0).getOrNull(), equals(0));
    });
  });
}
