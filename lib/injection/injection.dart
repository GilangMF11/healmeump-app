import 'package:get_it/get_it.dart';
import 'package:healmeumpapp/features/auth/data/datasource/remote_datasource_auth.dart';
import 'package:healmeumpapp/features/auth/data/repositories/auth_repositories_iml.dart';
import 'package:healmeumpapp/features/auth/domain/repository/auth_repository.dart';
import 'package:healmeumpapp/features/auth/domain/usecase/login_usecase.dart';
import 'package:healmeumpapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:healmeumpapp/shared/local_datasource.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // DATASOURCE
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSource());
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthImpRemoteDataSource()
  );
  // sl.registerLazySingleton<AuthRemoteDataSource>(
  //     () => AuthImpRemoteDataSource());
  

  // REPOSITORY
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp(
      authRemoteDataSource: sl(),
    ));
  // sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp(
  //     authRemoteDataSource: sl(),
  //   ));
  


  // USECASE
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  //sl.registerLazySingleton(() => LoginUsecase(sl()));
  


  // BLOC
  sl.registerFactory(() => AuthBloc(loginUsecase: sl()));
  // sl.registerFactory(() => AuthBloc(
  //   loginUsecase: sl(),
  //   versionUsecase: sl(),
  //   ));

 
}
