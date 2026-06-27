import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/di/di.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/generated/l10n.dart';
import 'package:jobify_project/presentation/hr/job_applications/view_model/hr_job_applications_cubit.dart';
import 'package:jobify_project/presentation/hr/job_applications/view_model/hr_job_applications_event.dart';
import 'package:jobify_project/presentation/hr/job_applications/view/widgets/hr_job_applications_view_body.dart';

class HrApplicationsScreen extends StatelessWidget {
  const HrApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return Scaffold(
      body: BlocProvider(
        create: (_) => getIt<HrJobApplicationsCubit>()..doIntent(const LoadHrJobApplicationsEvent('')),
        child: CustomScreenWrapper(
          body: HrJobApplicationsViewBody(
            jobTitle: local.incomingApplications,
            showBackButton: false,
          ),
        ),
      ),
    );
  }
}
