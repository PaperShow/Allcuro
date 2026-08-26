import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Ports the `.surface-3d` / `.surface-3d-lg` utility classes: a card
/// surface with a hairline border (the design system's shadows are
/// disabled — `--shadow-3d: none` — so this is intentionally flat).
///
/// Backed by [Material] rather than [Container] so that, when [onTap] is
/// given, the tap ripple paints directly on the card's own surface instead
/// of being hidden behind an opaque decoration.
class Surface extends StatelessWidget {
  final Widget child;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final Clip clipBehavior;
  final VoidCallback? onTap;

  const Surface({
    super.key,
    required this.child,
    this.radius = AppRadius.xxxl,
    this.padding,
    this.clipBehavior = Clip.none,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      side: const BorderSide(color: AppColors.border),
    );
    return Material(
      color: AppColors.card,
      shape: shape,
      clipBehavior: clipBehavior == Clip.none ? Clip.antiAlias : clipBehavior,
      child: InkWell(
        onTap: onTap,
        customBorder: shape,
        child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
      ),
    );
  }
}

/// Ports the `.icon-tile-3d` utility class (flat `--primary-soft` fill).
class IconTile extends StatelessWidget {
  final Widget child;
  final double size;
  final double radius;

  const IconTile({
    super.key,
    required this.child,
    this.size = 48,
    this.radius = AppRadius.xl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
