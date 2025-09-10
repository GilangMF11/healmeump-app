import 'package:healmeumpapp/core/service/service_api.dart';
import 'package:healmeumpapp/features/home/data/model/version_model.dart';
import 'package:healmeumpapp/global/constant/api_url.dart';

abstract class HomeRemoteDataSource {
  Future<VersionModel> getVersion();
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
}