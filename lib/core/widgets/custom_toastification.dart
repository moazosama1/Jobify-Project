import 'package:flutter/material.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:toastification/toastification.dart';

void customToastification(
  BuildContext context,
  ToastificationType type,
  String? message,
) {
  final defaultMessage =
      message ??
      (type == ToastificationType.success
          ? AppLocalizations.of(context).success
          : AppLocalizations.of(context).error);

  final Color primaryColor = type == ToastificationType.success
      ? const Color(0xFF0CB359)
      : type == ToastificationType.error
          ? const Color(0xffCC1010)
          : type == ToastificationType.warning
              ? const Color(0xFFE6A23C)
              : const Color(0xFF286AFF);

  final Color backgroundColor = context.theme.brightness == Brightness.dark
      ? const Color(0xFF1E222B)
      : Colors.white;

  final Color foregroundColor = context.theme.brightness == Brightness.dark
      ? Colors.white
      : const Color(0xFF1E222B);

  toastification.show(
    context: context,
    type: type,
    style: ToastificationStyle.flat,
    title: Text(
      defaultMessage,
      style: context.bodyMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: foregroundColor,
      ),
    ),
    alignment: Alignment.topCenter,
    autoCloseDuration: const Duration(seconds: 3),
    animationDuration: const Duration(milliseconds: 300),
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.2),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      );
    },
    primaryColor: primaryColor,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    borderRadius: BorderRadius.circular(16),
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    showProgressBar: true,
    progressBarTheme: ProgressIndicatorThemeData(
      color: primaryColor,
      linearMinHeight: 3,
    ),
    closeButton: const ToastCloseButton(showType: CloseButtonShowType.always),
    closeOnClick: false,
    pauseOnHover: true,
    dragToClose: true,
    applyBlurEffect: false,
  );
}
