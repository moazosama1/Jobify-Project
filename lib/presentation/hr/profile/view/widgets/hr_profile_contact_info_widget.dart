import 'package:flutter/material.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/core/widgets/custom_text_field.dart';
import 'package:jobify_project/generated/l10n.dart';

class HrProfileContactInfoWidget extends StatefulWidget {
  final String name;
  final String email;
  final String phoneNumber;
  final Function(String name, String email, String phoneNumber)? onSave;

  const HrProfileContactInfoWidget({
    super.key,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.onSave,
  });

  @override
  State<HrProfileContactInfoWidget> createState() =>
      _HrProfileContactInfoWidgetState();
}

class _HrProfileContactInfoWidgetState extends State<HrProfileContactInfoWidget> {
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
  void didUpdateWidget(covariant HrProfileContactInfoWidget oldWidget) {
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
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          local.contactInfo,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppMeasurements.paddingMedium),
        CustomTextField(
          controller: _nameController,
          label: local.fullName,
          hintText: local.typeYourName,
          prefixIcon: Icon(
            Icons.person_outline,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: AppMeasurements.paddingMedium),
        CustomTextField(
          controller: _emailController,
          label: local.email,
          hintText: local.typeYourEmail,
          prefixIcon: Icon(
            Icons.email_outlined,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: AppMeasurements.paddingMedium),
        CustomTextField(
          controller: _phoneController,
          label: local.phoneNumber,
          hintText: local.phoneNumber,
          prefixIcon: Icon(
            Icons.phone_android_outlined,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
