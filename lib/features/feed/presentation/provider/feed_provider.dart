import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/feed_di.dart';
import '../../domain/entity/video_item.dart';

final feedProvider = FutureProvider<List<VideoItem>>((ref) async {
  final useCase = ref.watch(getFeedVideosUseCaseProvider);
  return useCase();
});