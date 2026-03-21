import 'package:dart/features/feed/domain/entity/video_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_spacing.dart';
import '../provider/like_provider.dart';
import 'overlay_action_button.dart';

class OverlayActions extends ConsumerWidget {
  const OverlayActions({
    super.key,
    required this.item,
  });

  final VideoItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLiking = ref.watch(
      likeProvider.select((pendingIds) => pendingIds.contains(item.id)),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        OverlayActionButton(
          iconAssetPath: item.isLiked
              ? 'assets/images/ic_like_checked.svg'
              : 'assets/images/ic_like_unchecked.svg',
          label: _formatCount(item.likeCount),
          onTap: () {
            if (isLiking) return;
            ref.read(likeProvider.notifier).toggleLike(item.id);
          },
        ),
        const SizedBox(height: AppSpacing.lg),
        OverlayActionButton(
          iconAssetPath: 'assets/images/ic_comment.svg',
          label: _formatCount(item.commentCount),
          onTap: () {
            debugPrint('comment tapped: ${item.id}');
          },
        ),
      ],
    );
  }

  String _formatCount(int value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    }
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }
    return '$value';
  }
}