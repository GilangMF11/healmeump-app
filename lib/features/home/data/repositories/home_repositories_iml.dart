import 'package:dartz/dartz.dart';
import 'package:healmeumpapp/core/handling_service_response/datasource_error_constant.dart';
import 'package:healmeumpapp/core/handling_service_response/datasource_extention.dart';
import 'package:healmeumpapp/core/handling_service_response/failure_response.dart';
import 'package:healmeumpapp/core/handling_service_response/handling_error.dart';
import 'package:healmeumpapp/core/service/connectivity.dart';
import 'package:healmeumpapp/features/home/data/datasource/remote_datasource_home.dart';
import 'package:healmeumpapp/features/home/domain/entities/export_entities.dart';
import 'package:healmeumpapp/features/home/domain/entities/version_entities.dart';
import 'package:healmeumpapp/features/home/domain/entities/score_admin_entities.dart';
import 'package:healmeumpapp/features/home/domain/entities/score_entities.dart';
import 'package:healmeumpapp/features/home/domain/repository/home_repository.dart';

class HomeRepositoriesImp extends HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoriesImp({required this.homeRemoteDataSource});

  var checkConnection = CheckConnection().checkInternet();

  @override
  Future<Either<FailureResponse, VersionEntities>> getVersion() async {
    if (await checkConnection == true) {
      try {
        final result = await homeRemoteDataSource.getVersion();
        return Right(result.toEntity());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(
          DataSourceErrorConstant.NO_INTERNET_CONNECTION.getFailureResponse());
    }
  }

  @override
  Future<Either<FailureResponse, ExportEntities>> getExportAdminHistory(
      bool includeEncryptedData,
      String format,
      String questionnaireCode) async {
    if (await checkConnection == true) {
      try {
        final result = await homeRemoteDataSource.getExportAdminHistory(
            includeEncryptedData, format, questionnaireCode);
        return Right(result.toEntity());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(
          DataSourceErrorConstant.NO_INTERNET_CONNECTION.getFailureResponse());
    }
  }

  @override
  Future<Either<FailureResponse, ScoreAdminEntities>> getScoreAdminHistory(
      String limit) async {
    if (await checkConnection == true) {
      try {
        final result = await homeRemoteDataSource.getScoreAdminHistory(limit);
        return Right(result.toEntity());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(
          DataSourceErrorConstant.NO_INTERNET_CONNECTION.getFailureResponse());
    }
  }

  @override
  Future<Either<FailureResponse, ScoreEntities>> getScoreHistory(
      String userId, String questionnaireCode) async {
    if (await checkConnection == true) {
      try {
        final result = await homeRemoteDataSource.getScoreHistory(
            userId, questionnaireCode);
        return Right(result.toEntity());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(
          DataSourceErrorConstant.NO_INTERNET_CONNECTION.getFailureResponse());
    }
  }
}
