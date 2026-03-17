import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/current_page_provider.dart';
import '../provider/feed_provider.dart';
import '../widget/feed_page.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  late final PageController _pageController;
  bool _didNotifyPaginationTrigger = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handlePageChanged({
    required int index,
    required int itemCount,
  }) {
    ref.read(currentPageProvider.notifier).state = index;

    final shouldTriggerPagination = index >= itemCount - 2;

    if (shouldTriggerPagination && !_didNotifyPaginationTrigger) {
      _didNotifyPaginationTrigger = true;
      debugPrint('pagination trigger point reached: page=$index, total=$itemCount');
    }

    if (!shouldTriggerPagination) {
      _didNotifyPaginationTrigger = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final feedAsync = ref.watch(feedProvider);
    final currentPage = ref.watch(currentPageProvider);

    return Scaffold(
      body: feedAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              '피드를 불러오지 못했습니다.\n$error',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (videos) {
          if (videos.isEmpty) {
            return const Center(
              child: Text('표시할 피드가 없습니다.'),
            );
          }

          return Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: videos.length,
                onPageChanged: (index) {
                  _handlePageChanged(
                    index: index,
                    itemCount: videos.length,
                  );
                },
                itemBuilder: (context, index) {
                  final item = videos[index];

                  return FeedPage(
                    item: item,
                    index: index,
                    currentIndex: currentPage,
                  );
                },
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        child: Text(
                          'current page: $currentPage',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}