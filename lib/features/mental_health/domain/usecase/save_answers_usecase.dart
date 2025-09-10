import 'package:dartz/dartz.dart';
import 'package:healmeumpapp/core/handling_service_response/failure_response.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/save_answers_entities.dart';
import 'package:healmeumpapp/features/mental_health/domain/repository/mental_health_repository.dart';

class SaveAnswersUsecase {
  final MentalHealthRepository mentalHealthRepository;

  SaveAnswersUsecase(this.mentalHealthRepository);

  Future<Either<FailureResponse, SaveAnswersEntities>> call(
      List<Map<String, dynamic>> answers, String responseId) async {
    return await mentalHealthRepository.saveAnswers(answers, responseId);
  }
}
