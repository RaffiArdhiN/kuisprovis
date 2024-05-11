abstract class AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String username;
  final String password;

  AuthLoginRequested(this.username, this.password);
}

class AuthRegisterRequested extends AuthEvent {
  final String username;
  final String password;

  AuthRegisterRequested(this.username, this.password);
}
