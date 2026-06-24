import 'package:flutter/material.dart';
import 'package:jobify_project/generated/l10n.dart';

class JobDetailsHeaderSection extends StatelessWidget {
  final String title;
  final VoidCallback? onSkipPressed;

  const JobDetailsHeaderSection({
    super.key,
    required this.title,
    this.onSkipPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        onSkipPressed != null
            ? TextButton(onPressed: onSkipPressed, child: Text(AppLocalizations.of(context).skip))
            : const SizedBox.shrink(),
      ],
    );
  }
}
