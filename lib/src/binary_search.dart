import 'package:nice_dart/nice_dart.dart';

int binarySearch<T extends Comparable<T>>(Iterable<T> list, T targetKey) {
  int low = 0;
  int high = list.length - 1;

  while (low <= high) {
    int mid = (low + high) ~/ 2;
    int compareResult = list.get(mid).compareTo(targetKey);

    if (compareResult == 0) {
      return mid; // Element found
    } else if (compareResult < 0) {
      low = mid + 1; // Search in the right half
    } else {
      high = mid - 1; // Search in the left half
    }
  }

  return -1; // Element not found
}
