import 'package:dartz/dartz.dart';
import 'package:healmeumpapp/core/handling_service_response/failure_response.dart';
import 'package:healmeumpapp/features/home/domain/entities/export_entities.dart';
import 'package:healmeumpapp/features/home/domain/entities/score_admin_entities.dart';
import 'package:healmeumpapp/features/home/domain/entities/score_entities.dart';
import 'package:healmeumpapp/features/home/domain/entities/version_entities.dart';
import 'package:healmeumpapp/features/home/domain/repository/home_repository.dart';

class VersionUsecase {
  final HomeRepository homeRepository;

  VersionUsecase(this.homeRepository);

  Future<Either<FailureResponse, VersionEntities>> call() async {
    return await homeRepository.getVersion();
  }

  Future<Either<FailureResponse, ScoreEntities>> getScoreHistory(String userId, String questionnaireCode) {
    return homeRepository.getScoreHistory(userId, questionnaireCode);
  }

  Future<Either<FailureResponse, ScoreAdminEntities>> getScoreAdminHistory(String limit) {
    return homeRepository.getScoreAdminHistory(limit);
  }

  Future<Either<FailureResponse, ExportEntities>> getExportAdminHistory(bool includeEncryptedData, String format, String questionnaireCode) {
    return homeRepository.getExportAdminHistory(includeEncryptedData, format, questionnaireCode);
  }
}