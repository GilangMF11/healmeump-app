import 'package:healmeumpapp/features/home/data/model/score_model.dart';
import 'package:healmeumpapp/features/home/domain/entities/score_admin_entities.dart';

class ScoreAdminModel {
  final bool success;
  final DataScore data;
  final String message;

  ScoreAdminModel({
    required this.success,
    required this.data,
    required this.message,
  });

  ScoreAdminEntities toEntity() => ScoreAdminEntities(
        success: success,
        dataScore: data,
        message: message,
      );

  factory ScoreAdminModel.fromJson(Map<String, dynamic> json) => ScoreAdminModel(
        success: json['success'] ?? false,
        data: json['data'] != null
            ? DataScore.fromJson(json['data'])
            : DataScore(
                userId: '',
                scores: const [],
                summary: Summary(
                  totalResponses: 0,
                  questionnaires: const [],
                  latestSubmission: DateTime.fromMillisecondsSinceEpoch(0),
                ),
              ),
        message: json['message'] ?? '',
      );

  ScoreAdminModel copyWith({
    bool? success,
    DataScore? data,
    String? message,
  }) =>
      ScoreAdminModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );
}


