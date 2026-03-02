import 'package:flutter/material.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_loading_indicator.dart';

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
    this.elevation,
    this.isLoading = false,
  });

  final bool? isLoading;
  final double? heightButton, widthButton, borderButton, elevation;
  final String? textButton;
  final TextStyle? textStyleButton;
  final Color? colorButton, loadingColor;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);
    return SizedBox(
      height: heightButton ?? AppMeasurements.buttonHeight,
      width: widthButton,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorButton ?? theme.colorScheme.primary,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderButton ?? AppMeasurements.paddingMedium,
            ),
          ),
        ),
        child: isLoading == true
            ? CustomLoadingIndicator(
                color: loadingColor ?? theme.colorScheme.onSecondary,
                size: AppMeasurements.buttonHeight * 0.6,
              )
            : Text(textButton ?? local.done, style: textStyleButton),
      ),
    );
  }
}
