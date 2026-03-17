import '../entity/video_item.dart';
import '../repository/feed_repository.dart';

class GetFeedVideosUseCase {
  const GetFeedVideosUseCase(this._repository);

  final FeedRepository _repository;

  Future<List<VideoItem>> call() {
    return _repository.getFeedVideos();
  }
}