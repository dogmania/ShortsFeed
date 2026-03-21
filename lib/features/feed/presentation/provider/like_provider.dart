import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/video_item.dart';
import 'feed_provider.dart';

final likeProvider =
NotifierProvider<LikeNotifier, Set<String>>(LikeNotifier.new);

class LikeNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => <String>{};

  Future<void> toggleLike(String videoId) async {
    if (state.contains(videoId)) return;

    final feedState = ref.read(feedProvider).asData?.value;
    if (feedState == null) return;

    final targetIndex = feedState.indexWhere((item) => item.id == videoId);
    if (targetIndex == -1) return;

    final target = feedState[targetIndex];
    final prevIsLiked = target.isLiked;
    final prevLikeCount = target.likeCount;

    state = {...state, videoId};

    // optimistic update
    ref.read(feedProvider.notifier).toggleLikeLocal(videoId);

    try {
      // TODO: 나중에 서버 통신 유스케이스 연결
    } catch (_) {
      // 롤백
      ref.read(feedProvider.notifier).setLikeState(
        videoId: videoId,
        isLiked: prevIsLiked,
        likeCount: prevLikeCount,
      );
    } finally {
      final next = {...state};
      next.remove(videoId);
      state = next;
    }
  }
}