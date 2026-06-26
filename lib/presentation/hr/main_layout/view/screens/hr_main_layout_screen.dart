import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:jobify_project/core/router/route_names.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HrMainLayoutScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HrMainLayoutScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final iconList = <FaIconData>[
      FontAwesomeIcons.house,
      FontAwesomeIcons.bookmark,
      FontAwesomeIcons.message,
      FontAwesomeIcons.solidUser,
    ];

    return Scaffold(
      body: navigationShell,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RouteNames.hrHiringPost),
        backgroundColor: theme.colorScheme.primary,
        shape: const CircleBorder(),
        elevation: 4,
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: AnimatedBottomNavigationBar.builder(
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            final color = isActive ? theme.colorScheme.primary : theme.colorScheme.onSurface.withValues(alpha: 0.3);
            return Center(
              child: FaIcon(
                iconList[index],
                size: 22,
                color: color,
              ),
            );
          },
          activeIndex: navigationShell.currentIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.smoothEdge,
          height: 65,
          leftCornerRadius: 24,
          rightCornerRadius: 24,
          backgroundColor: theme.colorScheme.surface,
          onTap: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
        ),
      ),
    );
  }
}
