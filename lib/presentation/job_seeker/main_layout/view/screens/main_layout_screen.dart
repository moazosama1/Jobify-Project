import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:jobify_project/core/router/route_names.dart';

class MainLayoutScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainLayoutScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final iconList = <IconData>[
      Icons.home_outlined,
      Icons.bookmark_outline,
      Icons.chat_bubble_outline,
      Icons.person_outline,
    ];

    return Scaffold(
      body: navigationShell,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RouteNames.applyJob),
        backgroundColor: theme.colorScheme.primary,
        shape: const CircleBorder(),
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: navigationShell.currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        height: 62,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        activeColor: theme.colorScheme.primary,
        inactiveColor: theme.colorScheme.onSurface.withValues(alpha: 0.5),
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
