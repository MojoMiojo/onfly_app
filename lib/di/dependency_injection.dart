import 'package:get_it/get_it.dart';
import 'package:onfly_app/data/data.dart';
import 'package:onfly_app/data/expense/datasource/expense_datasource.dart';
import 'package:onfly_app/data/expense/repository/expense_repository_impl.dart';
import 'package:onfly_app/data/home/datasource/home_datasource.dart';
import 'package:onfly_app/data/home/repository/home_respository_impl.dart';
import 'package:onfly_app/domain/expense/repository/expense_repository.dart';
import 'package:onfly_app/domain/expense/use_cases/create_expense_use_case.dart';
import 'package:onfly_app/domain/expense/use_cases/update_expense_use_case.dart';
import 'package:onfly_app/presentation/expense/stores/expense_cubit.dart';
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
    getIt.registerFactory<ApiHandler>(() => ApiHandlerImpl(client: getIt()));
  }

  void registerDatasource() {
    getIt.registerFactory<HomeDatasource>(
      () => HomeDatasource(getIt()),
    );
    getIt.registerFactory<ExpenseDatasource>(
      () => ExpenseDatasource(getIt()),
    );
  }

  void registerRepository() {
    getIt.registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(getIt()),
    );
    getIt.registerFactory<ExpenseRepository>(
      () => ExpenseRepositoryImpl(getIt()),
    );
  }

  void registerUseCase() {
    getIt.registerFactory<AuthenticateUseCase>(
      () => AuthenticateUseCase(getIt()),
    );
    getIt.registerFactory<SetJwtUseCase>(
      () => SetJwtUseCase(getIt()),
    );
    getIt.registerFactory<ListExpensesUseCase>(
      () => ListExpensesUseCase(getIt()),
    );
    getIt.registerFactory<UpdateExpenseUseCase>(
      () => UpdateExpenseUseCase(getIt()),
    );
    getIt.registerFactory<CreateExpenseUseCase>(
      () => CreateExpenseUseCase(getIt()),
    );
  }

  void registerCubit() {
    getIt.registerFactory<HomeCubit>(
      () => HomeCubit(
        authenticateUseCase: getIt(),
        setJwtUseCase: getIt(),
        listExpensesUseCase: getIt(),
      ),
    );
    getIt.registerFactory<ExpenseCubit>(
      () => ExpenseCubit(
        updateExpenseUseCase: getIt(),
        createExpenseUseCase: getIt(),
      ),
    );
  }

}
