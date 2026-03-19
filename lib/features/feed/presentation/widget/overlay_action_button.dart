import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_spacing.dart';

class OverlayActionButton extends StatelessWidget {
  const OverlayActionButton({
    super.key,
    required this.iconAssetPath,
    required this.label,
    required this.onTap,
  });

  final String iconAssetPath;
  final String label;
  final VoidCallback onTap;

  static const double _iconSize = 32;
  static const double _tapTargetSize = 36;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          child: InkResponse(
            onTap: onTap,
            containedInkWell: false,
            highlightShape: BoxShape.circle,
            radius: _tapTargetSize / 2,
            splashColor: Colors.white.withValues(alpha: 0.14),
            highlightColor: Colors.white.withValues(alpha: 0.06),
            child: SizedBox(
              width: _tapTargetSize,
              height: _tapTargetSize,
              child: Center(
                child: SvgPicture.asset(
                  iconAssetPath,
                  width: _iconSize,
                  height: _iconSize,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodySmall?.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}