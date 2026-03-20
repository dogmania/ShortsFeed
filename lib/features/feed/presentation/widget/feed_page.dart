import 'package:dart/features/feed/domain/entity/video_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_spacing.dart';
import '../provider/like_provider.dart';
import 'overlay_actions.dart';
import 'overlay_info.dart';
import 'video_player_item.dart';

class FeedPage extends ConsumerWidget {
  const FeedPage({
    super.key,
    required this.item,
    required this.index,
    required this.currentIndex,
  });

  final VideoItem item;
  final int index;
  final int currentIndex;

  bool get isCurrentPage => index == currentIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final likeState = ref.watch(likeProvider(item));

    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(
          color: Colors.black,
        ),
        VideoPlayerItem(
          path: item.path,
          isActive: isCurrentPage,
          isLiked: likeState.isLiked,
          onDoubleTapLike: () {
            ref.read(likeProvider(item).notifier).toggleLike();
          },
        ),
        SafeArea(
          child: Padding(
            padding: AppSpacing.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: isCurrentPage
                          ? Colors.white.withValues(alpha: 0.16)
                          : Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: isCurrentPage
                            ? Colors.white.withValues(alpha: 0.42)
                            : Colors.white.withValues(alpha: 0.16),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      child: Text(
                        isCurrentPage ? '재생 중' : '비활성 페이지',
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: OverlayInfo(
                        username: item.username,
                        description: item.description,
                        index: index,
                        currentIndex: currentIndex,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.lg),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 144),
                      child: OverlayActions(item: item),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ],
    );
  }
}