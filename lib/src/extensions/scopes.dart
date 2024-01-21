extension Scopes<T extends Object?> on T {
  /// Calls the specified function block with this value as its receiver and returns this value.
  T apply(void Function(T it) block) {
    block(this);
    return this;
  }

  /// Calls the specified function block with this value as its argument and returns this value.
  T also(void Function(T it) block) {
    block(this);
    return this;
  }

  /// Calls the specified function block with this value as its argument and returns its result.
  R let<R>(R Function(T it) block) {
    return block(this);
  }

  /// Returns this value if it satisfies the given predicate or null, if it doesn't.
  T? takeIf(bool Function(T it) predicate) {
    return predicate(this) ? this : null;
  }

  /// Returns `this` value if it _does not_ satisfy the given [predicate] or `null`, if it does.
  T? takeUnless(bool Function(T it) predicate) {
    return !predicate(this) ? this : null;
  }
}
