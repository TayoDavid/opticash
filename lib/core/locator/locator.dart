import 'package:get_it/get_it.dart';
import 'package:opticash/core/network/api_client.dart';

final locator = GetIt.I;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => ApiClient());
}
