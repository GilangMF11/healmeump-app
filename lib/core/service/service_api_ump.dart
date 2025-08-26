import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:healmeumpapp/core/service/dio_factory_ump.dart';
import 'package:healmeumpapp/features/auth/data/model/token_model.dart';

class ServiceApiDioRamadhan {
  String? _currentToken;

  /// Fungsi untuk merefresh token menggunakan username dan password
  Future<void> refreshAndStoreToken() async {
    const String refreshTokenUrl = 'https://developer.ump.ac.id/token/';

    try {
      // Inisialisasi request dengan DioFactory
      final dioFactory = DioFactoryUMP(
        method: "POST",
        token: null,
        url: refreshTokenUrl,
        dataBody: {
          "username": 'pangkalandata',
          "password": 'ump',
        },
      );

      // Eksekusi request
      final response = await dioFactory.init();
      print("response token: ${response.data}");

      // Decode JSON jika `response.data` berupa string
      final data = response.data is String
          ? jsonDecode(response.data) as Map<String, dynamic>
          : response.data as Map<String, dynamic>;

      // Parsing response menjadi TokenModel
      TokenModel tokenModel = TokenModel.fromJson(data);

      // Debugging output untuk memverifikasi data model
      // print("MetaData Message: ${tokenModel.metaData.message}");
      // print("Token: ${tokenModel.response.token}");
      // print("Response status kode: ${response.statusCode}");

      // Update token hanya jika status code 200
      if (response.statusCode == 200) {
        _currentToken = tokenModel.response.token;
      } else {
        throw Exception("Gagal mendapatkan token baru");
      }
    } catch (e) {
      print("Error saat refresh token: $e");
      rethrow;
    }
  }

  /// Mendapatkan token yang valid (tetap melakukan refresh setiap kali API dipanggil)
  Future<String> _getValidToken() async {
    await refreshAndStoreToken(); // Selalu lakukan refresh token
    return _currentToken!;
  }

  /// GET request
  Future<Response> getCall(String url) async {
    final token = await _getValidToken(); // Dapatkan token baru setiap kali
    final dioFactory = DioFactoryUMP(method: "GET", token: token, url: url);
    return await dioFactory.init(); // Melakukan request
  }

  /// POST request
  Future<Response> postCall(String url, Map<String, dynamic> data) async {
    final token = await _getValidToken(); // Dapatkan token baru setiap kali
    print("token post: $token");
    final dioFactory = DioFactoryUMP(
      method: "POST",
      token: token,
      url: url,
      dataBody: data,
    );
    return await dioFactory.init(); // Melakukan request
  }

  /// POST request xtoken
  Future<Response> postCallUmp(String url, Map<String, dynamic> data) async {
    final dioFactory = DioFactoryUMP(
        method: "POST", token: "umpunggul", url: url, dataBody: data);
    return await dioFactory.init();
  }

  /// PUT request
  Future<Response> putCall(String url, Map<String, dynamic> data) async {
    final token = await _getValidToken(); // Dapatkan token baru setiap kali
    final dioFactory = DioFactoryUMP(
      method: "PUT",
      token: token,
      url: url,
      dataBody: data,
    );
    return await dioFactory.init(); // Melakukan request
  }

  /// DELETE request
  Future<Response> deleteCall(String url) async {
    final token = await _getValidToken(); // Dapatkan token baru setiap kali
    final dioFactory = DioFactoryUMP(method: "DELETE", token: token, url: url);
    return await dioFactory.init(); // Melakukan request
  }
}