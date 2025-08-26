import 'package:get_it/get_it.dart';
import 'package:healmeumpapp/shared/local_datasource.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // DATASOURCE
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSource());
  // sl.registerLazySingleton<AuthRemoteDataSource>(
  //     () => AuthImpRemoteDataSource());
  

  // REPOSITORY
  // sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp(
  //     authRemoteDataSource: sl(),
  //   ));
  


  // USECASE
  //sl.registerLazySingleton(() => LoginUsecase(sl()));
  


  // BLOC
  // sl.registerFactory(() => AuthBloc(
  //   loginUsecase: sl(),
  //   versionUsecase: sl(),
  //   ));

 
}
