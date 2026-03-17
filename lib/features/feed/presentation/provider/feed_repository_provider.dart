import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/mock_video_datasource.dart';
import '../../data/repository/feed_repository_impl.dart';
import '../../domain/repository/feed_repository.dart';

final mockVideoDataSourceProvider = Provider<MockVideoDataSource>((ref) {
  return MockVideoDataSource();
});

final feedRepositoryProvider = Provider<FeedRepository>((ref) {
  final dataSource = ref.watch(mockVideoDataSourceProvider);
  return FeedRepositoryImpl(dataSource);
});