import 'package:get_it/get_it.dart';
import 'package:onfly_app/data/data.dart';
import 'package:onfly_app/data/home/datasource/home_datasource.dart';
import 'package:onfly_app/data/home/repository/home_respository_impl.dart';
import 'package:onfly_app/presentation/presentation.dart';
import 'package:onfly_app/domain/domain.dart';

class DependencyInjection {
  final getIt = GetIt.I;

  void setup() {
    registerApiClient();
    registerDatasource();
    registerRepository();
    registerUseCase();
    registerCubit();
  }

  void registerApiClient() {
    getIt.registerSingleton<DioClient>(DioClient());
    getIt.registerFactory<ApiHandler>(() => ApiHandler(client: getIt()));
  }

  void registerDatasource() {
    getIt.registerFactory<HomeDatasource>(
      () => HomeDatasource(getIt()),
    );
  }

  void registerRepository() {
    getIt.registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(getIt()),
    );
  }

  void registerUseCase() {
    getIt.registerFactory<AuthenticateUseCase>(
      () => AuthenticateUseCase(getIt()),
    );
  }

  void registerCubit() {
    getIt.registerFactory<HomeCubit>(
      () => HomeCubit(authenticateUseCase: getIt()),
    );
  }

}
