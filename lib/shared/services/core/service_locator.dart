import 'package:get_it/get_it.dart';
import 'package:tirmobile/login-module/login_view_model.dart';
import 'package:tirmobile/shared/services/api/web_api.dart';
import 'package:tirmobile/shared/services/auth_service.dart';
import 'package:tirmobile/shared/services/tasks_service.dart';
import 'package:tirmobile/task-module/task_view_model.dart';
import 'package:tirmobile/tasks-module/tasks_view_model.dart';
import 'package:tirmobile/users-module/users_service.dart';
import 'package:tirmobile/users-module/users_view_model.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  /** services */
  serviceLocator.registerLazySingleton<WebApi>(() => WebApiService());
  serviceLocator.registerLazySingleton<UsersService>(() => UsersService());
  serviceLocator.registerLazySingleton<AuthService>(() => AuthService());
  serviceLocator.registerLazySingleton<TasksService>(() => TasksService());
  /** view models */
  serviceLocator.registerFactory<UsersViewModel>(() => UsersViewModel());
  serviceLocator.registerFactory<LoginViewModel>(() => LoginViewModel());
  serviceLocator.registerFactory<TasksViewModel>(() => TasksViewModel());
  serviceLocator.registerFactory<TaskViewModel>(() => TaskViewModel());
}
