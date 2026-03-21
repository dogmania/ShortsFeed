import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/feed_di.dart';
import '../../domain/entity/video_item.dart';

final feedProvider = AsyncNotifierProvider<FeedNotifier, List<VideoItem>>(FeedNotifier.new);

class FeedNotifier extends AsyncNotifier<List<VideoItem>> {
  @override
  Future<List<VideoItem>> build() async {
    final useCase = ref.watch(getFeedVideosUseCaseProvider);
    return useCase();
  }

  void toggleLikeLocal(String videoId) {
    final items = state.asData?.value;
    if (items == null) return;

    final updatedItems = items.map((item) {
      if (item.id != videoId) return item;

      final nextIsLiked = !item.isLiked;
      final nextLikeCount = nextIsLiked
          ? item.likeCount + 1
          : (item.likeCount > 0 ? item.likeCount - 1 : 0);

      return item.copyWith(
        isLiked: nextIsLiked,
        likeCount: nextLikeCount,
      );
    }).toList();

    state = AsyncData(updatedItems);
  }

  void setLikeState({
    required String videoId,
    required bool isLiked,
    required int likeCount,
  }) {
    final items = state.asData?.value;
    if (items == null) return;

    final updatedItems = items.map((item) {
      if (item.id != videoId) return item;

      return item.copyWith(
        isLiked: isLiked,
        likeCount: likeCount,
      );
    }).toList();

    state = AsyncData(updatedItems);
  }
}