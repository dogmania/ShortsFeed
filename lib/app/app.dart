import 'package:dart/features/feed/presentation/screen/feed_screen.dart';
import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class ShortsApp extends StatelessWidget {
  const ShortsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shorts Feed',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const FeedScreen(),
    );
  }
}