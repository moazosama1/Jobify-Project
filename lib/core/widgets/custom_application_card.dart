import 'package:flutter/material.dart';
import 'package:jobify_project/core/constants/app_colors.dart';

enum ApplicationStatus { onTheWay, delivered, canceled }

class CustomJobApplicationCard extends StatelessWidget {
  final String jobTitle;
  final String companyName;
  final String salary;
  final String location;
  final String logoUrl; 
  final ApplicationStatus status;
  final VoidCallback onViewApplication;

  const CustomJobApplicationCard({
    Key? key,
    required this.jobTitle,
    required this.companyName,
    required this.salary,
    required this.location,
    required this.logoUrl,
    required this.status,
    required this.onViewApplication,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // تحديد ألوان الـ Status Button بناءً على الحالة
    Color statusBgColor;
    Color statusTextColor;
    String statusText;

    switch (status) {
      case ApplicationStatus.onTheWay:
        statusBgColor = AppColors.brandLight;
        statusTextColor = AppColors.brandDefault;
        statusText = 'On the way';
        break;
      case ApplicationStatus.delivered:
        statusBgColor = AppColors.gray.withValues(alpha: 0.1);
        statusTextColor = AppColors.gray;
        statusText = 'Delivered';
        break;
      case ApplicationStatus.canceled:
        statusBgColor = AppColors.lightPink;
        statusTextColor = AppColors.red;
        statusText = 'Canceled';
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Company Logo Container
              Container(
                width: 48,
                height: 48,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.gray.withValues(alpha: 0.1),
                  ),
                ),
                child: logoUrl.startsWith('http')
                    ? Image.network(
                        logoUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.business),
                      )
                    : Image.asset(
                        logoUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.business),
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      jobTitle,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          companyName,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.gray),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: .center,
            children: [
              _buildInfoChip(context, Icons.payments_outlined, salary),
              const SizedBox(width: 16),
              _buildInfoChip(context, Icons.location_on_outlined, location),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusTextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // زر View Application
              Expanded(
                child: InkWell(
                  onTap: onViewApplication,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor[10],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'View Application',
                      style: TextStyle(
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.gray),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.gray),
        ),
      ],
    );
  }
}
