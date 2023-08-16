import 'package:opticash/core/locator/locator.dart';
import 'package:opticash/core/model/auth_models.dart';
import 'package:opticash/core/network/api_client.dart';
import 'package:opticash/core/network/endpoints.dart';
import 'package:stacked/stacked.dart';

class AuthenticationViewModel extends BaseViewModel {
  ApiClient apiClient = locator<ApiClient>();

  bool _uathenticated = false;
  bool get authenticated => _uathenticated;

  Future<void> register(SignUpModel body) async {
    final response = await apiClient.request(
      Endpoints.register,
      action: RequestAction.post,
      data: body.toJson(),
    );
    if (response["success"]) {
      _uathenticated = true;
    }
  }

  Future<void> login(LoginModel body) async {
    final response = await apiClient.request(
      Endpoints.login,
      action: RequestAction.post,
      data: body.toJson(),
    );
    if (response["success"]) {
      _uathenticated = true;
    }
  }
}
