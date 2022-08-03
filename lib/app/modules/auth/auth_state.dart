import '../../domain/auth/model/user_model.dart';

abstract class AuthState {}

class AuthStateEmpty extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateFailure extends AuthState {
  final String message;
  AuthStateFailure({
    required this.message,
  });
}

class AuthStateSuccess extends AuthState {
  final UserModel user;
  AuthStateSuccess({
    required this.user,
  });
}
