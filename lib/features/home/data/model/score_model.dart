import 'package:healmeumpapp/features/home/domain/entities/score_entities.dart';

class ScoreModel {
    final bool success;
    final DataScore data;
    final String message;

    ScoreModel({
        required this.success,
        required this.data,
        required this.message,
    });

    ScoreEntities toEntity() => ScoreEntities(
        success: success,
        dataScore: data,
        message: message,
    );

    factory ScoreModel.fromJson(Map<String, dynamic> json) => ScoreModel(
        success: json["success"] ?? false,
        data: json["data"] != null ? DataScore.fromJson(json["data"]) : DataScore(userId: "", scores: const [], summary: Summary(totalResponses: 0, questionnaires: const [], latestSubmission: DateTime.fromMillisecondsSinceEpoch(0))),
        message: json["message"] ?? "",
    );

    ScoreModel copyWith({
        bool? success,
        DataScore? data,
        String? message,
    }) => 
        ScoreModel(
            success: success ?? this.success,
            data: data ?? this.data,
            message: message ?? this.message,
        );
}

class DataScore {
    final String userId;
    final List<Score> scores;
    final Summary summary;

    DataScore({
        required this.userId,
        required this.scores,
        required this.summary,
    });

    factory DataScore.fromJson(Map<String, dynamic> json) => DataScore(
        userId: json["userId"] ?? "",
        scores: json["scores"] != null && json["scores"] is List
            ? List<Score>.from(json["scores"].map((x) => Score.fromJson(x)))
            : const [],
        summary: json["summary"] != null ? Summary.fromJson(json["summary"]) : Summary(totalResponses: 0, questionnaires: const [], latestSubmission: DateTime.fromMillisecondsSinceEpoch(0)),
    );

    DataScore copyWith({
        String? userId,
        List<Score>? scores,
        Summary? summary,
    }) => 
        DataScore(
            userId: userId ?? this.userId,
            scores: scores ?? this.scores,
            summary: summary ?? this.summary,
        );
}

class Score {
    final String id;
    final String questionnaireCode;
    final DateTime submittedAt;
    final List<DomainScore> domains;

    Score({
        required this.id,
        required this.questionnaireCode,
        required this.submittedAt,
        required this.domains,
    });

    factory Score.fromJson(Map<String, dynamic> json) => Score(
        id: json["id"] ?? "",
        questionnaireCode: json["questionnaireCode"] ?? "",
        submittedAt: json["submittedAt"] != null ? DateTime.parse(json["submittedAt"]) : DateTime.fromMillisecondsSinceEpoch(0),
        domains: json["domains"] != null && json["domains"] is List
            ? List<DomainScore>.from(json["domains"].map((x) => DomainScore.fromJson(x)))
            : const [],
    );

    Score copyWith({
        String? id,
        String? questionnaireCode,
        DateTime? submittedAt,
        List<DomainScore>? domains,
    }) => 
        Score(
            id: id ?? this.id,
            questionnaireCode: questionnaireCode ?? this.questionnaireCode,
            submittedAt: submittedAt ?? this.submittedAt,
            domains: domains ?? this.domains,
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

    factory DomainScore.fromJson(Map<String, dynamic> json) => DomainScore(
        domain: json["domain"] ?? "",
        rawScore: json["rawScore"] ?? 0,
        finalScore: json["finalScore"] ?? 0,
        category: json["category"] ?? "",
    );

    DomainScore copyWith({
        String? domain,
        int? rawScore,
        int? finalScore,
        String? category,
    }) => 
        DomainScore(
            domain: domain ?? this.domain,
            rawScore: rawScore ?? this.rawScore,
            finalScore: finalScore ?? this.finalScore,
            category: category ?? this.category,
        );
}

class Summary {
    final int totalResponses;
    final int? totalScores; // Add totalScores field
    final List<String> questionnaires;
    final List<QuestionnaireItem>? questionnaireItems; // Add questionnaire items with count
    final DateTime latestSubmission;

    Summary({
        required this.totalResponses,
        this.totalScores,
        required this.questionnaires,
        this.questionnaireItems,
        required this.latestSubmission,
    });

    factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        totalResponses: json["totalResponses"] ?? 0,
        totalScores: json["totalScores"], // Add totalScores parsing
        questionnaires: json["questionnaires"] != null && json["questionnaires"] is List && (json["questionnaires"] as List).isNotEmpty
            ? ((json["questionnaires"] as List).first is String
                ? List<String>.from(json["questionnaires"].map((x) => x.toString()))
                : []) // If questionnaires is array of objects, use empty list for backward compatibility
            : const [],
        questionnaireItems: json["questionnaires"] != null && json["questionnaires"] is List && (json["questionnaires"] as List).isNotEmpty
            ? ((json["questionnaires"] as List).first is Map
                ? List<QuestionnaireItem>.from(json["questionnaires"].map((x) => QuestionnaireItem.fromJson(x)))
                : null) // If questionnaires is array of objects, parse as QuestionnaireItem
            : null,
        latestSubmission: json["latestSubmission"] != null ? DateTime.parse(json["latestSubmission"]) : DateTime.fromMillisecondsSinceEpoch(0),
    );

    Summary copyWith({
        int? totalResponses,
        int? totalScores,
        List<String>? questionnaires,
        List<QuestionnaireItem>? questionnaireItems,
        DateTime? latestSubmission,
    }) => 
        Summary(
            totalResponses: totalResponses ?? this.totalResponses,
            totalScores: totalScores ?? this.totalScores,
            questionnaires: questionnaires ?? this.questionnaires,
            questionnaireItems: questionnaireItems ?? this.questionnaireItems,
            latestSubmission: latestSubmission ?? this.latestSubmission,
        );
}

class QuestionnaireItem {
    final String code;
    final int count;

    QuestionnaireItem({
        required this.code,
        required this.count,
    });

    factory QuestionnaireItem.fromJson(Map<String, dynamic> json) => QuestionnaireItem(
        code: json["code"] ?? "",
        count: json["count"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "count": count,
    };
}
