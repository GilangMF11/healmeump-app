import 'package:healmeumpapp/features/home/domain/entities/score_admin_detailed_entities.dart';

class ScoreAdminDetailedModel {
  final bool success;
  final DataScoreAdminDetailed data;
  final String message;

  ScoreAdminDetailedModel({
    required this.success,
    required this.data,
    required this.message,
  });

  ScoreAdminDetailedEntities toEntity() => ScoreAdminDetailedEntities(
    success: success,
    dataScoreAdmin: data.toEntity(),
    message: message,
  );

  factory ScoreAdminDetailedModel.fromJson(Map<String, dynamic> json) => ScoreAdminDetailedModel(
    success: json["success"] ?? false,
    data: json["data"] != null ? DataScoreAdminDetailed.fromJson(json["data"]) : DataScoreAdminDetailed(
      userId: "",
      scores: const [],
      summary: SummaryAdmin(
        totalResponses: 0,
        questionnaires: const [],
        latestSubmission: DateTime.fromMillisecondsSinceEpoch(0),
      ),
    ),
    message: json["message"] ?? "",
  );
}

class DataScoreAdminDetailed {
  final String userId;
  final List<ScoreAdmin> scores;
  final SummaryAdmin summary;

  DataScoreAdminDetailed({
    required this.userId,
    required this.scores,
    required this.summary,
  });

  DataScoreAdminDetailedEntities toEntity() => DataScoreAdminDetailedEntities(
    userId: userId,
    scores: scores.map((x) => x.toEntity()).toList(),
    summary: summary.toEntity(),
  );

  factory DataScoreAdminDetailed.fromJson(Map<String, dynamic> json) => DataScoreAdminDetailed(
    userId: json["userId"] ?? "",
    scores: json["scores"] != null && json["scores"] is List
        ? List<ScoreAdmin>.from(json["scores"].map((x) => ScoreAdmin.fromJson(x)))
        : const [],
    summary: json["summary"] != null ? SummaryAdmin.fromJson(json["summary"]) : SummaryAdmin(
      totalResponses: 0,
      questionnaires: const [],
      latestSubmission: DateTime.fromMillisecondsSinceEpoch(0),
    ),
  );
}

class ScoreAdmin {
  final String id;
  final String questionnaireCode;
  final DateTime submittedAt;
  final List<DomainScore> domains;

  ScoreAdmin({
    required this.id,
    required this.questionnaireCode,
    required this.submittedAt,
    required this.domains,
  });

  ScoreAdminEntities toEntity() => ScoreAdminEntities(
    id: id,
    questionnaireCode: questionnaireCode,
    submittedAt: submittedAt,
    domains: domains.map((x) => x.toEntity()).toList(),
  );

  factory ScoreAdmin.fromJson(Map<String, dynamic> json) => ScoreAdmin(
    id: json["id"] ?? "",
    questionnaireCode: json["questionnaireCode"] ?? "",
    submittedAt: json["submittedAt"] != null ? DateTime.parse(json["submittedAt"]) : DateTime.fromMillisecondsSinceEpoch(0),
    domains: json["domains"] != null && json["domains"] is List
        ? List<DomainScore>.from(json["domains"].map((x) => DomainScore.fromJson(x)))
        : const [],
  );
}

class DomainScore {
  final String domain;
  final int rawScore;
  final int finalScore;
  final String category;

  DomainScore({
    required this.domain,
    required this.rawScore,
    required this.finalScore,
    required this.category,
  });

  DomainScoreEntities toEntity() => DomainScoreEntities(
    domain: domain,
    rawScore: rawScore,
    finalScore: finalScore,
    category: category,
  );

  factory DomainScore.fromJson(Map<String, dynamic> json) => DomainScore(
    domain: json["domain"] ?? "",
    rawScore: json["rawScore"] ?? 0,
    finalScore: json["finalScore"] ?? 0,
    category: json["category"] ?? "",
  );
}

class SummaryAdmin {
  final int totalResponses;
  final List<String> questionnaires;
  final DateTime latestSubmission;

  SummaryAdmin({
    required this.totalResponses,
    required this.questionnaires,
    required this.latestSubmission,
  });

  SummaryAdminEntities toEntity() => SummaryAdminEntities(
    totalResponses: totalResponses,
    questionnaires: questionnaires,
    latestSubmission: latestSubmission,
  );

  factory SummaryAdmin.fromJson(Map<String, dynamic> json) => SummaryAdmin(
    totalResponses: json["totalResponses"] ?? 0,
    questionnaires: json["questionnaires"] != null && json["questionnaires"] is List
        ? List<String>.from(json["questionnaires"])
        : const [],
    latestSubmission: json["latestSubmission"] != null ? DateTime.parse(json["latestSubmission"]) : DateTime.fromMillisecondsSinceEpoch(0),
  );
}

