import 'package:get_it/get_it.dart';
import 'package:onfly_app/data/data.dart';

class DependencyInjection {
  final getIt = GetIt.I;

  void setup() {
    registerApiClient();
  }

  void registerApiClient() {
    getIt.registerSingleton<DioClient>(DioClient());
    getIt.registerFactory<ApiHandler>(() => ApiHandler(client: getIt()));
  }
}
