import '../entity/video_item.dart';

abstract interface class FeedRepository {
  Future<List<VideoItem>> getFeedVideos();
}