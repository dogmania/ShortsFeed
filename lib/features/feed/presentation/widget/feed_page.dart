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
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(
          color: Colors.black,
        ),
        VideoPlayerItem(
          path: item.path,
          isActive: isCurrentPage,
          isLiked: item.isLiked,
          onDoubleTapLike: () {
            ref.read(likeProvider.notifier).toggleLike(item.id);
          },
        ),
        SafeArea(
          child: Padding(
            padding: AppSpacing.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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