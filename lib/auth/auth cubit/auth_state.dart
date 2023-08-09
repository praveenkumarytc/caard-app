abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final String? userId;
  AuthenticationSuccess(this.userId);
}

class AuthenticationFailure extends AuthenticationState {
  final String? error;
  AuthenticationFailure(this.error);
}
