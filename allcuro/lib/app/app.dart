import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import 'router.dart';

class AllcuroApp extends StatelessWidget {
  const AllcuroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ALLCURO — Healthcare, Made Simple.',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      routerConfig: appRouter,
    );
  }
}
