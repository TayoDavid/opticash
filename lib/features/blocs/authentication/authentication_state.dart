part of 'authentication_bloc.dart';

sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class RegistrationSuccessful extends AuthenticationState {}

final class Authenticating extends AuthenticationState {}

final class Authenticated extends AuthenticationState {
  final LoginResponseModel model;

  Authenticated(this.model);
}

final class AuthenticationError extends AuthenticationState {
  final String errMsg;

  AuthenticationError(this.errMsg);
}
