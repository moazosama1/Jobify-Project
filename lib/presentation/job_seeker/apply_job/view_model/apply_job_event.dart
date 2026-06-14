import 'package:file_picker/file_picker.dart';

abstract class ApplyJobEvent {}

class CvFilePickedEvent extends ApplyJobEvent {
  final PlatformFile cvFile;
  CvFilePickedEvent(this.cvFile);
}

class SubmitJobApplicationEvent extends ApplyJobEvent {
  final String fullName;
  final String portfolioUrl;
  final String motivationalLetter;

  SubmitJobApplicationEvent({
    required this.fullName,
    required this.portfolioUrl,
    required this.motivationalLetter,
  });
}
