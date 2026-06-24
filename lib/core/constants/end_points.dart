abstract class EndPoints {
  static const String baseUrl = "http://192.168.1.14:3000/";

  ///User
  ///
  static const String signup = "users/signUp";
  static const String signIn = "users/signIn";
  static const String confirmEmail = "users/confirmEmail";
  static const String forgetPassward = "users/forgetPassword";
  static const String resetPassward = "users/resetPassword";
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
  static const String getMyJobs = "jobs/my-jobs";
  static const String updataJob = "jobs/";
  static const String deleteJob = "jobs/hard-delete";
  static const String saveJob = "jobs/hard-delete";
  static const String getApplicationForEmployee = "job-applications/job/";
}
