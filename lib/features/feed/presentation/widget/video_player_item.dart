import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'buffering_indicator.dart';

class VideoPlayerItem extends StatefulWidget {
  const VideoPlayerItem({
    super.key,
    required this.path,
    required this.isActive,
    required this.isLiked,
    required this.onDoubleTapLike,
  });

  final String path;
  final bool isActive;
  final bool isLiked;
  final VoidCallback onDoubleTapLike;

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  VideoPlayerController? _controller;
  Future<void>? _initializeFuture;
  bool _hasError = false;
  bool _showLikeFeedback = false;
  bool _lastLikeFeedbackState = false;
  Timer? _likeFeedbackTimer;

  @override
  void initState() {
    super.initState();

    if (widget.isActive) {
      _createController();
    }
  }

  @override
  void didUpdateWidget(covariant VideoPlayerItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.path != widget.path) {
      _disposeController();
      _hasError = false;

      if (widget.isActive) {
        _createController();
      }
      return;
    }

    if (!oldWidget.isActive && widget.isActive) {
      if (_controller == null) {
        _createController();
      } else {
        _syncPlaybackWithActiveState();
      }
      return;
    }

    if (oldWidget.isActive && !widget.isActive) {
      _controller?.pause();
    }
  }

  Future<void> _createController() async {
    try {
      final controller = VideoPlayerController.asset(widget.path);
      _controller = controller;

      _initializeFuture = controller.initialize().then((_) async {
        if (!mounted || _controller != controller) return;

        await controller.setLooping(true);

        if (!mounted || _controller != controller) return;
        setState(() {});

        await _syncPlaybackWithActiveState();
      }).catchError((_) {
        if (!mounted || _controller != controller) return;
        _hasError = true;
        setState(() {});
      });
    } catch (_) {
      _hasError = true;
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<void> _syncPlaybackWithActiveState() async {
    final controller = _controller;
    if (controller == null) return;
    if (!controller.value.isInitialized) return;

    if (widget.isActive) {
      await controller.play();
    } else {
      await controller.pause();
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _handleSingleTap() async {
    final controller = _controller;
    if (controller == null) return;
    if (!widget.isActive) return;
    if (!controller.value.isInitialized) return;
    if (_hasError) return;

    if (controller.value.isPlaying) {
      await controller.pause();
    } else {
      await controller.play();
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _handleDoubleTap() async {
    final controller = _controller;
    if (controller == null) return;
    if (!widget.isActive) return;
    if (!controller.value.isInitialized) return;
    if (_hasError) return;

    widget.onDoubleTapLike();

    _lastLikeFeedbackState = !widget.isLiked;
    _likeFeedbackTimer?.cancel();

    if (mounted) {
      setState(() {
        _showLikeFeedback = true;
      });
    }

    _likeFeedbackTimer = Timer(const Duration(milliseconds: 520), () {
      if (!mounted) return;
      setState(() {
        _showLikeFeedback = false;
      });
    });
  }

  Future<void> _disposeController() async {
    final controller = _controller;
    _controller = null;
    _initializeFuture = null;

    if (controller != null) {
      await controller.dispose();
    }
  }

  @override
  void dispose() {
    _likeFeedbackTimer?.cancel();
    _disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return const _VideoErrorFallback();
    }

    final controller = _controller;
    final initializeFuture = _initializeFuture;

    if (controller == null || initializeFuture == null) {
      return const ColoredBox(
        color: Colors.black,
      );
    }

    return FutureBuilder<void>(
      future: initializeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done ||
            !controller.value.isInitialized) {
          return const ColoredBox(
            color: Colors.black,
            child: BufferingIndicator(),
          );
        }

        final aspectRatio =
        controller.value.aspectRatio == 0 ? 9 / 16 : controller.value.aspectRatio;

        return ValueListenableBuilder<VideoPlayerValue>(
          valueListenable: controller,
          builder: (context, value, child) {
            final isBuffering = value.isBuffering;
            final showPausedOverlay =
                widget.isActive && !value.isPlaying && !isBuffering;

            return Stack(
              fit: StackFit.expand,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _handleSingleTap,
                  onDoubleTap: _handleDoubleTap,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      clipBehavior: Clip.hardEdge,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / aspectRatio,
                        child: VideoPlayer(controller),
                      ),
                    ),
                  ),
                ),
                if (isBuffering)
                  const ColoredBox(
                    color: Color(0x22000000),
                    child: BufferingIndicator(),
                  ),
                IgnorePointer(
                  child: AnimatedOpacity(
                    opacity: showPausedOverlay ? 1 : 0,
                    duration: const Duration(milliseconds: 180),
                    child: const Center(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0x66000000),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(18),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                IgnorePointer(
                  child: Center(
                    child: AnimatedScale(
                      scale: _showLikeFeedback ? 1 : 0.72,
                      duration: const Duration(milliseconds: 180),
                      child: AnimatedOpacity(
                        opacity: _showLikeFeedback ? 1 : 0,
                        duration: const Duration(milliseconds: 180),
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            color: Color(0x66000000),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Icon(
                              _lastLikeFeedbackState
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              color: Colors.white,
                              size: 56,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _VideoErrorFallback extends StatelessWidget {
  const _VideoErrorFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.play_disabled_rounded,
            color: Colors.white,
            size: 36,
          ),
          SizedBox(height: 8),
          Text(
            '영상을 재생할 수 없습니다',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}