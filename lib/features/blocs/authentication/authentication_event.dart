part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {
  Future<void> handle(AuthenticationBloc bloc, Emitter emit);
}

class Register extends AuthenticationEvent {
  final UserModel body;

  Register(this.body);
  @override
  Future<void> handle(AuthenticationBloc bloc, Emitter emit) async {
    try {
      emit(Authenticating());
      final success = await bloc.service.register(body);
      if (success) {
        emit(RegistrationSuccessful());
      } else {
        emit(AuthenticationError("Error signing up"));
      }
    } on DioException catch (e) {
      emit(AuthenticationError(e.message ?? ""));
    }
  }
}

class Login extends AuthenticationEvent {
  final LoginModel body;

  Login(this.body);
  @override
  Future<void> handle(AuthenticationBloc bloc, Emitter emit) async {
    try {
      emit(Authenticating());
      final response = await bloc.service.login(body);
      if (response["success"]) {
        final data = response["data"]["data"];
        final result = LoginResponseModel.fromJson(data);
        emit(Authenticated(result));
      } else {
        emit(AuthenticationError("Error signing up"));
      }
    } on DioException catch (e) {
      emit(AuthenticationError(e.errMessage));
    } catch (e) {
      emit(AuthenticationError(e.toString()));
    }
  }
}
