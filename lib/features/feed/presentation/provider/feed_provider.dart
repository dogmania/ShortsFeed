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
}