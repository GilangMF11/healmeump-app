import 'package:dartz/dartz.dart';
import 'package:healmeumpapp/core/handling_service_response/failure_response.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/create_answers_entities.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/mental_health_entities.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/save_answers_entities.dart';

abstract class MentalHealthRepository {
  Future<Either<FailureResponse, MentalHealthEntities>> getQuestionnairebyCodeName(String codeName);
  Future<Either<FailureResponse, CreateAnswersEntities>> createAnswers(
    String questionnaireCode,
    String userId,
    String namaPegawai,
    String nip,
    String jenisPegawai,
    String prodi,
    String email,
    String hp,
  );
  Future<Either<FailureResponse, SaveAnswersEntities>> saveAnswers(
    List<Map<String, dynamic>> answers, String responseId,
  );
}