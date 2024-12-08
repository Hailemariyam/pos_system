// auth_event.dart
abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthLoginEvent({required this.email, required this.password});
}

class AuthLogoutEvent extends AuthEvent {}

class AuthRegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String role;

  AuthRegisterEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });
}
