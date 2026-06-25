sealed class ApplyJobEvents {}

class SelectResumeApplyJobEvent extends ApplyJobEvents {
  final String resumeFilePath;
  SelectResumeApplyJobEvent(this.resumeFilePath);
}

class InputCoverLetterApplyJobEvent extends ApplyJobEvents {
  final String coverLetter;
  InputCoverLetterApplyJobEvent(this.coverLetter);
}

class SubmitApplyJobEvent extends ApplyJobEvents {
  final String jobId;
  SubmitApplyJobEvent(this.jobId);
}
