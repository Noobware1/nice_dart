R run<R>(R Function() action) => action();

void repeat(int times, void Function(int index) action) {
  for (var index = 0; index < times; index++) {
    action(index);
  }
}
