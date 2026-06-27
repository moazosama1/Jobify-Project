import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/constants/app_images.dart';
import 'package:jobify_project/core/router/route_names.dart';

class DraggableFloatingAiButton extends StatefulWidget {
  const DraggableFloatingAiButton({super.key});

  @override
  State<DraggableFloatingAiButton> createState() => _DraggableFloatingAiButtonState();
}

class _DraggableFloatingAiButtonState extends State<DraggableFloatingAiButton> {
  Offset position = const Offset(0, 0);
  bool isInitialized = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    if (!isInitialized) {
      final screenWidth = mediaQuery.size.width;
      final screenHeight = mediaQuery.size.height;
      // Default position at bottom right above the bottom navigation bar
      position = Offset(screenWidth - 72.0, screenHeight - 160.0);
      isInitialized = true;
    }

    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            final screenWidth = mediaQuery.size.width;
            final screenHeight = mediaQuery.size.height;

            double newX = position.dx + details.delta.dx;
            double newY = position.dy + details.delta.dy;

            // Constrain coordinate bounds
            newX = newX.clamp(16.0, screenWidth - 72.0);
            newY = newY.clamp(
              mediaQuery.padding.top + 16.0,
              screenHeight - mediaQuery.padding.bottom - 130.0,
            );

            position = Offset(newX, newY);
          });
        },
        child: FloatingActionButton(
          heroTag: 'draggable_ai_fab',
          onPressed: () => context.push(RouteNames.aiChat),
          backgroundColor: Colors.white,
          elevation: 8,
          hoverElevation: 12,
          highlightElevation: 4,
          splashColor: AppColors.mainColor.withValues(alpha: 0.1),
          shape: CircleBorder(
            side: BorderSide(color: AppColors.mainColor, width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(AppImages.iconAI, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
