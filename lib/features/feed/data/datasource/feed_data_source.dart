import 'package:dart/features/feed/data/model/video_item_model.dart';

abstract interface class FeedDataSource {
  Future<List<VideoItemModel>> fetchVideos();
}