import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:opticash/core/api/services/authentication_service.dart';
import 'package:opticash/core/model/auth_models.dart';
import 'package:opticash/core/model/login_response_model.dart';
import 'package:opticash/core/utils/extensions.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService service;
  AuthenticationBloc(this.service) : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) => event.handle(this, emit));
  }
}
