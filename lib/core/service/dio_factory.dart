import 'dart:convert';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:healmeumpapp/core/service/flavor_config_set.dart';
import 'package:healmeumpapp/global/constant/dio_options.dart';
import 'package:healmeumpapp/global/constant/version.dart';

class DioFactory {
  String? token;
  String? url;
  Map<String, dynamic>? dataBody;
  FormData? dataBodyFormData;
  String? method;

  DioFactory({
    required this.method,
    this.token,
    required this.url,
    this.dataBody,
    this.dataBodyFormData,
  });

  Future<Response<dynamic>> init() async {
    Dio dio = Dio();
    Response<dynamic>? result;

    // Headers
    final headers = {
      'content-type': DioOptions.APPLICATION_JSON,
      'accept': DioOptions.APPLICATION_JSON,
      'User-Agent' : 'HealmeUMP2025',
      'Authorization': 'UMPMENDUNIA',
      'X-Requested-With': 'XMLHttpRequest',
      'version' : Version.version + "+" + Version.build,
    };

    // BaseOptions
    dio.options = BaseOptions(
      baseUrl: FlavorConfigSet.getBaseUrl(),
      headers: headers,
      receiveTimeout: Duration(seconds: DioOptions.apiReciveOut),
      sendTimeout: Duration(seconds: DioOptions.apiTimeOut),
      connectTimeout: Duration(seconds: DioOptions.apiTimeOut),
    );

    // Interceptors
    dio.interceptors.add(ChuckerDioInterceptor());
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          return handler.next(e);
        },
      ),
    );

    // Request logic
    if (method == "GET") {
      result = await dio.get(url!);
    } else if (method == "POST") {
      if (dataBody != null) {
        final dataEncode = jsonEncode(dataBody);
        result = await dio.post(url!, data: dataEncode);
      } else if (dataBodyFormData != null) {
        result = await dio.post(url!, data: dataBodyFormData);
      }
    } else if (method == "PUT") {
      final dataEncode = jsonEncode(dataBody);
      result = await dio.put(url!, data: dataEncode);
    } else if (method == "PATCH") {
      final dataEncode = jsonEncode(dataBody);
      result = await dio.patch(url!, data: dataEncode);
    }else if (method == "DELETE") {
      result = await dio.delete(url!);
    }

    return result!;
  }
}
