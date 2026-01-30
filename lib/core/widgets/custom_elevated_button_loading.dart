import 'package:flutter/material.dart';
import 'package:jobify_project/generated/l10n.dart';

class CustomElevatedButtonLoading extends StatelessWidget {
  const CustomElevatedButtonLoading({
    super.key,
    this.heightButton,
    this.widthButton,
    this.borderButton,
    this.textButton,
    this.textStyleButton,
    this.colorButton,
    this.onPressed,
    this.loadingColor,
    this.isLoading = false,
  });

  final bool? isLoading;
  final double? heightButton, widthButton, borderButton;
  final String? textButton;
  final TextStyle? textStyleButton;
  final Color? colorButton, loadingColor;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);
    return SizedBox(
      height: heightButton ?? 40,
      width: widthButton,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorButton ?? theme.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderButton ?? 8),
          ),
        ),
        child: isLoading == true
            ? CircularProgressIndicator(
                color: loadingColor ?? theme.colorScheme.onSecondary,
                strokeWidth: 3,
                padding: const EdgeInsets.symmetric(vertical: 3),
                trackGap: 4,
              )
            : Text(textButton ?? local.done, style: textStyleButton),
      ),
    );
  }
}
