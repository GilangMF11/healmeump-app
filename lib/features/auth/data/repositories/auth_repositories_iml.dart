import 'package:dartz/dartz.dart';
import 'package:healmeumpapp/core/handling_service_response/datasource_error_constant.dart';
import 'package:healmeumpapp/core/handling_service_response/datasource_extention.dart';
import 'package:healmeumpapp/core/handling_service_response/failure_response.dart';
import 'package:healmeumpapp/core/handling_service_response/handling_error.dart';
import 'package:healmeumpapp/core/service/connectivity.dart';
import 'package:healmeumpapp/features/auth/data/datasource/remote_datasource_auth.dart';
import 'package:healmeumpapp/features/auth/domain/entities/login_entities.dart';
import 'package:healmeumpapp/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImp extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImp({required this.authRemoteDataSource});

  var checkConnection = CheckConnection().checkInternet();

  @override
  Future<Either<FailureResponse, LoginEntities>> postLogin(
      Map<String, dynamic> dataBody) async {
        print("Koneksi : ${ await checkConnection}");
    if (await checkConnection == true) {
      try {
        final result = await authRemoteDataSource.postLogin(dataBody);
        print("result: $result");
        return Right(result.toEntity());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      print("no internet");
      return Left(
          DataSourceErrorConstant.NO_INTERNET_CONNECTION.getFailureResponse());
    }
  }
}
