sealed class UserProfileEvent {}

class LoadUserProfileEvent extends UserProfileEvent {
  final String userId;
  LoadUserProfileEvent(this.userId);
}
