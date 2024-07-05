import 'dart:convert';

import 'package:nice_dart/nice_dart.dart';
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

extension StringIsWhiteSpace on String {
  bool get isWhiteSpace {
    if (isEmpty) return false;
    int ch = codeUnitAt(0);
    return (ch >= 0x0009 && ch <= 0x000d) ||
        (ch >= 0x001c && ch <= 0x0020) ||
        ch == 0x00a0 ||
        (ch > 0x1000 &&
            (ch == 0x1680 ||
                (ch >= 0x2000 && ch <= 0x200a) ||
                ch == 0x2028 ||
                ch == 0x2029 ||
                ch == 0x202f ||
                ch == 0x205f ||
                ch == 0x3000));
  }
}

extension StringIsDigit on String {
  static const _rangeStart = [
    0x0030,
    0x0660,
    0x06f0,
    0x07c0,
    0x0966,
    0x09e6,
    0x0a66,
    0x0ae6,
    0x0b66,
    0x0be6,
    0x0c66,
    0x0ce6,
    0x0d66,
    0x0de6,
    0x0e50,
    0x0ed0,
    0x0f20,
    0x1040,
    0x1090,
    0x17e0,
    0x1810,
    0x1946,
    0x19d0,
    0x1a80,
    0x1a90,
    0x1b50,
    0x1bb0,
    0x1c40,
    0x1c50,
    0xa620,
    0xa8d0,
    0xa900,
    0xa9d0,
    0xa9f0,
    0xaa50,
    0xabf0,
    0xff10,
  ];

  /// Returns the index of the largest element in [array] smaller or equal to the specified [needle],
  /// or -1 if [needle] is smaller than the smallest element in [array].
  int _binarySearchRange(List<int> array, int needle) {
    var bottom = 0;
    var top = array.lastIndex;
    var middle = -1;
    var value = 0;
    while (bottom <= top) {
      middle = (bottom + top) ~/ 2;
      value = array[middle];
      if (needle > value) {
        bottom = middle + 1;
      } else if (needle == value) {
        return middle;
      } else {
        top = middle - 1;
      }
    }
    return middle - (needle < value ? 1 : 0);
  }

  bool get isDigit {
    final ch = codeUnitAt(0);
    final index = _binarySearchRange(_rangeStart, ch);
    final diff = ch - _rangeStart[index];
    return ((diff < 10) ? diff : -1) >= 0;
  }
}

extension StringIndexWhere on String {
  int indexWhere(bool Function(String it) predicate) {
    for (var index = 0; index < length; index++) {
      if (predicate(this[index])) return index;
    }
    return -1;
  }
}

extension StringIsEvery on String {
  bool every(bool Function(String) test) {
    for (var i = 0; i < length; i++) {
      if (!test(this[i])) return false;
    }
    return true;
  }
}

extension StringIsBlank on String {
  bool get isBlank => every((it) => it.isWhiteSpace);
}

extension StringIsNotBlank on String {
  bool get isNotBlank => !isBlank;
}

extension StringLines on String {
  List<String> get lines {
    return split(RegExp(r'\r\n|\n|\r'));
  }
}

extension StringTrimIndent on String {
  String trimIndent() => replaceIndent();
}

extension StringReplaceIndent on String {
//  * Detects a common minimal indent like it does [trimIndent] and replaces it with the specified [newIndent].
//  */
  String replaceIndent([String newIndent = ""]) {
    final lines = this.lines;

    final minCommonIndent = lines
            .where((it) => it.isNotBlank)
            .map((it) => it._indentWidth())
            .minOrNull() ??
        0;

    return _reIndent(lines, (line) => _getIndentFunction(newIndent, line),
        (line) => line.drop(minCommonIndent));
  }

  int _indentWidth() =>
      indexWhere((it) => !it.isWhiteSpace).let((it) => it == -1 ? length : it);

  String _getIndentFunction(String indent, String line) {
    if (indent.isEmpty) {
      return line;
    } else {
      return indent + line;
    }
  }

  String _reIndent(List<String> list, String Function(String) indentAddFunction,
      String? Function(String) indentCutFunction) {
    final lastIndex = list.lastIndex;
    return list
        .mapNotNullIndexed((index, value) {
          if ((index == 0 || index == lastIndex) && value.isBlank) {
            return null;
          } else {
            return indentCutFunction(value)?.let(indentAddFunction) ?? value;
          }
        })
        .joinTo(StringBuffer(), separator: '\n')
        .toString();
  }
}
