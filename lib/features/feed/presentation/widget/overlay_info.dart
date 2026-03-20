import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';

class OverlayInfo extends StatelessWidget {
  const OverlayInfo({
    super.key,
    required this.username,
    required this.description,
    required this.index,
    required this.currentIndex,
  });

  final String username;
  final String description;
  final int index;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '@$username',
          style: textTheme.headlineSmall?.copyWith(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          description,
          style: textTheme.bodyMedium?.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}