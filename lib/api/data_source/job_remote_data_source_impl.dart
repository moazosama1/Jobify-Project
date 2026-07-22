import 'package:injectable/injectable.dart';
import 'package:jobify_project/api/client/api_client.dart';
import 'package:jobify_project/api/models/create_job_response.dart';
import 'package:jobify_project/api/models/requests/create_job_request_model.dart';
import 'package:jobify_project/api/models/get_my_jobs_response.dart';
import 'package:jobify_project/api/models/get_all_jobs_response.dart';
import 'package:jobify_project/domain/entities/requests/get_all_jobs_request_entity.dart';
import 'package:jobify_project/api/models/get_job_by_id_response.dart';
import 'package:jobify_project/api/models/get_saved_jobs_response.dart';
import 'package:jobify_project/api/models/toggle_saved_job_response.dart';
import 'package:jobify_project/api/models/get_job_applications_response.dart';
import 'package:jobify_project/api/models/get_my_applications_response.dart';
import 'package:jobify_project/api/models/get_application_stats_response.dart';
import 'package:jobify_project/api/models/apply_job_response.dart';
import 'package:jobify_project/data/data_source/job_remote_data_source.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

@Injectable(as: JobRemoteDataSource)
class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final ApiClient _apiClient;

  JobRemoteDataSourceImpl(this._apiClient);

  @override
  Future<CreateJobResponse> createJob(CreateJobRequestModel request, File? logoFile) async {
    MultipartFile? multipartFile;
    if (logoFile != null) {
      final ext = logoFile.path.split('.').last.toLowerCase();
      final MediaType mediaType;
      if (ext == 'png') {
        mediaType = MediaType('image', 'png');
      } else if (ext == 'gif') {
        mediaType = MediaType('image', 'gif');
      } else if (ext == 'webp') {
        mediaType = MediaType('image', 'webp');
      } else if (ext == 'jpg' || ext == 'jpeg') {
        mediaType = MediaType('image', 'jpeg');
      } else if (ext == 'bmp') {
        mediaType = MediaType('image', 'bmp');
      } else if (ext == 'heic' || ext == 'heif') {
        mediaType = MediaType('image', 'heic');
      } else {
        mediaType = MediaType('image', 'jpeg');
      }

      multipartFile = await MultipartFile.fromFile(
        logoFile.path,
        filename: logoFile.path.split(RegExp(r'[/\\]')).last,
        contentType: mediaType,
      );
    }

    return _apiClient.createJob(
      request.title,
      request.description,
      request.responsibilities,
      request.requirements,
      request.preferredQualifications,
      request.location,
      request.employmentType,
      request.experienceLevel,
      request.salaryRange.min,
      request.salaryRange.max,
      request.applicationDeadline,
      request.skillsRequired,
      request.category,
      request.openings,
      request.isRemote,
      request.companySnapshot.name??"",
      multipartFile,
    );
  }

  @override
  Future<GetMyJobsResponse> getMyJobs({int? page, int? limit}) {
    return _apiClient.getMyJobs(page, limit);
  }

  @override
  Future<GetAllJobsResponse> getAllJobs(GetAllJobsRequestEntity request) {
    return _apiClient.getAllJobs(request.toMap());
  }

  @override
  Future<GetJobByIdResponse> getJobById(String id) {
    return _apiClient.getJobById(id);
  }

  @override
  Future<GetSavedJobsResponse> getSavedJobs() {
    return _apiClient.getSavedJobs();
  }

  @override
  Future<ToggleSavedJobResponse> saveJob(String id) {
    return _apiClient.saveJob(id);
  }

  @override
  Future<ToggleSavedJobResponse> removeSavedJob(String id) {
    return _apiClient.removeSavedJob(id);
  }

  @override
  Future<CreateJobResponse> updateJob(String id, Map<String, dynamic> request) {
    return _apiClient.updateJob(id, request);
  }

  @override
  Future<CreateJobResponse> deleteJob(String id) {
    return _apiClient.deleteJob(id);
  }

  @override
  Future<GetJobApplicationsResponse> getJobApplications(String jobId) {
    return _apiClient.getJobApplications(jobId);
  }

  @override
  Future<GetJobApplicationsResponse> getAllApplications() {
    return _apiClient.getAllApplications();
  }

  @override
  Future<GetJobApplicationsResponse> updateApplicationStatus(String id, Map<String, dynamic> request) {
    return _apiClient.updateApplicationStatus(id, request);
  }

  @override
  Future<ApplyJobResponse> applyJob({
    required String jobId,
    required File resumeFile,
    String? coverLetter,
  }) {
    return _apiClient.applyJob(jobId, resumeFile, coverLetter);
  }

  @override
  Future<GetMyApplicationsResponse> getMyApplications({
    int? page,
    int? limit,
    String? status,
  }) {
    return _apiClient.getMyApplications(page, limit, status);
  }

  @override
  Future<GetApplicationStatsResponse> getApplicationStats() {
    return _apiClient.getApplicationStats();
  }
}
