import 'package:dartx/src/extensions/iterable.dart';

extension StringExtensions on String {
  int get lastIndex => length - 1;

  String captialize() =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : this;

  String decapitalize() =>
      isNotEmpty ? '${this[0].toLowerCase()}${substring(1, length)}' : this;

  String get(int index) => this[index];

  String? getOrNull(int index) => index < length ? this[index] : null;

  String getOrElse(int index, String Function(int index) defaultValue) =>
      (index >= 0 && index <= lastIndex) ? get(index) : defaultValue(index);

  String plus(dynamic other) => this + other.toString();

  String? get max {
    if (isEmpty) return null;
    final runes = this.runes;
    var max = runes.elementAt(0);
    for (var i = 0; i < length; i++) {
      var e = runes.elementAt(i);
      if (max < e) max = e;
    }
    return String.fromCharCode(max);
  }

  String? get min {
    if (isEmpty) return null;
    final runes = this.runes;
    var max = runes.elementAt(0);
    for (var i = 0; i < length; i++) {
      var e = runes.elementAt(i);
      if (max > e) max = e;
    }
    return String.fromCharCode(max);
  }

  bool equals(String other, {ignoreCase = false}) {
    if (ignoreCase) {
      return toLowerCase() == other.toLowerCase();
    }
    return this == other;
  }

  String drop(int n) => n > length ? '' : substring(n, length);

  String dropLast(int n) => n > length ? '' : substring(0, length - n);

  String filter(bool Function(String it) predicate) {
    return filterTo(StringBuffer(), predicate).toString();
  }

  StringSink filterTo(StringSink c, bool Function(String it) predicate) {
    for (var index = 0; index < length; index++) {
      final element = this[index];
      if (predicate(element)) c.write(element);
    }
    return c;
  }

  String filterIndexed(bool Function(int index, String it) predicate) {
    return filterIndexedTo(StringBuffer(), predicate).toString();
  }

  StringSink filterIndexedTo(
      StringSink destination, bool Function(int index, String it) predicate) {
    toList().forEachIndexed((index, it) {
      if (predicate(index, it)) destination.write(it);
    });
    return destination;
  }

  String filterNot(bool Function(String it) predicate) {
    return filterNotTo(StringBuffer(), predicate).toString();
  }

  StringSink filterNotTo(
      StringSink destination, bool Function(String it) predicate) {
    for (var index = 0; index < length; index++) {
      final element = this[index];
      if (!predicate(element)) destination.write(element);
    }
    return destination;
  }

  String dropWhile(bool Function(String it) predicate) {
    for (var index = 0; index < length; index++) {
      if (!predicate(this[index])) return substring(index);
    }
    return "";
  }

  String dropLastWhile(bool Function(String it) predicate) {
    for (var index = length - 1; index > 0; index--) {
      if (!predicate(this[index])) return substring(0, index + 1);
    }
    return "";
  }

  String take(int n) => n > length ? this : substring(0, n);

  String takeLast(int n) => n > length ? this : substring(length - n, length);

  String takeWhile(bool Function(String it) predicate) {
    for (var index = 0; index < length; index++) {
      if (!predicate(this[index])) return substring(0, index);
    }
    return this;
  }

  String takeLastWhile(bool Function(String it) predicate) {
    for (var index = length - 1; index > 0; index--) {
      if (!predicate(this[index])) return substring(index + 1, length);
    }
    return this;
  }

  RegExp toRegex() => RegExp(this);

  List<String> toList() => split('');

  int codeUnitBefore(int index) => codeUnitAt(index - 1);

  String get reversed {
    final buffer = StringBuffer();
    for (var i = length - 1; i > -1; i--) {
      buffer.write(this[i]);
    }
    return buffer.toString();
  }

  num toNum() => num.parse(this);

  int toInt() => int.parse(this);

  double toDouble() => double.parse(this);

  String substringBefore(String pattern) {
    final i = indexOf(pattern);
    if (i == -1) return this;
    return substring(0, i);
  }

  String substringAfter(String pattern) {
    final i = indexOf(pattern);
    if (i == -1) return this;
    final len = i + pattern.length;
    return substring(len, length);
  }

  String substringBeforeLast(String pattern) {
    final i = lastIndexOf(pattern);
    if (i == -1) return this;
    return substring(0, i);
  }

  String substringAfterLast(String pattern) {
    final i = lastIndexOf(pattern);
    if (i == -1) return this;
    final len = i + pattern.length;
    return substring(len, length);
  }
}

extension NullableStringExtensions on String? {
  num? toNumOrNull() => this == null ? null : num.tryParse(this!);

  int? toIntOrNull() => this == null ? null : int.tryParse(this!);

  double? toDoubleOrNull() => this == null ? null : double.tryParse(this!);
}

extension OrEmptyOnString on String? {
  String orEmpty() => this ?? '';
}
