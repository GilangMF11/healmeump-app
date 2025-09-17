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
      scores: const [],
      summary: SummaryAdmin(
        totalScores: 0,
        questionnaires: const [],
        categories: const [],
      ),
      pagination: Pagination(
        limit: 0,
        offset: 0,
        total: 0,
      ),
    ),
    message: json["message"] ?? "",
  );
}

class DataScoreAdminDetailed {
  final List<ScoreAdmin> scores;
  final SummaryAdmin summary;
  final Pagination pagination;

  DataScoreAdminDetailed({
    required this.scores,
    required this.summary,
    required this.pagination,
  });

  DataScoreAdminDetailedEntities toEntity() => DataScoreAdminDetailedEntities(
    scores: scores.map((x) => x.toEntity()).toList(),
    summary: summary.toEntity(),
    pagination: pagination.toEntity(),
  );

  factory DataScoreAdminDetailed.fromJson(Map<String, dynamic> json) => DataScoreAdminDetailed(
    scores: json["scores"] != null && json["scores"] is List
        ? List<ScoreAdmin>.from(json["scores"].map((x) => ScoreAdmin.fromJson(x)))
        : const [],
    summary: json["summary"] != null ? SummaryAdmin.fromJson(json["summary"]) : SummaryAdmin(
      totalScores: 0,
      questionnaires: const [],
      categories: const [],
    ),
    pagination: json["pagination"] != null ? Pagination.fromJson(json["pagination"]) : Pagination(
      limit: 0,
      offset: 0,
      total: 0,
    ),
  );
}

class ScoreAdmin {
  final String id;
  final String responseId;
  final String questionnaireCode;
  final String domain;
  final int rawScore;
  final int finalScore;
  final String category;
  final DateTime submittedAt;
  final String encryptedUserId;
  final String encryptedUserData;

  ScoreAdmin({
    required this.id,
    required this.responseId,
    required this.questionnaireCode,
    required this.domain,
    required this.rawScore,
    required this.finalScore,
    required this.category,
    required this.submittedAt,
    required this.encryptedUserId,
    required this.encryptedUserData,
  });

  ScoreAdminEntities toEntity() => ScoreAdminEntities(
    id: id,
    responseId: responseId,
    questionnaireCode: questionnaireCode,
    domain: domain,
    rawScore: rawScore,
    finalScore: finalScore,
    category: category,
    submittedAt: submittedAt,
    encryptedUserId: encryptedUserId,
    encryptedUserData: encryptedUserData,
  );

  factory ScoreAdmin.fromJson(Map<String, dynamic> json) => ScoreAdmin(
    id: json["id"] ?? "",
    responseId: json["responseId"] ?? "",
    questionnaireCode: json["questionnaireCode"] ?? "",
    domain: json["domain"] ?? "",
    rawScore: json["rawScore"] ?? 0,
    finalScore: json["finalScore"] ?? 0,
    category: json["category"] ?? "",
    submittedAt: json["submittedAt"] != null ? DateTime.parse(json["submittedAt"]) : DateTime.fromMillisecondsSinceEpoch(0),
    encryptedUserId: json["encryptedUserId"] ?? "",
    encryptedUserData: json["encryptedUserData"] ?? "",
  );
}

class SummaryAdmin {
  final int totalScores;
  final List<QuestionnaireCount> questionnaires;
  final List<CategoryCount> categories;

  SummaryAdmin({
    required this.totalScores,
    required this.questionnaires,
    required this.categories,
  });

  SummaryAdminEntities toEntity() => SummaryAdminEntities(
    totalScores: totalScores,
    questionnaires: questionnaires.map((x) => x.toEntity()).toList(),
    categories: categories.map((x) => x.toEntity()).toList(),
  );

  factory SummaryAdmin.fromJson(Map<String, dynamic> json) => SummaryAdmin(
    totalScores: json["totalScores"] ?? 0,
    questionnaires: json["questionnaires"] != null && json["questionnaires"] is List
        ? List<QuestionnaireCount>.from(json["questionnaires"].map((x) => QuestionnaireCount.fromJson(x)))
        : const [],
    categories: json["categories"] != null && json["categories"] is List
        ? List<CategoryCount>.from(json["categories"].map((x) => CategoryCount.fromJson(x)))
        : const [],
  );
}

class QuestionnaireCount {
  final String code;
  final int count;

  QuestionnaireCount({
    required this.code,
    required this.count,
  });

  QuestionnaireCountEntities toEntity() => QuestionnaireCountEntities(
    code: code,
    count: count,
  );

  factory QuestionnaireCount.fromJson(Map<String, dynamic> json) => QuestionnaireCount(
    code: json["code"] ?? "",
    count: json["count"] ?? 0,
  );
}

class CategoryCount {
  final String category;
  final int count;

  CategoryCount({
    required this.category,
    required this.count,
  });

  CategoryCountEntities toEntity() => CategoryCountEntities(
    category: category,
    count: count,
  );

  factory CategoryCount.fromJson(Map<String, dynamic> json) => CategoryCount(
    category: json["category"] ?? "",
    count: json["count"] ?? 0,
  );
}

class Pagination {
  final int limit;
  final int offset;
  final int total;

  Pagination({
    required this.limit,
    required this.offset,
    required this.total,
  });

  PaginationEntities toEntity() => PaginationEntities(
    limit: limit,
    offset: offset,
    total: total,
  );

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    limit: json["limit"] ?? 0,
    offset: json["offset"] ?? 0,
    total: json["total"] ?? 0,
  );
}
