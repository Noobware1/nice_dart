extension SetOrEmpty<E> on Set<E>? {
  Set<E> orEmpty() {
    return this ?? {};
  }
}


