import 'package:dartz/dartz.dart';
import 'package:healmeumpapp/core/handling_service_response/failure_response.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/create_answers_entities.dart';
import 'package:healmeumpapp/features/mental_health/domain/repository/mental_health_repository.dart';

class CreateAnswersUsecase {
  final MentalHealthRepository mentalHealthRepository;

  CreateAnswersUsecase(this.mentalHealthRepository);

  Future<Either<FailureResponse, CreateAnswersEntities>> call(
      String questionnaireCode,
      String userId,
      String namaPegawai,
      String nip,
      String jenisPegawai,
      String prodi,
      String email,
      String hp) async {
    return await mentalHealthRepository.createAnswers(questionnaireCode, userId,
        namaPegawai, nip, jenisPegawai, prodi, email, hp);
  }
}
