import 'package:healmeumpapp/core/service/service_api.dart';
import 'package:healmeumpapp/features/mental_health/data/model/create_answers_model.dart';
import 'package:healmeumpapp/features/mental_health/data/model/create_answers_request_model.dart';
import 'package:healmeumpapp/features/mental_health/data/model/mental_health_model.dart';
import 'package:healmeumpapp/features/mental_health/data/model/save_answers_model.dart';
import 'package:healmeumpapp/features/mental_health/data/model/save_answers_request_model.dart';
import 'package:healmeumpapp/global/constant/api_url.dart';

abstract class MentalHealthRemoteDataSource {
  Future<MentalHealthModel> getQuestionnairebyCodeName(String codeName);
  Future<CreateAnswersModel> createAnswers(CreateAnswersRequestModel request);
  Future<SaveAnswersModel> saveAnswers(SaveAnswersRequestModel request, String responseId);
}

class MentalHealthImpRemoteDataSource implements MentalHealthRemoteDataSource {
  final dio = ServiceApiDio();

  @override
  Future<MentalHealthModel> getQuestionnairebyCodeName(String codeName) async {
    try {
      final response = await dio.getCall("${ApiUrl.questionnaires}/$codeName/questions");
      MentalHealthModel result = MentalHealthModel.fromJson(response.data);
      return result;
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }

  @override
  Future<CreateAnswersModel> createAnswers(CreateAnswersRequestModel request) async {
    try {
      final response = await dio.postCall(
        "${ApiUrl.responses}/",
        request.toJson(),
      );
      CreateAnswersModel result = CreateAnswersModel.fromJson(response.data);
      return result;
    } catch (e) {
      print("error create answers: $e");
      rethrow;
    }
  }

  @override
  Future<SaveAnswersModel> saveAnswers(SaveAnswersRequestModel request, String responseId) async {
    try {
      final response = await dio.putCall(
        "${ApiUrl.questionnaires}/$responseId/answers",
        request.toJson(),
      );
      SaveAnswersModel result = SaveAnswersModel.fromJson(response.data);
      return result;
    } catch (e) {
      print("error save answers: $e");
      rethrow;
    }
  }
}