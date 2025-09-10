import 'package:get_it/get_it.dart';
import 'package:healmeumpapp/features/auth/data/datasource/remote_datasource_auth.dart';
import 'package:healmeumpapp/features/auth/data/repositories/auth_repositories_iml.dart';
import 'package:healmeumpapp/features/auth/domain/repository/auth_repository.dart';
import 'package:healmeumpapp/features/auth/domain/usecase/login_usecase.dart';
import 'package:healmeumpapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:healmeumpapp/features/home/data/datasource/remote_datasource_home.dart';
import 'package:healmeumpapp/features/home/data/repositories/home_repositories_iml.dart';
import 'package:healmeumpapp/features/home/domain/repository/home_repository.dart';
import 'package:healmeumpapp/features/home/domain/usecase/version_usecase.dart';
import 'package:healmeumpapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:healmeumpapp/features/mental_health/data/datasource/remote_datasource_mental_health.dart';
import 'package:healmeumpapp/features/mental_health/data/repositories/mental_health_repositories.dart';
import 'package:healmeumpapp/features/mental_health/domain/repository/mental_health_repository.dart';
import 'package:healmeumpapp/features/mental_health/domain/usecase/create_answers_usecase.dart';
import 'package:healmeumpapp/features/mental_health/domain/usecase/mental_health_usecase.dart';
import 'package:healmeumpapp/features/mental_health/domain/usecase/save_answers_usecase.dart';
import 'package:healmeumpapp/features/mental_health/presentation/bloc/mentalhealth_bloc.dart';
import 'package:healmeumpapp/shared/local_datasource.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // DATASOURCE
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSource());
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthImpRemoteDataSource());
  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeImpRemoteDataSource());
  sl.registerLazySingleton<MentalHealthRemoteDataSource>(
      () => MentalHealthImpRemoteDataSource());

  // REPOSITORY
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp(
        authRemoteDataSource: sl(),
      ));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoriesImp(
        homeRemoteDataSource: sl(),
      ));
  sl.registerLazySingleton<MentalHealthRepository>(
      () => MentalHealthRepositoriesImp(
            mentalHealthRemoteDataSource: sl(),
          ));

  // USECASE
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => VersionUsecase(sl()));
  sl.registerLazySingleton(() => MentalHealthUsecase(sl()));
  sl.registerLazySingleton(() => CreateAnswersUsecase(sl()));
  sl.registerLazySingleton(() => SaveAnswersUsecase(sl()));  //sl.registerLazySingleton(() => LoginUsecase(sl()));

  // BLOC
  sl.registerFactory(() => AuthBloc(loginUsecase: sl()));
  sl.registerFactory(() => HomeBloc(versionUsecase: sl()));
  sl.registerFactory(() => MentalhealthBloc(
      mentalHealthUsecase: sl(),
      createAnswersUsecase: sl(),
      saveAnswersUsecase: sl()));
}
