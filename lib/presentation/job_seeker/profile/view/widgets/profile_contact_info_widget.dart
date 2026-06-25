import 'package:flutter/material.dart';
import 'package:jobify_project/core/constants/app_colors.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_text_field.dart';
import 'package:jobify_project/core/extensions/theme_context_extension.dart';
import 'package:jobify_project/core/extensions/l10n_extension.dart';

class ProfileContactInfoWidget extends StatefulWidget {
  final String name;
  final String email;
  final String phoneNumber;
  final Function(String name, String email, String phoneNumber)? onSave;

  const ProfileContactInfoWidget({
    super.key,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.onSave,
  });

  @override
  State<ProfileContactInfoWidget> createState() =>
      _ProfileContactInfoWidgetState();
}

class _ProfileContactInfoWidgetState extends State<ProfileContactInfoWidget> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phoneNumber);
  }

  @override
  void didUpdateWidget(covariant ProfileContactInfoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.name != widget.name) {
      _nameController.text = widget.name;
    }
    if (oldWidget.email != widget.email) {
      _emailController.text = widget.email;
    }
    if (oldWidget.phoneNumber != widget.phoneNumber) {
      _phoneController.text = widget.phoneNumber;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = context.l10n;
    final isDark = context.theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.contact_mail_outlined,
              color: context.primaryColor,
              size: 22,
            ),
            const SizedBox(width: AppMeasurements.paddingSmall),
            Text(
              local.contactInfo,
              style: context.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.onSurfaceColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppMeasurements.paddingSmall),
        Container(
          padding: const EdgeInsets.all(AppMeasurements.paddingMedium),
          decoration: BoxDecoration(
            color: isDark ? context.surfaceColor : AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: context.onSurfaceColor.withValues(alpha: 0.05),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: context.theme.shadowColor.withValues(alpha: 0.04),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              CustomTextField(
                controller: _nameController,
                label: local.fullName,
                hintText: local.typeYourName,
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: context.onSurfaceColor.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: AppMeasurements.paddingMedium),
              CustomTextField(
                controller: _emailController,
                label: local.email,
                hintText: local.typeYourEmail,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: context.onSurfaceColor.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: AppMeasurements.paddingMedium),
              CustomTextField(
                controller: _phoneController,
                label: local.phoneNumber,
                hintText: local.phoneNumber,
                prefixIcon: Icon(
                  Icons.phone_android_outlined,
                  color: context.onSurfaceColor.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
