import 'dart:convert';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:healmeumpapp/global/constant/base_url2.dart';
import 'package:healmeumpapp/global/constant/dio_options.dart';

class DioFactoryUMP {
  String? token;
  String? url;
  Map<String, dynamic>? dataBody;
  FormData? dataBodyFormData;
  String? method;

  DioFactoryUMP({
    required this.method,
    required this.token,
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
      'x-token': token ?? '',
      'X-Requested-With': 'XMLHttpRequest',
    };

    // BaseOptions
    dio.options = BaseOptions(
      baseUrl: BaseUrl2.BASE_UMP,
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
    } else if (method == "DELETE") {
      result = await dio.delete(url!);
    }

    return result!;
  }
}
