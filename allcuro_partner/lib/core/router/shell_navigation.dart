import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Exposes the active [StatefulShellRoute]'s [StatefulNavigationShell] to
/// descendants. go_router only hands the shell to the top-level shell
/// route's own `builder`, not to each branch's leaf route builders — but
/// since that builder's returned widget (`navigationShell` itself) is the
/// ancestor of every branch screen, wrapping it in this [InheritedWidget]
/// lets leaf screens (e.g. `NurseHomeScreen`) call `goBranch` to switch
/// bottom-nav tabs without needing the shell threaded through as a
/// constructor parameter everywhere.
class ShellNavigation extends InheritedWidget {
  final StatefulNavigationShell navigationShell;

  const ShellNavigation({
    super.key,
    required this.navigationShell,
    required super.child,
  });

  static StatefulNavigationShell of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<ShellNavigation>();
    assert(widget != null, 'No ShellNavigation found in context');
    return widget!.navigationShell;
  }

  @override
  bool updateShouldNotify(ShellNavigation oldWidget) =>
      navigationShell != oldWidget.navigationShell;
}
