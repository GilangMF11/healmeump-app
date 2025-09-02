import 'package:dio/dio.dart';
import 'package:healmeumpapp/core/handling_service_response/datasource_error_constant.dart';
import 'package:healmeumpapp/core/handling_service_response/datasource_extention.dart';
import 'package:healmeumpapp/core/handling_service_response/failure_response.dart';

FailureResponse _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSourceErrorConstant.CONNECT_TIMEOUT.getFailureResponse();
    case DioExceptionType.sendTimeout:
      return DataSourceErrorConstant.SEND_TIMEOUT.getFailureResponse();
    case DioExceptionType.receiveTimeout:
      return DataSourceErrorConstant.RECIEVE_TIMEOUT.getFailureResponse();
    case DioExceptionType.badResponse:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return FailureResponse(
            statusCode: error.response?.statusCode ?? 0,
            message: error.response?.statusMessage ?? "");
      } else {
        return DataSourceErrorConstant.DEFAULT.getFailureResponse();
      }
    case DioExceptionType.cancel:
      return DataSourceErrorConstant.CANCEL.getFailureResponse();
    default:
      return DataSourceErrorConstant.DEFAULT.getFailureResponse();
  }
}

class ErrorHandler implements Exception {
  late FailureResponse failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // dio error so its an error from response of the API or from dio itself

      failure = _handleError(error);
    } else {
      // default error
      failure = DataSourceErrorConstant.DEFAULT.getFailureResponse();
    }
  }
}