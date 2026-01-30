import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmerList({
  int? length,
  double? height,
  double? separatorHeight,
  double? borderItem,
}) {
  return ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) =>
        buildShimmerItem(height: height, borderItem: borderItem),
    separatorBuilder: (context, index) =>
        SizedBox(height: separatorHeight ?? 12),
    itemCount: length ?? 8,
  );
}

Widget buildShimmerItem({double? height, double? borderItem}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade200.withValues(alpha: 0.2),
    highlightColor: Colors.grey.shade100.withValues(alpha: 0.4),
    period: const Duration(milliseconds: 1200),
    child: Container(
      width: double.infinity,
      height: height ?? 18,
      decoration: BoxDecoration(
        color: Colors.grey.shade300.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(borderItem ?? 4),
      ),
    ),
  );
}
