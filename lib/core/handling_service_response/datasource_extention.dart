
import 'package:healmeumpapp/core/handling_service_response/datasource_error_constant.dart';
import 'package:healmeumpapp/core/handling_service_response/failure_response.dart';
import 'package:healmeumpapp/core/handling_service_response/response_code.dart';
import 'package:healmeumpapp/core/handling_service_response/response_message.dart';

extension DataSourceErrorConstantExtension on DataSourceErrorConstant {
  getFailureResponse() {
    switch (this) {
      case DataSourceErrorConstant.SUCCESS:
        return const FailureResponse(
            statusCode: ResponseCode.SUCCESS, message: ResponseMessage.SUCCESS);
      case DataSourceErrorConstant.NO_CONTENT:
        return const FailureResponse(
            statusCode: ResponseCode.NO_CONTENT,
            message: ResponseMessage.NO_CONTENT);
      case DataSourceErrorConstant.BAD_REQUEST:
        return const FailureResponse(
            statusCode: ResponseCode.BAD_REQUEST,
            message: ResponseMessage.BAD_REQUEST);
      case DataSourceErrorConstant.FORBIDDEN:
        return const FailureResponse(
            statusCode: ResponseCode.FORBIDDEN,
            message: ResponseMessage.FORBIDDEN);
      case DataSourceErrorConstant.UNAUTORISED:
        return const FailureResponse(
            statusCode: ResponseCode.UNAUTHORIZED,
            message: ResponseMessage.UNAUTHORIZED);
      case DataSourceErrorConstant.NOT_FOUND:
        return const FailureResponse(
            statusCode: ResponseCode.NOT_FOUND,
            message: ResponseMessage.NOT_FOUND);
      case DataSourceErrorConstant.INTERNAL_SERVER_ERROR:
        return const FailureResponse(
            statusCode: ResponseCode.INTERNAL_SERVER_ERROR,
            message: ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSourceErrorConstant.CONNECT_TIMEOUT:
        return const FailureResponse(
            statusCode: ResponseCode.CONNECT_TIMEOUT,
            message: ResponseMessage.CONNECT_TIMEOUT);
      case DataSourceErrorConstant.CANCEL:
        return const FailureResponse(
            statusCode: ResponseCode.CANCEL, message: ResponseMessage.CANCEL);
      case DataSourceErrorConstant.RECIEVE_TIMEOUT:
        return const FailureResponse(
            statusCode: ResponseCode.RECIEVE_TIMEOUT,
            message: ResponseMessage.RECIEVE_TIMEOUT);
      case DataSourceErrorConstant.SEND_TIMEOUT:
        return const FailureResponse(
            statusCode: ResponseCode.SEND_TIMEOUT,
            message: ResponseMessage.SEND_TIMEOUT);
      case DataSourceErrorConstant.CACHE_ERROR:
        return const FailureResponse(
            statusCode: ResponseCode.CACHE_ERROR,
            message: ResponseMessage.CACHE_ERROR);
      case DataSourceErrorConstant.NO_INTERNET_CONNECTION:
        return const FailureResponse(
            statusCode: ResponseCode.NO_INTERNET_CONNECTION,
            message: ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSourceErrorConstant.DEFAULT:
        return const FailureResponse(
            statusCode: ResponseCode.DEFAULT, message: ResponseMessage.DEFAULT);
    }
  }
}