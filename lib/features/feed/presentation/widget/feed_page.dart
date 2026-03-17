import 'package:dart/core/theme/app_colors.dart';
import 'package:dart/features/feed/domain/entity/video_item.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';

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

    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            item.thumbnailUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              color: AppColors.background,
            ),
          ),
          Container(
            color: Colors.black.withValues(alpha: 0.35),
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
                            ? Colors.white.withValues(alpha: 0.18)
                            : Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: isCurrentPage
                              ? Colors.white.withValues(alpha: 0.45)
                              : Colors.white.withValues(alpha: 0.18),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        child: Text(
                          isCurrentPage ? '현재 페이지' : '대기 페이지',
                          style: textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '@${item.username}',
                    style: textTheme.headlineSmall,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    item.description,
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'index: $index / current: $currentIndex',
                    style: textTheme.bodySmall,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}