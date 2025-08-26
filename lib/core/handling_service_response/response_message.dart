

import 'package:healmeumpapp/core/handling_service_response/data_messages.dart';

class ResponseMessage {
  static const String SUCCESS = DataMessage.SUCCESS; // success with data
  static const String NO_CONTENT =
      DataMessage.EMPTY; // success with no data (no content)
  static const String BAD_REQUEST =
      DataMessage.BAD_REQUEST; // failure, API rejected request
  static const String UNAUTHORIZED =
      DataMessage.UNAUTHORIZED; // failure, user is not authorised
  static const String FORBIDDEN =
      DataMessage.FORBIDDEN; //  failure, API rejected request
  static const String INTERNAL_SERVER_ERROR =
      DataMessage.INTERNAL_SERVER_ERROR; // failure, crash in server side
  static const String NOT_FOUND =
      DataMessage.NOT_FOUND; // failure, crash in server side

  // local status code
  static const String CONNECT_TIMEOUT = DataMessage.CONNECT_TIMEOUT;
  static const String CANCEL = DataMessage.CANCEL;
  static const String RECIEVE_TIMEOUT = DataMessage.RECIEVE_TIMEOUT;
  static const String SEND_TIMEOUT = DataMessage.SEND_TIMEOUT;
  static const String CACHE_ERROR = DataMessage.CACHE_ERROR;
  static const String NO_INTERNET_CONNECTION =
      DataMessage.NO_INTERNET_CONNECTION;
  static const String DEFAULT = DataMessage.DEFAULT;
}