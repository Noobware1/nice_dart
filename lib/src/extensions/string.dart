import 'dart:convert';

import 'package:nice_dart/src/extensions/iterable.dart';

extension StringLastIndex on String {
  int get lastIndex => isEmpty ? -1 : length - 1;
}

extension StringCaptialize on String {
  String captialize() =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : this;
}

extension StringDecapitalize on String {
  String decapitalize() =>
      isNotEmpty ? '${this[0].toLowerCase()}${substring(1, length)}' : this;
}

extension StringGet on String {
  String get(int index) => this[index];
}

extension StringGetOrNull on String {
  String? getOrNull(int index) => index < length ? this[index] : null;
}

extension StringGetOrElse on String {
  String getOrElse(int index, String Function(int index) defaultValue) =>
      (index >= 0 && index <= lastIndex) ? get(index) : defaultValue(index);
}

extension StringPlus on String {
  String plus(dynamic other) => this + other.toString();
}

extension StringMax on String {
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
}

extension StringMin on String {
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
}

extension StringEquals on String {
  bool equals(String other, {ignoreCase = false}) {
    if (ignoreCase) {
      return toLowerCase() == other.toLowerCase();
    }
    return this == other;
  }
}

extension StringFilter on String {
  String filter(bool Function(String it) predicate) {
    return filterTo(StringBuffer(), predicate).toString();
  }
}

extension StringFilterTo on String {
  StringSink filterTo(StringSink c, bool Function(String it) predicate) {
    for (var index = 0; index < length; index++) {
      final element = this[index];
      if (predicate(element)) c.write(element);
    }
    return c;
  }
}

extension StringFilterIndexed on String {
  String filterIndexed(bool Function(int index, String it) predicate) {
    return filterIndexedTo(StringBuffer(), predicate).toString();
  }
}

extension StringFilterIndexedTo on String {
  StringSink filterIndexedTo(
      StringSink destination, bool Function(int index, String it) predicate) {
    toList().forEachIndexed((index, it) {
      if (predicate(index, it)) destination.write(it);
    });
    return destination;
  }
}

extension StringFilterNot on String {
  String filterNot(bool Function(String it) predicate) {
    return filterNotTo(StringBuffer(), predicate).toString();
  }
}

extension StringFilterNotTo on String {
  StringSink filterNotTo(
      StringSink destination, bool Function(String it) predicate) {
    for (var index = 0; index < length; index++) {
      final element = this[index];
      if (!predicate(element)) destination.write(element);
    }
    return destination;
  }
}

extension StringDrop on String {
  String drop(int n) => n > length ? '' : substring(n, length);
}

extension StringDropLast on String {
  String dropLast(int n) => n > length ? '' : substring(0, length - n);
}

extension StringDropWhile on String {
  String dropWhile(bool Function(String it) predicate) {
    for (var index = 0; index < length; index++) {
      if (!predicate(this[index])) return substring(index);
    }
    return "";
  }
}

extension StringDropLastWhile on String {
  String dropLastWhile(bool Function(String it) predicate) {
    for (var index = length - 1; index > 0; index--) {
      if (!predicate(this[index])) return substring(0, index + 1);
    }
    return "";
  }
}

extension StringTake on String {
  String take(int n) => n > length ? this : substring(0, n);
}

extension StringTakeLast on String {
  String takeLast(int n) => n > length ? this : substring(length - n, length);
}

extension StringTakeWhile on String {
  String takeWhile(bool Function(String it) predicate) {
    for (var index = 0; index < length; index++) {
      if (!predicate(this[index])) return substring(0, index);
    }
    return this;
  }
}

extension StringTakeLastWhile on String {
  String takeLastWhile(bool Function(String it) predicate) {
    for (var index = length - 1; index > 0; index--) {
      if (!predicate(this[index])) return substring(index + 1, length);
    }
    return this;
  }
}

extension StringToRegex on String {
  RegExp toRegex({
    bool multiLine = false,
    bool caseSensitive = true,
    bool unicode = false,
    bool dotAll = false,
  }) {
    return RegExp(
      this,
      multiLine: multiLine,
      caseSensitive: caseSensitive,
      unicode: unicode,
      dotAll: dotAll,
    );
  }
}

extension StringToList on String {
  List<String> toList() => split('');
}

extension StringCodeUnitBefore on String {
  int codeUnitBefore(int index) => codeUnitAt(index - 1);
}

extension StringReversed on String {
  String get reversed {
    final buffer = StringBuffer();
    for (var i = length - 1; i > -1; i--) {
      buffer.write(this[i]);
    }
    return buffer.toString();
  }
}

extension StringSubstringBefore on String {
  String substringBefore(String pattern) {
    final i = indexOf(pattern);
    if (i == -1) return this;
    return substring(0, i);
  }
}

extension StringSubstringAfter on String {
  String substringAfter(String pattern) {
    final i = indexOf(pattern);
    if (i == -1) return this;
    final len = i + pattern.length;
    return substring(len, length);
  }
}

extension StringSubstringBeforeLast on String {
  String substringBeforeLast(String pattern) {
    final i = lastIndexOf(pattern);
    if (i == -1) return this;
    return substring(0, i);
  }
}

extension StringSubstringAfterLast on String {
  String substringAfterLast(String pattern) {
    final i = lastIndexOf(pattern);
    if (i == -1) return this;
    final len = i + pattern.length;
    return substring(len, length);
  }
}

extension StringToByteList on String {
  List<int> toByteList([Encoding? encoding]) {
    return (encoding ?? utf8).encode(this);
  }
}

extension StringToNum on String {
  num toNum() => num.parse(this);
}

extension StringToInt on String {
  int toInt() => int.parse(this);
}

extension StringToDouble on String {
  double toDouble() => double.parse(this);
}

extension StringToNumOrNull on String? {
  num? toNumOrNull() => this == null ? null : num.tryParse(this!);
}

extension StringToIntOrNull on String? {
  int? toIntOrNull() => this == null ? null : int.tryParse(this!);
}

extension StringToDoubleOrNull on String? {
  double? toDoubleOrNull() => this == null ? null : double.tryParse(this!);
}

extension StringOrEmpty on String? {
  String orEmpty() => this ?? '';
}

extension StringIsEmptyOrNull on String? {
  bool get isEmptyOrNull => this == null || this!.isEmpty;
}

extension StringIsNotEmptyOrNull on String? {
  bool get isNotEmptyOrNull => this != null && this!.isNotEmpty;
}
