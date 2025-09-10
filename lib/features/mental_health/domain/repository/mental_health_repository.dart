import 'package:dartz/dartz.dart';
import 'package:healmeumpapp/core/handling_service_response/failure_response.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/mental_health_entities.dart';

abstract class MentalHealthRepository {
  Future<Either<FailureResponse, MentalHealthEntities>> getQuestionnairebyCodeName(String codeName);
}