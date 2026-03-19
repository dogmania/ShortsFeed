import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/video_item.dart';

class LikeState {
  const LikeState({
    required this.isLiked,
    required this.likeCount,
  });

  final bool isLiked;
  final int likeCount;

  LikeState copyWith({
    bool? isLiked,
    int? likeCount,
  }) {
    return LikeState(
      isLiked: isLiked ?? this.isLiked,
      likeCount: likeCount ?? this.likeCount,
    );
  }
}

class LikeNotifier extends Notifier<LikeState> {
  LikeNotifier(this.videoItem);

  final VideoItem videoItem;

  @override
  LikeState build() {
    return LikeState(
      isLiked: videoItem.isLiked,
      likeCount: videoItem.likeCount,
    );
  }

  void toggleLike() {
    final current = state;

    if (current.isLiked) {
      state = current.copyWith(
        isLiked: false,
        likeCount: current.likeCount > 0 ? current.likeCount - 1 : 0,
      );
      return;
    }

    state = current.copyWith(
      isLiked: true,
      likeCount: current.likeCount + 1,
    );
  }
}

final likeProvider =
NotifierProvider.autoDispose.family<LikeNotifier, LikeState, VideoItem>(
  LikeNotifier.new,
);