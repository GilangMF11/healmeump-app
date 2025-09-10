import 'package:dartz/dartz.dart';
import 'package:healmeumpapp/core/handling_service_response/failure_response.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/mental_health_entities.dart';
import 'package:healmeumpapp/features/mental_health/domain/repository/mental_health_repository.dart';

class MentalHealthUsecase {
  final MentalHealthRepository mentalHealthRepository;

  MentalHealthUsecase(this.mentalHealthRepository);

  Future<Either<FailureResponse, MentalHealthEntities>> call(String codeName) async {
    return await mentalHealthRepository.getQuestionnairebyCodeName(codeName);
  }
}