import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/datasource/feed_data_source.dart';
import '../data/datasource/mock_feed_data_source.dart';
import '../data/repository/feed_repository_impl.dart';
import '../domain/repository/feed_repository.dart';
import '../domain/usecase/get_feed_videos.dart';

final feedDataSourceProvider = Provider<FeedDataSource>((ref) {
  return MockFeedDataSource();
});

final feedRepositoryProvider = Provider<FeedRepository>((ref) {
  final dataSource = ref.watch(feedDataSourceProvider);
  return FeedRepositoryImpl(dataSource);
});

final getFeedVideosUseCaseProvider = Provider<GetFeedVideosUseCase>((ref) {
  final repository = ref.watch(feedRepositoryProvider);
  return GetFeedVideosUseCase(repository);
});