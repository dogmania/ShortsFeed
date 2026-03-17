import '../../domain/entity/video_item.dart';
import '../../domain/repository/feed_repository.dart';
import '../datasource/mock_video_datasource.dart';

class FeedRepositoryImpl implements FeedRepository {
  FeedRepositoryImpl(this._dataSource);

  final MockVideoDataSource _dataSource;

  @override
  Future<List<VideoItem>> getFeedVideos() async {
    final models = await _dataSource.fetchVideos();
    return models.map((model) => model.toEntity()).toList();
  }
}