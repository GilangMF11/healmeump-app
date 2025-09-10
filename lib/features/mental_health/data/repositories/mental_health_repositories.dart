import 'package:dartz/dartz.dart';
import 'package:healmeumpapp/core/handling_service_response/datasource_error_constant.dart';
import 'package:healmeumpapp/core/handling_service_response/datasource_extention.dart';
import 'package:healmeumpapp/core/handling_service_response/failure_response.dart';
import 'package:healmeumpapp/core/handling_service_response/handling_error.dart';
import 'package:healmeumpapp/core/service/connectivity.dart';
import 'package:healmeumpapp/features/mental_health/data/datasource/remote_datasource_mental_health.dart';
import 'package:healmeumpapp/features/mental_health/data/model/create_answers_request_model.dart';
import 'package:healmeumpapp/features/mental_health/data/model/save_answers_request_model.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/create_answers_entities.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/mental_health_entities.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/save_answers_entities.dart';
import 'package:healmeumpapp/features/mental_health/domain/repository/mental_health_repository.dart';

class MentalHealthRepositoriesImp extends MentalHealthRepository {
  final MentalHealthRemoteDataSource mentalHealthRemoteDataSource;

  MentalHealthRepositoriesImp({required this.mentalHealthRemoteDataSource});

  var checkConnection = CheckConnection().checkInternet();

  @override
  Future<Either<FailureResponse, MentalHealthEntities>> getQuestionnairebyCodeName(String codeName) async {
    if (await checkConnection == true) {
      try {
        final result = await mentalHealthRemoteDataSource.getQuestionnairebyCodeName(codeName);
        return Right(result.toEntity());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSourceErrorConstant.NO_INTERNET_CONNECTION.getFailureResponse());
    }
  }

  @override
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
    if (await checkConnection == true) {
      try {
        final request = CreateAnswersRequestModel(
          questionnaireCode: questionnaireCode,
          userId: userId,
          userData: UserData(
            namaPegawai: namaPegawai,
            nip: nip,
            jenisPegawai: jenisPegawai,
            prodi: prodi,
            email: email,
            hp: hp,
          ),
        );
        final result = await mentalHealthRemoteDataSource.createAnswers(request);
        return Right(result.toEntity());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSourceErrorConstant.NO_INTERNET_CONNECTION.getFailureResponse());
    }
  }

  @override
  Future<Either<FailureResponse, SaveAnswersEntities>> saveAnswers(
    List<Map<String, dynamic>> answers, 
    String responseId,
  ) async {
    if (await checkConnection == true) {
      try {
        final answerList = answers.map((answer) => Answer(
          questionId: answer['questionId'] ?? '',
          questionNo: answer['questionNo'] ?? 0,
          score: answer['score'] ?? 0,
        )).toList();
        
        final request = SaveAnswersRequestModel(answers: answerList);
        final result = await mentalHealthRemoteDataSource.saveAnswers(request, responseId);
        return Right(result.toEntity());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSourceErrorConstant.NO_INTERNET_CONNECTION.getFailureResponse());
    }
  }
}