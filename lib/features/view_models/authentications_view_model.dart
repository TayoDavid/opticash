import 'package:flutter/material.dart';
import 'package:opticash/core/model/auth_models.dart';
import 'package:opticash/core/api/services/authentication_service.dart';
import 'package:opticash/core/locator/locator_service.dart';
import 'package:stacked/stacked.dart';

class AuthenticationViewModel extends BaseViewModel {
  final service = locator<AuthenticationService>();

  bool _uathenticated = false;
  bool get authenticated => _uathenticated;

  Future<void> register(UserModel body) async {
    final response = await service.register(body);
    if (response) {
      _uathenticated = true;
    }
  }

  Future<void> login(LoginModel body) async {
    final response = await service.login(body);
    if (response["success"]) {
      _uathenticated = true;
      debugPrint(response["data"]);
    }
  }
}
