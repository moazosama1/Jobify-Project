import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/api_result/api_result.dart';
import 'package:jobify_project/core/api_result/base_state.dart';
import 'package:jobify_project/domain/entities/company_snapshot_entity.dart';
import 'package:jobify_project/domain/entities/create_job_request_entity.dart';
import 'package:jobify_project/domain/entities/create_job_response_entity.dart';
import 'package:jobify_project/domain/entities/salary_range_entity.dart';
import 'package:jobify_project/domain/use_cases/create_job_use_case.dart';
import 'package:jobify_project/domain/use_cases/update_job_use_case.dart';
import 'package:jobify_project/domain/use_cases/auth/get_user_profile_use_case.dart';
import 'package:jobify_project/domain/entities/user_entity.dart';
import 'hr_hiring_post_event.dart';
import 'hr_hiring_post_state.dart';

@injectable
class HrHiringPostCubit extends Cubit<HrHiringPostState> {
  final CreateJobUseCase _createJobUseCase;
  final UpdateJobUseCase _updateJobUseCase;
  final GetUserProfileUseCase _getUserProfileUseCase;

  HrHiringPostCubit(
    this._createJobUseCase,
    this._updateJobUseCase,
    this._getUserProfileUseCase,
  ) : super(const HrHiringPostState()) {
    _init();
  }

  void _init() {
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final result = await _getUserProfileUseCase();
    if (result is ApiSuccessResult<UserEntity>) {
      emit(state.copyWith(userProfileImage: result.data.profileImage));
    }
  }

  void doIntent(HrHiringPostEvent event) {
    switch (event) {
      case final HrHiringPostSubmitEvent submitEvent:
        _onSubmitPost(submitEvent);
        break;
      case final HrHiringPostUpdateEvent updateEvent:
        _onUpdateJob(updateEvent);
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

  Future<void> _onUpdateJob(HrHiringPostUpdateEvent event) async {
    final Map<String, dynamic> requestBody = {};

    bool areListsEqual(List<String> a, List<String> b) {
      if (a.length != b.length) return false;
      for (int i = 0; i < a.length; i++) {
        if (a[i] != b[i]) return false;
      }
      return true;
    }

    final original = event.originalJob;

    if (event.title != original.title) {
      requestBody['title'] = event.title;
    }
    if (event.description != original.description) {
      requestBody['description'] = event.description;
    }
    if (event.location != original.location) {
      requestBody['location'] = event.location;
    }
    if (event.employmentType != original.employmentType) {
      requestBody['employmentType'] = event.employmentType;
    }
    if (event.experienceLevel != original.experienceLevel) {
      requestBody['experienceLevel'] = event.experienceLevel;
    }
    if (event.category != original.category) {
      requestBody['category'] = event.category;
    }
    if (event.openings != original.openings) {
      requestBody['openings'] = event.openings;
    }
    if (event.isRemote != original.isRemote) {
      requestBody['isRemote'] = event.isRemote;
    }

    if (event.companyName != original.companyName || event.companyLogo != original.logoAsset) {
      requestBody['companySnapshot'] = {
        'name': event.companyName,
        'logo': event.companyLogo,
      };
    }

    if (event.salaryMin != original.salaryMin || event.salaryMax != original.salaryMax) {
      requestBody['salaryRange'] = {
        'min': event.salaryMin,
        'max': event.salaryMax,
      };
    }

    final originalDeadline = original.applicationDeadline.length >= 10
        ? original.applicationDeadline.substring(0, 10)
        : original.applicationDeadline;
    if (event.applicationDeadline != originalDeadline) {
      requestBody['applicationDeadline'] = event.applicationDeadline;
    }

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

    if (!areListsEqual(responsibilitiesList, original.responsibilities)) {
      requestBody['responsibilities'] = responsibilitiesList;
    }
    if (!areListsEqual(requirementsList, original.requirements)) {
      requestBody['requirements'] = requirementsList;
    }
    if (!areListsEqual(preferredQualificationsList, original.preferredQualifications)) {
      requestBody['preferredQualifications'] = preferredQualificationsList;
    }
    if (!areListsEqual(skillsRequiredList, original.skillsRequired)) {
      requestBody['skillsRequired'] = skillsRequiredList;
    }

    if (requestBody.isEmpty) {
      emit(state.copyWith(
        createJobStatus: BaseState.success(const CreateJobResponseEntity(message: 'No changes detected')),
      ));
      return;
    }

    emit(state.copyWith(createJobStatus: BaseState.loading()));

    final result = await _updateJobUseCase(event.jobId, requestBody);

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
