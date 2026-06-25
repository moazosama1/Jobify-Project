import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/api/models/get_job_applications_response.dart';
import 'package:jobify_project/api/models/get_my_applications_response.dart';
import 'package:jobify_project/api/models/get_application_stats_response.dart';
import 'package:jobify_project/api/models/apply_job_response.dart';
import 'package:jobify_project/api/models/login_response.dart';
import 'package:jobify_project/api/models/requests/login_request_dto.dart';
import 'package:jobify_project/api/models/requests/signup_request.dart';
import 'package:jobify_project/api/models/get_user_profile_response.dart';
import 'package:jobify_project/api/models/signup_response.dart';
import 'package:jobify_project/api/models/requests/confirm_email_request.dart';
import 'package:jobify_project/api/models/confirm_email_response.dart';
import 'package:jobify_project/api/models/requests/forget_password_request.dart';
import 'package:jobify_project/api/models/forget_password_response.dart';
import 'package:jobify_project/api/models/requests/reset_password_request.dart';
import 'package:jobify_project/api/models/reset_password_response.dart';
import 'package:jobify_project/api/models/create_job_response.dart';
import 'package:jobify_project/api/models/requests/create_job_request_model.dart';
import 'package:jobify_project/api/models/get_all_jobs_response.dart';
import 'package:jobify_project/api/models/get_job_by_id_response.dart';
import 'package:jobify_project/api/models/get_my_jobs_response.dart';
import 'package:jobify_project/api/models/get_saved_jobs_response.dart';
import 'package:jobify_project/api/models/toggle_saved_job_response.dart';
import 'package:jobify_project/core/constants/end_points.dart';
import 'package:retrofit/retrofit.dart';
import 'dart:io';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(EndPoints.signIn)
  Future<LoginResponse> login(@Body() LoginRequestDto request);

  @POST(EndPoints.signup)
  Future<SignUPResponse> signup(@Body() SignUpRequest request);

  @POST(EndPoints.confirmEmail)
  Future<ConfirmEmailResponse> confirmEmail(
    @Body() ConfirmEmailRequest request,
  );
 

  @PATCH(EndPoints.forgetPassword)
  Future<ForgetPasswordResponse> forgetPassword(@Body() ForgetPasswordRequest request);

  @PATCH(EndPoints.resetPassword)
  Future<ResetPasswordResponse> resetPassword(@Body() ResetPasswordRequest request);

  @POST(EndPoints.createJob)
  Future<CreateJobResponse> createJob(@Body() CreateJobRequestModel request);

  @GET(EndPoints.getJobs)
  Future<GetAllJobsResponse> getAllJobs(
    @Queries() Map<String, dynamic> queries,
  );

  @GET(EndPoints.getJobById)
  Future<GetJobByIdResponse> getJobById(@Path('id') String id);

  @GET(EndPoints.getMyJobs)
  Future<GetMyJobsResponse> getMyJobs(
    @Query('page') int? page,
    @Query('limit') int? limit,
  );

  @GET(EndPoints.getSavedJobs)
  Future<GetSavedJobsResponse> getSavedJobs();

  @POST('${EndPoints.saveJobs}/{id}')
  Future<ToggleSavedJobResponse> saveJob(@Path('id') String id);

  @DELETE('${EndPoints.removeSaveJobs}/{id}')
  Future<ToggleSavedJobResponse> removeSavedJob(@Path('id') String id);

  @POST(EndPoints.logOut)
  Future<dynamic> logout(@Body() Map<String, dynamic> body);

  @GET(EndPoints.getProfile)
  Future<GetUserProfileResponse> getProfile();

  @PUT(EndPoints.updateProfile)
  Future<GetUserProfileResponse> updateBasicInfo(@Body() Map<String, dynamic> request);

  @POST(EndPoints.addExp)
  Future<GetUserProfileResponse> addExperience(@Body() Map<String, dynamic> request);

  @PUT("${EndPoints.updateEx}/{id}")
  Future<GetUserProfileResponse> updateExperience(@Path("id") String id, @Body() Map<String, dynamic> request);

  @DELETE("${EndPoints.deleteEx}/{id}")
  Future<GetUserProfileResponse> deleteExperience(@Path("id") String id);

  @POST(EndPoints.addEd)
  Future<GetUserProfileResponse> addEducation(@Body() Map<String, dynamic> request);

  @PUT("${EndPoints.updateEd}/{id}")
  Future<GetUserProfileResponse> updateEducation(@Path("id") String id, @Body() Map<String, dynamic> request);

  @DELETE("${EndPoints.deleteEd}/{id}")
  Future<GetUserProfileResponse> deleteEducation(@Path("id") String id);

  @PUT(EndPoints.udateSkills)
  Future<GetUserProfileResponse> updateSkills(@Body() Map<String, dynamic> request);

  @POST(EndPoints.uploadResume)
  @MultiPart()
  Future<GetUserProfileResponse> uploadResume(@Part(name: "resume") File file);

  @PUT("${EndPoints.updataJob}{id}")
  Future<CreateJobResponse> updateJob(
    @Path("id") String id,
    @Body() Map<String, dynamic> request,
  );

  @DELETE("jobs/{id}")
  Future<CreateJobResponse> deleteJob(@Path("id") String id);

  @GET("${EndPoints.getApplicationForEmployee}{id}")
  Future<GetJobApplicationsResponse> getJobApplications(@Path("id") String id);

  @PUT("job-applications/{id}/status")
  Future<GetJobApplicationsResponse> updateApplicationStatus(@Path("id") String id, @Body() Map<String, dynamic> request);

  @POST("${EndPoints.applyJob}/{jobId}")
  @MultiPart()
  Future<ApplyJobResponse> applyJob(
    @Path("jobId") String jobId,
    @Part(name: "resume") File file,
    @Part(name: "coverLetter") String? coverLetter,
  );

  @GET(EndPoints.getMyApplications)
  Future<GetMyApplicationsResponse> getMyApplications(
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('status') String? status,
  );

  @GET(EndPoints.getApplicationStats)
  Future<GetApplicationStatsResponse> getApplicationStats();
}
