import 'package:nice_dart/src/extensions/scopes.dart';
import 'package:nice_dart/src/extensions/string.dart';

class NiceRegExp implements RegExp {
  String _input;
  RegExp _source;
  int _from;
  int _to;

  factory NiceRegExp(
    String source, {
    bool multiLine = false,
    bool caseSensitive = true,
    bool unicode = false,
    bool dotAll = false,
  }) {
    return NiceRegExp._(
      '',
      source.toRegex(
        multiLine: multiLine,
        caseSensitive: caseSensitive,
        unicode: unicode,
        dotAll: dotAll,
      ),
      0,
      -1,
    );
  }

  factory NiceRegExp.fromRegExp(
    RegExp source,
  ) {
    return NiceRegExp._(
      '',
      source,
      0,
      -1,
    );
  }

  NiceRegExp._(String input, RegExp source, int from, int to)
      : _source = source,
        _input = input,
        _from = from,
        _to = to;

  NiceRegExp matcher(String input) {
    return apply((it) {
      _input = input;
      _to = _input.length;
    });
  }

  @override
  Iterable<RegExpMatch> allMatches([String? input, int? start]) {
    if (input != null) {
      return _source.allMatches(input, start ?? 0);
    }
    return _source.allMatches(currentRegionalString);
  }

  @override
  RegExpMatch? firstMatch([String? input]) {
    if (input != null) {
      return _source.firstMatch(input);
    }
    return _source.firstMatch(currentRegionalString);
  }

  @override
  bool hasMatch([String? input]) {
    return _source.hasMatch(input ?? currentRegionalString);
  }

  @override
  Match? matchAsPrefix([String? input, int? start]) {
    if (input != null) {
      return _source.matchAsPrefix(input, start ?? 0);
    }
    return _source.matchAsPrefix(currentRegionalString);
  }

  @override
  bool get isCaseSensitive => _source.isCaseSensitive;

  @override
  bool get isDotAll => _source.isDotAll;

  @override
  bool get isMultiLine => _source.isMultiLine;

  @override
  bool get isUnicode => _source.isUnicode;

  @override
  String get pattern => _source.pattern;

  @override
  String? stringMatch([String? input]) {
    return _source.stringMatch(input ?? currentRegionalString);
  }

  NiceRegExp region(int start, int end) {
    return apply((it) {
      if ((start < 0) || (start > _input.length)) {
        throw IndexError.withLength(start, _input.length, indexable: _input);
      }
      if ((end < 0) || (end > _input.length)) {
        throw IndexError.withLength(end, _input.length, indexable: _input);
      }
      if (start > end) {
        throw ArgumentError.value(start, "start", "start must be <= end");
      }
      _from = start;
      _to = end;
    });
  }

  NiceRegExp useRegExp(RegExp regExp) {
    return apply((it) {
      _source = regExp;
    });
  }

  NiceRegExp usePattern(String pattern) {
    return apply((it) {
      _source = pattern.toRegex();
    });
  }

  String get currentRegionalString =>
      _to == -1 ? _input : _input.substring(_from, _to);

  String group(int index) {
    if (index < 0) {
      throw ArgumentError.value(index, "index", "index must be >= 0");
    }
    final match = _source.firstMatch(currentRegionalString);
    if (index > match!.groupCount) {
      throw ArgumentError.value(index, "index", "index must be <= groupCount");
    }
    return match.group(index)!;
  }
}
