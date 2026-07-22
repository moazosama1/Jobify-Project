import 'package:jobify_project/api/models/create_job_response.dart';
import 'package:jobify_project/api/models/requests/create_job_request_model.dart';
import 'package:jobify_project/api/models/get_my_jobs_response.dart';
import 'package:jobify_project/api/models/get_job_applications_response.dart';
import 'package:jobify_project/api/models/get_my_applications_response.dart';
import 'package:jobify_project/api/models/get_application_stats_response.dart';
import 'package:jobify_project/api/models/apply_job_response.dart';
import 'dart:io';

import 'package:jobify_project/api/models/get_all_jobs_response.dart';
import 'package:jobify_project/domain/entities/requests/get_all_jobs_request_entity.dart';
import 'package:jobify_project/api/models/get_job_by_id_response.dart';
import 'package:jobify_project/api/models/get_saved_jobs_response.dart';
import 'package:jobify_project/api/models/toggle_saved_job_response.dart';

abstract interface class JobRemoteDataSource {
  Future<CreateJobResponse> createJob(CreateJobRequestModel request, File? logoFile);
  Future<GetMyJobsResponse> getMyJobs();
  Future<CreateJobResponse> updateJob(String id, Map<String, dynamic> request);
  Future<CreateJobResponse> deleteJob(String id);
  Future<GetJobApplicationsResponse> getJobApplications(String jobId);
  Future<GetJobApplicationsResponse> getAllApplications();
  Future<GetJobApplicationsResponse> updateApplicationStatus(String id, Map<String, dynamic> request);
  Future<GetAllJobsResponse> getAllJobs(GetAllJobsRequestEntity request);
  Future<GetJobByIdResponse> getJobById(String id);
  Future<GetSavedJobsResponse> getSavedJobs();
  Future<ToggleSavedJobResponse> saveJob(String id);
  Future<ToggleSavedJobResponse> removeSavedJob(String id);
  Future<ApplyJobResponse> applyJob({
    required String jobId,
    required File resumeFile,
    String? coverLetter,
  });
  Future<GetMyApplicationsResponse> getMyApplications({
    int? page,
    int? limit,
    String? status,
  });
  Future<GetApplicationStatsResponse> getApplicationStats();
}
