import 'package:healmeumpapp/features/mental_health/domain/entities/save_answers_entities.dart';

class SaveAnswersModel {
  final bool success;
  final DataSaveAnswers data;
  final String message;

  SaveAnswersModel({
    required this.success,
    required this.data,
    required this.message,
  });

  SaveAnswersEntities toEntity() => SaveAnswersEntities(
        success: success,
        data: data,
        message: message,
      );

  factory SaveAnswersModel.fromJson(Map<String, dynamic> json) => SaveAnswersModel(
        success: json["success"] ?? false,
        data: json["data"] != null ? DataSaveAnswers.fromJson(json["data"]) : DataSaveAnswers(
          updatedCount: 0,
        ),
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };

  SaveAnswersModel copyWith({
    bool? success,
    DataSaveAnswers? data,
    String? message,
  }) =>
      SaveAnswersModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );
}

class DataSaveAnswers {
  final int updatedCount;

  DataSaveAnswers({
    required this.updatedCount,
  });

  DataSaveAnswersEntities toEntity() => DataSaveAnswersEntities(
        updatedCount: updatedCount,
      );

  factory DataSaveAnswers.fromJson(Map<String, dynamic> json) => DataSaveAnswers(
        updatedCount: json["updatedCount"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "updatedCount": updatedCount,
      };

  DataSaveAnswers copyWith({
    int? updatedCount,
  }) =>
      DataSaveAnswers(
        updatedCount: updatedCount ?? this.updatedCount,
      );
}
