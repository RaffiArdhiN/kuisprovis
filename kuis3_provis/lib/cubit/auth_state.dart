abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoggedIn extends AuthState {
  final String token;

  AuthLoggedIn(this.token);
}

class AuthSuccess extends AuthState {
  final String message;

  AuthSuccess(this.message);
}

class AuthError extends AuthState {
  final String errorMessage;

  AuthError(this.errorMessage);
}
