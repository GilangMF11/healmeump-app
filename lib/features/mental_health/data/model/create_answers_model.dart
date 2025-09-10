import 'package:healmeumpapp/features/mental_health/domain/entities/create_answers_entities.dart';

class CreateAnswersModel {
  final bool success;
  final DataCreateAnswers data;
  final String message;

  CreateAnswersModel({
    required this.success,
    required this.data,
    required this.message,
  });

  CreateAnswersEntities toEntity() => CreateAnswersEntities(
        success: success,
        data: data,
        message: message,
      );

  factory CreateAnswersModel.fromJson(Map<String, dynamic> json) => CreateAnswersModel(
        success: json["success"] ?? false,
        data: json["data"] != null ? DataCreateAnswers.fromJson(json["data"]) : DataCreateAnswers(
          responseId: "",
          questionnaireCode: "",
          status: "",
          createdAt: DateTime.now(),
        ),
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };

  CreateAnswersModel copyWith({
    bool? success,
    DataCreateAnswers? data,
    String? message,
  }) =>
      CreateAnswersModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );
}

class DataCreateAnswers {
  final String responseId;
  final String questionnaireCode;
  final String status;
  final DateTime createdAt;

  DataCreateAnswers({
    required this.responseId,
    required this.questionnaireCode,
    required this.status,
    required this.createdAt,
  });

  DataCreateAnswersEntities toEntity() => DataCreateAnswersEntities(
        responseId: responseId,
        questionnaireCode: questionnaireCode,
        status: status,
        createdAt: createdAt,
      );

  factory DataCreateAnswers.fromJson(Map<String, dynamic> json) => DataCreateAnswers(
        responseId: json["responseId"] ?? "",
        questionnaireCode: json["questionnaireCode"] ?? "",
        status: json["status"] ?? "",
        createdAt: json["createdAt"] != null 
            ? DateTime.parse(json["createdAt"]) 
            : DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "responseId": responseId,
        "questionnaireCode": questionnaireCode,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
      };

  DataCreateAnswers copyWith({
    String? responseId,
    String? questionnaireCode,
    String? status,
    DateTime? createdAt,
  }) =>
      DataCreateAnswers(
        responseId: responseId ?? this.responseId,
        questionnaireCode: questionnaireCode ?? this.questionnaireCode,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
}
