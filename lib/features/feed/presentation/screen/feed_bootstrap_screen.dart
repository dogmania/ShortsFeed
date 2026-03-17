import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../domain/entity/video_item.dart';
import '../provider/feed_repository_provider.dart';

class FeedBootstrapScreen extends ConsumerStatefulWidget {
  const FeedBootstrapScreen({super.key});

  @override
  ConsumerState<FeedBootstrapScreen> createState() => _FeedBootstrapScreenState();
}

class _FeedBootstrapScreenState extends ConsumerState<FeedBootstrapScreen> {
  late Future<List<VideoItem>> _feedFuture;

  @override
  void initState() {
    super.initState();
    _feedFuture = ref.read(feedRepositoryProvider).getFeedVideos();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<VideoItem>>(
          future: _feedFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: AppSpacing.screenPadding,
                  child: Text(
                    '피드 더미 데이터를 불러오는 데 실패했습니다.\n${snapshot.error}',
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            final videos = snapshot.data ?? const [];

            return ListView.separated(
              padding: AppSpacing.screenPadding,
              itemCount: videos.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                final item = videos[index];

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.username,
                          style: textTheme.headlineSmall,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          item.description,
                          style: textTheme.bodyMedium,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'videoUrl: ${item.videoUrl}',
                          style: textTheme.bodySmall,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'likes: ${item.likeCount} · comments: ${item.commentCount} · shares: ${item.shareCount}',
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}