import 'package:dio/dio.dart';
import 'package:healmeumpapp/core/service/dio_factory.dart';
import 'package:healmeumpapp/shared/local_datasource.dart';

class ServiceApiDio {
  LocalDataSource localDataSource = LocalDataSource();

  /// Service Api Dio Json Map
  Future<Response> getCall(String url) async {
    final dio = await DioFactory(method: "GET", url: url).init();
    final response = dio;
    return response;
  }

  Future<Response> postCall(String url, Map<String, dynamic> data) async {
    final dio =
        await DioFactory(method: "POST", url: url, dataBody: data)
            .init();
    final response = dio;
    return response;
  }

  Future<Response> putCall(String url, Map<String, dynamic> data) async {
    final dio =
        await DioFactory(method: "PUT", url: url, dataBody: data)
            .init();
    final response = dio;
    return response;
  }

  Future<Response> deleteCall(String url) async {
    final dio =
        await DioFactory(method: "DELETE", url: url).init();
    final response = dio;
    return response;
  }

  /// Service Api Dio Form Data
  Future<Response> postCallFormData(
      String token, String url, FormData data) async {
    final dio = await DioFactory(
            method: "POST", token: token, url: url, dataBodyFormData: data)
        .init();
    final response = dio;
    return response;
  }

  /// Service Api Dio Form Data
  Future<Response> postCallPrivateFormData(String url, FormData data) async {
    String token = await localDataSource.getToken();
    print(token);
    final dio = await DioFactory(
            method: "POST", token: token, url: url, dataBodyFormData: data)
        .init();
    final response = dio;
    return response;
  }

  // Private with token
  Future<Response> getCallPrivate(String url) async {
    String token = await localDataSource.getToken();
    print("token Get $token");
    final dio = await DioFactory(
            method: "GET",
            token: token,
            url: url)
        .init();
    final response = dio;
    return response;
  }

  // Post
  Future<Response> postCallPrivate(
      String url, Map<String, dynamic> data) async {
    final token = await localDataSource.getToken();
    
    print("token saat ini $token");
    final dio =
        await DioFactory(method: "POST", token: token, url: url, dataBody: data)
            .init();
    final response = dio;
    print("data response : $dio");
    return response;
  }

  // Put
  Future<Response> putCallPrivate(String url, Map<String, dynamic> data) async {
    String token = await localDataSource.getToken();
    final dio = await DioFactory(
            method: "PUT",
            token: token,
            url: url,
            dataBody: data)
        .init();
    final response = dio;
    return response;
  }

  // PERBAIKAN di ServiceApiDio
Future<Response> patchCallPrivate(String url, Map<String, dynamic> data) async {
  try {
    String token = await localDataSource.getToken();
    print("PATCH URL: $url");
    print("PATCH Data: $data");
    print("Token: $token");
    
    final response = await DioFactory(
            method: "PATCH",
            token: token,
            url: url,
            dataBody: data)
        .init();
    print("PATCH Response: ${response.data}");
    
    return response;
  } catch (error) {
    print("Error in patchCallPrivate: $error");
    rethrow;
  }
}

  Future<Response> deleteCallPrivate(String url) async {
    String token = await localDataSource.getToken();
    final dio = await DioFactory(
            method: "DELETE",
            token: token,
            url: url)
        .init();
    final response = dio;
    return response;
  }
}
