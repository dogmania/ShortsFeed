import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'buffering_indicator.dart';

class VideoPlayerItem extends StatefulWidget {
  const VideoPlayerItem({
    super.key,
    required this.path,
    required this.isActive,
  });

  final String path;
  final bool isActive;

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  VideoPlayerController? _controller;
  Future<void>? _initializeFuture;
  bool _hasError = false;

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
        await controller.setLooping(true);

        if (!mounted) return;
        setState(() {});

        await _syncPlaybackWithActiveState();
      }).catchError((_) {
        _hasError = true;
        if (mounted) {
          setState(() {});
        }
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

        final isBuffering = controller.value.isBuffering;

        return Stack(
          fit: StackFit.expand,
          children: [
            Center(
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
            if (isBuffering)
              const ColoredBox(
                color: Color(0x22000000),
                child: BufferingIndicator(),
              ),
          ],
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