final class Pair<A, B> {
  final A first;
  final B second;

  Pair(this.first, this.second);

  @override
  String toString() => 'Pair($first, $second)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pair && first == other.first && second == other.second;

  @override
  int get hashCode => first.hashCode ^ second.hashCode;
}
