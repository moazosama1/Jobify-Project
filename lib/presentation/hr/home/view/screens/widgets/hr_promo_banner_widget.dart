import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';

class HrPromoBannerWidget extends StatelessWidget {
  final String title;
  final String imagePath;

  const HrPromoBannerWidget({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFF0CB359), // Sleek emerald green background
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0CB359).withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Illustration on the right side
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            width: 160,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                alignment: Alignment.bottomRight,
              ),
            ),
          ),
          // Title on the left side
          Positioned(
            left: AppMeasurements.paddingLarge,
            top: 0,
            bottom: 0,
            right: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
