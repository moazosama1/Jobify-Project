import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/company_snapshot_entity.dart';
import 'package:jobify_project/domain/entities/create_job_request_entity.dart';
import 'package:jobify_project/domain/entities/salary_range_entity.dart';
import 'package:jobify_project/domain/use_cases/create_job_use_case.dart';
import 'hr_hiring_post_event.dart';
import 'hr_hiring_post_state.dart';

@injectable
class HrHiringPostCubit extends Cubit<HrHiringPostState> {
  final CreateJobUseCase _createJobUseCase;

  HrHiringPostCubit(this._createJobUseCase) : super(const HrHiringPostState());

  void doIntent(HrHiringPostEvent event) {
    switch (event) {
      case final HrHiringPostSubmitEvent submitEvent:
        _onSubmitPost(submitEvent);
        break;
    }
  }

  Future<void> _onSubmitPost(HrHiringPostSubmitEvent event) async {
    emit(state.copyWith(createJobStatus: BaseState.loading()));

    final responsibilitiesList = event.responsibilities
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final requirementsList = event.requirements
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final preferredQualificationsList = event.preferredQualifications
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final skillsRequiredList = event.skillsRequired
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final request = CreateJobRequestEntity(
      companySnapshot: CompanySnapshotEntity(
        name: event.companyName,
        logo: event.companyLogo,
      ),
      title: event.title,
      description: event.description,
      responsibilities: responsibilitiesList,
      requirements: requirementsList,
      preferredQualifications: preferredQualificationsList,
      location: event.location,
      employmentType: event.employmentType,
      experienceLevel: event.experienceLevel,
      salaryRange: SalaryRangeEntity(
        min: event.salaryMin,
        max: event.salaryMax,
      ),
      applicationDeadline: event.applicationDeadline,
      skillsRequired: skillsRequiredList,
      category: event.category,
      openings: event.openings,
      isRemote: event.isRemote,
    );

    final result = await _createJobUseCase(request);

    switch (result) {
      case ApiSuccessResult(:final data):
        emit(state.copyWith(
          createJobStatus: BaseState.success(data),
        ));
        break;
      case ApiErrorResult(:final error):
        emit(state.copyWith(
          createJobStatus: BaseState.error(error.toString()),
        ));
        break;
    }
  }
}
