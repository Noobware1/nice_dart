bool require(bool condition, [String? message]) {
  if (!condition) {
    throw ArgumentError(message);
  }
  return condition;
}

void repeat(int times, void Function(int index) action) {
  for (var index = 0; index < times; index++) {
    action(index);
  }
}
