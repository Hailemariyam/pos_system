import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pos_sales_app/models/user_model.dart';
import 'package:pos_sales_app/services/user_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final UserService userService;

  AuthBloc({required this.userService}) : super(AuthInitialState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthLoginEvent) {
      yield AuthLoadingState();
      final user = await userService.getUserByEmail(event.email);
      if (user != null && user.password == event.password) {
        yield AuthAuthenticatedState(user: user);
      } else {
        yield AuthErrorState(message: 'Invalid email or password');
      }
    }

    if (event is AuthRegisterEvent) {
      yield AuthLoadingState();
      try {
        final newUser = User(
          name: event.name,
          email: event.email,
          password: event.password,
          role: event.role,
        );
        await userService.addUser(newUser);
        yield AuthAuthenticatedState(user: newUser);
      } catch (e) {
        yield AuthErrorState(message: 'Registration failed');
      }
    }

    if (event is AuthLogoutEvent) {
      yield AuthUnauthenticatedState();
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    if (json['user'] != null) {
      return AuthAuthenticatedState(user: User.fromJson(json['user']));
    }
    return AuthUnauthenticatedState();
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    if (state is AuthAuthenticatedState) {
      return {
        'user': state.user.toJson(),
      };
    }
    return null;
  }
}
