import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/feed/presentation/screen/feed_bootstrap_screen.dart';

class ShortsApp extends StatelessWidget {
  const ShortsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shorts Feed',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const FeedBootstrapScreen(),
    );
  }
}