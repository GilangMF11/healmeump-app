import 'package:dartz/dartz.dart';
import 'package:healmeumpapp/core/handling_service_response/failure_response.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/create_answers_entities.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/mental_health_entities.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/save_answers_entities.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/submit_answers_entities.dart';
import 'package:healmeumpapp/features/mental_health/domain/repository/mental_health_repository.dart';

class MentalHealthUsecase {
  final MentalHealthRepository mentalHealthRepository;

  MentalHealthUsecase(this.mentalHealthRepository);

  Future<Either<FailureResponse, MentalHealthEntities>> getQuestionnaire(
      String codeName) async {
    return await mentalHealthRepository.getQuestionnairebyCodeName(codeName);
  }

  Future<Either<FailureResponse, CreateAnswersEntities>> createAnswers(
    String questionnaireCode,
    String userId,
    String namaPegawai,
    String nip,
    String jenisPegawai,
    String prodi,
    String email,
    String hp,
  ) async {
    return await mentalHealthRepository.createAnswers(
      questionnaireCode,
      userId,
      namaPegawai,
      nip,
      jenisPegawai,
      prodi,
      email,
      hp,
    );
  }

  Future<Either<FailureResponse, SaveAnswersEntities>> saveAnswers(
    List<Map<String, dynamic>> answers,
    String responseId,
  ) async {
    return await mentalHealthRepository.saveAnswers(answers, responseId);
  }

  Future<Either<FailureResponse, SubmitAnswersEntities>> submitAnswers(
      String responseId) async {
    return await mentalHealthRepository.submitAnswers(responseId);
  }
}
