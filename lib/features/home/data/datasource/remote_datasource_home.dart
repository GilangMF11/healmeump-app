import 'package:healmeumpapp/core/service/service_api.dart';
import 'package:healmeumpapp/features/home/data/model/export_model.dart';
import 'package:healmeumpapp/features/home/data/model/score_model.dart';
import 'package:healmeumpapp/features/home/data/model/score_admin_model.dart';
import 'package:healmeumpapp/features/home/data/model/version_model.dart';
import 'package:healmeumpapp/global/constant/api_url.dart';

abstract class HomeRemoteDataSource {
  Future<VersionModel> getVersion();
  Future<ExportModel> getExportAdminHistory(bool includeEncryptedData, String format, String questionnaireCode);
  Future<ScoreAdminModel> getScoreAdminHistory(String limit);
  Future<ScoreModel> getScoreHistory(String userId, String questionnaireCode);
}

class HomeImpRemoteDataSource implements HomeRemoteDataSource {
  final dio = ServiceApiDio();
  
  @override
  Future<VersionModel> getVersion() async {
    try {
      final response = await dio.getCall("${ApiUrl.version}/latest?platform=android");
      VersionModel result = VersionModel.fromJson(response.data);
      return result;
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }
  
  @override
  Future<ExportModel> getExportAdminHistory(bool includeEncryptedData, String format, String questionnaireCode) async {
    try {
      final response = await dio.getCall("${ApiUrl.scores}/export?format=$format&questionnaireCode=$questionnaireCode");
      ExportModel result = ExportModel.fromJson(response.data);
      return result;
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }
  
  @override
  Future<ScoreAdminModel> getScoreAdminHistory(String limit) async {
    try {
      final response = await dio.getCall("${ApiUrl.scores}/admin?limit=$limit");
      ScoreAdminModel result = ScoreAdminModel.fromJson(response.data);
      return result;
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }
  
  @override
  Future<ScoreModel> getScoreHistory(String userId, String questionnaireCode) async {
    try {
      final response = await dio.getCall("${ApiUrl.scores}/user/$userId?questionnaireCode=$questionnaireCode");
      ScoreModel result = ScoreModel.fromJson(response.data);
      return result;
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }
}