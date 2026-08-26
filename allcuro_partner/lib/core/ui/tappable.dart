import 'package:flutter/material.dart';

/// A tap target that shows a visible press ripple.
///
/// Plain [GestureDetector] paints no feedback at all, and a bare [InkWell]
/// paints its splash onto the nearest ancestor [Material] — which in this
/// app is usually hidden behind the gradient header / rounded card
/// backgrounds several layers up, so the splash never becomes visible.
/// Wrapping locally in a transparent [Material] keeps the ink layer right
/// where the splash is drawn, so it always shows through.
class Tappable extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final BorderRadius borderRadius;

  const Tappable({
    super.key,
    required this.child,
    required this.onTap,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius,
      child: InkWell(onTap: onTap, borderRadius: borderRadius, child: child),
    );
  }
}
