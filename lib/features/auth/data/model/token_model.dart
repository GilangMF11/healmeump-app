class TokenModel {
  final MetaData metaData;
  final ResponseData response;

  TokenModel({
    required this.metaData,
    required this.response,
  });

  // Factory
  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        metaData: MetaData.fromJson(json["metaData"]),
        response: ResponseData.fromJson(json["response"]),
      );

  TokenModel copyWith({
    MetaData? metaData,
    ResponseData? response,
  }) =>
      TokenModel(
        metaData: metaData ?? this.metaData,
        response: response ?? this.response,
      );
}

class MetaData {
  final String message;
  final String code;

  MetaData({
    required this.message,
    required this.code,
  });

  // Factory
  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        message: json["message"],
        code: json["code"],
      );

  MetaData copyWith({
    String? message,
    String? code,
  }) =>
      MetaData(
        message: message ?? this.message,
        code: code ?? this.code,
      );
}

class ResponseData {
  final String token;

  ResponseData({
    required this.token,
  });

  // Factory
  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        token: json["token"]);
      

  ResponseData copyWith({
    String? token,
  }) =>
      ResponseData(
        token: token ?? this.token,
      );
}


