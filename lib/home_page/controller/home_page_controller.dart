import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavigationProvider =
    StateNotifierProvider<BottomNavigationNotifier, int>((ref) {
  return BottomNavigationNotifier(0);
});

class BottomNavigationNotifier extends StateNotifier<int> {
  BottomNavigationNotifier(int index) : super(index);

  @override
  build() {
    return;
  }

  void setIndex(int index) {
    log('index: $index');
    state = index;
  }
}
