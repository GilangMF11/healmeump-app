import 'package:dartz/dartz.dart';
import 'package:healmeumpapp/core/handling_service_response/failure_response.dart';
import 'package:healmeumpapp/features/auth/domain/entities/login_entities.dart';

abstract class AuthRepository {
  Future<Either<FailureResponse, LoginEntities>> postLogin(
    Map<String, dynamic> dataBody
  );
}