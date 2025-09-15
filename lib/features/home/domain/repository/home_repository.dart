import 'package:dartz/dartz.dart';
import 'package:healmeumpapp/core/handling_service_response/failure_response.dart';
import 'package:healmeumpapp/features/home/domain/entities/export_entities.dart';
import 'package:healmeumpapp/features/home/domain/entities/version_entities.dart';
import 'package:healmeumpapp/features/home/domain/entities/score_admin_entities.dart';
import 'package:healmeumpapp/features/home/domain/entities/score_entities.dart';

abstract class HomeRepository {
  Future<Either<FailureResponse, VersionEntities>> getVersion();
  Future<Either<FailureResponse, ScoreEntities>> getScoreHistory(String userId, String questionnaireCode);
  Future<Either<FailureResponse, ScoreAdminEntities>> getScoreAdminHistory(String limit);
  Future<Either<FailureResponse, ExportEntities>> getExportAdminHistory(bool includeEncryptedData, String format, String questionnaireCode);
}