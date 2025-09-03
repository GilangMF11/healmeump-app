import 'package:dartz/dartz.dart';
import 'package:healmeumpapp/core/handling_service_response/failure_response.dart';
import 'package:healmeumpapp/features/home/domain/entities/version_entities.dart';

abstract class HomeRepository {
  Future<Either<FailureResponse, VersionEntities>> getVersion();
}