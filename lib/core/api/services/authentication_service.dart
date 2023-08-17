import 'package:opticash/core/model/auth_models.dart';
import 'package:opticash/core/api/api_client.dart';
import 'package:opticash/core/api/endpoints.dart';
import 'package:opticash/core/locator/locator_service.dart';

class AuthenticationService {
  ApiClient apiClient = locator<ApiClient>();

  Future<bool> register(UserModel body) async {
    final response = await apiClient.request(
      Endpoints.register,
      action: RequestAction.post,
      data: body.toJson(),
    );
    return response["success"];
  }

  Future<Map<String, dynamic>> login(LoginModel body) async {
    final response = await apiClient.request(
      Endpoints.login,
      action: RequestAction.post,
      data: body.toJson(),
    );
    return response;
  }
}
