import 'package:get_it/get_it.dart';
import 'package:opticash/core/api/api_client.dart';
import 'package:opticash/core/api/services/authentication_service.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator
    ..registerLazySingleton(() => ApiClient())
    ..registerLazySingleton(() => AuthenticationService());
}
