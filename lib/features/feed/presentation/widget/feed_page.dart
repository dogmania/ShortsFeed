import 'package:dart/features/feed/domain/entity/video_item.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import 'video_player_item.dart';

class FeedPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      fit: StackFit.expand,
      children: [
        VideoPlayerItem(
          path: item.path,
          isActive: isCurrentPage,
        ),
        Container(
          color: Colors.black.withValues(alpha: 0.18),
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
                Text(
                  '@${item.username}',
                  style: textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  item.description,
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'index: $index / current: $currentIndex',
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.white70,
                  ),
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