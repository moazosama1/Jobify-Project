import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jobify_project/core/responsive/app_measurements.dart';
import 'package:jobify_project/generated/l10n.dart';

class JobDetailsRequirementsSection extends StatelessWidget {
  final String description;
  final List<String> requirements;
  final List<String> skillsRequired;
  final List<String> responsibilities;
  final String category;
  final String employmentType;
  final String experienceLevel;
  final String applicationDeadline;
  final String location;
  final String salary;
  final VoidCallback onApplyPressed;

  const JobDetailsRequirementsSection({
    super.key,
    required this.description,
    required this.requirements,
    required this.skillsRequired,
    required this.responsibilities,
    required this.category,
    required this.employmentType,
    required this.experienceLevel,
    required this.applicationDeadline,
    required this.location,
    required this.salary,
    required this.onApplyPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);

    String formattedDeadline = applicationDeadline;
    try {
      final date = DateTime.parse(applicationDeadline);
      formattedDeadline = DateFormat('dd MMM yyyy').format(date);
    } catch (_) {}

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _InfoTile(title: local.category, value: category),
            ),
            Expanded(
              child: _InfoTile(title: local.typeLabel, value: employmentType),
            ),
          ],
        ),
        const SizedBox(height: AppMeasurements.paddingMedium),
        Row(
          children: [
            Expanded(
              child: _InfoTile(title: local.experience, value: experienceLevel),
            ),
            Expanded(
              child: _InfoTile(
                title: local.deadlineLabel,
                value: formattedDeadline,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppMeasurements.paddingMedium),
        Row(
          children: [
            Expanded(
              child: _InfoTile(title: local.location, value: location),
            ),
            Expanded(
              child: _InfoTile(title: local.salary, value: salary),
            ),
          ],
        ),
        const SizedBox(height: AppMeasurements.paddingLarge),
        Text(
          local.aboutTheRole,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppMeasurements.paddingSmall),
        Text(
          description,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
            height: 1.5,
          ),
        ),
        const SizedBox(height: AppMeasurements.paddingLarge),
        Text(
          local.requirementSkillForTheRole,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppMeasurements.paddingSmall),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: requirements.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppMeasurements.paddingExtraSmall,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: AppMeasurements.paddingSmall),
                  Expanded(
                    child: Text(item, style: theme.textTheme.bodyMedium),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        if (skillsRequired.isNotEmpty) ...[
          const SizedBox(height: AppMeasurements.paddingLarge),
          Text(
            local.skillsRequiredLabel,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppMeasurements.paddingSmall),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skillsRequired
                .map(
                  (skill) => Chip(
                    label: Text(skill),
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                    side: BorderSide.none,
                  ),
                )
                .toList(),
          ),
        ],
        if (responsibilities.isNotEmpty) ...[
          const SizedBox(height: AppMeasurements.paddingLarge),
          Text(
            local.responsibilitiesLabel,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppMeasurements.paddingSmall),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: responsibilities.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppMeasurements.paddingExtraSmall,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(top: 6),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppMeasurements.paddingSmall),
                    Expanded(
                      child: Text(item, style: theme.textTheme.bodyMedium),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
        const SizedBox(height: AppMeasurements.paddingLarge),
        SizedBox(
          width: double.infinity,
          height: AppMeasurements.buttonHeight,
          child: ElevatedButton(
            onPressed: onApplyPressed,

            child: Text(local.applyThisJob),
          ),
        ),
        const SizedBox(height: AppMeasurements.paddingLarge),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const _InfoTile({required this.title, required this.value});

  String _localizeValue(BuildContext context, String val) {
    final local = AppLocalizations.of(context);
    switch (val.toLowerCase()) {
      case 'full time':
      case 'full-time':
        return local.categoryFullTime;
      case 'part time':
      case 'part-time':
        return local.categoryPartTime;
      case 'freelance':
        return local.categoryFreelance;
      case 'company':
        return local.categoryCompany;
      case 'remote':
        return local.remote;
      case 'internship':
        return local.internship;
      case 'contract':
        return local.contract;
      case 'junior':
        return local.junior;
      case 'mid level':
      case 'mid-level':
        return local.midLevel;
      case 'senior':
        return local.senior;
      case 'lead':
        return local.lead;
      case 'expert':
        return local.expert;
      default:
        return val;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);
    final displayValue = _localizeValue(context, value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          displayValue.isNotEmpty ? displayValue : local.notAvailable,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
