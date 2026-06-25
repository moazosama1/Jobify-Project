abstract class EndPoints {
  // for moo
  // static const String baseUrl = "http://192.168.1.7:3000/";
  // for anas
  static const String baseUrl = "http://192.168.1.14:3000/";

  // AWS S3 Base URL
  static const String awsBaseUrl =
      "https://mahy-s3-bucket-2025.s3.us-east-1.amazonaws.com/";

  ///User
  ///
  static const String signup = "users/signUp";
  static const String signIn = "users/signIn";
  static const String confirmEmail = "users/confirmEmail";
  static const String forgetPassword = "users/forgetPassword";
  static const String resetPassword = "users/resetPassword";
  static const String logOut = "users/logOut";
  static const String getProfile = "users/getProfile";
  static const String updateProfile = "users/updateBasicInfo";
  static const String addExp = "users/addExperiance";
  static const String deleteEx = "users/deleteExperiance";
  static const String updateEx = "users/updateExperiance";
  static const String addEd = "users/addEducation";
  static const String updateEd = "users/updateEducation";
  static const String deleteEd = "users/deleteEducation";
  static const String uploadResume = "users/uploadResume";
  static const String udateSkills = "users/updateSkills";
  static const String getSavedJobs = "users/getSavedJobs";
  static const String saveJobs = "users/saveJob";
  static const String removeSaveJobs = "users/removeSavedJob";
  static const String createJob = "jobs/create";
  static const String getJobs = "jobs/get-all";
  static const String getJobById = "jobs/{id}";
  static const String getMyJobs = "jobs/my-jobs";
  static const String updataJob = "jobs/";
  static const String deleteJob = "jobs/hard-delete";
  static const String saveJob = "jobs/hard-delete";
  static const String getApplicationForEmployee = "job-applications/job/";
  static const String applyJob = "job-applications/apply";
  static const String getMyApplications = "job-applications/my-applications";
  static const String getApplicationStats = "job-applications/stats";
  static const String getProfileById = "job-applications/stats";


}
