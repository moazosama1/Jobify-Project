abstract class LoginEvent {}

class LoginSubmittedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginSubmittedEvent({required this.email, required this.password});
}

class GoogleLoginClickedEvent extends LoginEvent {}

class ToggleRememberMeEvent extends LoginEvent {
  final bool value;
  ToggleRememberMeEvent(this.value);
}
