import 'package:healmeumpapp/core/service/service_api.dart';
import 'package:healmeumpapp/features/mental_health/data/model/mental_health_model.dart';
import 'package:healmeumpapp/global/constant/api_url.dart';

abstract class MentalHealthRemoteDataSource {
  Future<MentalHealthModel> getQuestionnairebyCodeName(String codeName);
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
}