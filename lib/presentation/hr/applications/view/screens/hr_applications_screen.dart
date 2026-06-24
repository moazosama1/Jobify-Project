import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobify_project/core/di/di.dart';
import 'package:jobify_project/core/widgets/custom_screen_wrapper.dart';
import 'package:jobify_project/presentation/hr/applications/view_model/hr_applications_cubit.dart';
import 'widgets/hr_applications_view_body.dart';

class HrApplicationsScreen extends StatelessWidget {
  const HrApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => getIt<HrApplicationsCubit>(),
        child: const CustomScreenWrapper(
          body: HrApplicationsViewBody(),
        ),
      ),
    );
  }
}
