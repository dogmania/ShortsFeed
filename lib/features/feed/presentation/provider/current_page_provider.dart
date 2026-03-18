import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentPageProvider =
NotifierProvider<CurrentPageNotifier, int>(CurrentPageNotifier.new);

class CurrentPageNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void setPage(int index) {
    if (state == index) return;
    state = index;
  }

  void reset() {
    state = 0;
  }
}