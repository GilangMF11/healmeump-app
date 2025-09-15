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
    final String domain;
    final int rawScore;
    final int finalScore;
    final String category;
    final DateTime submittedAt;

    Score({
        required this.id,
        required this.questionnaireCode,
        required this.domain,
        required this.rawScore,
        required this.finalScore,
        required this.category,
        required this.submittedAt,
    });

    factory Score.fromJson(Map<String, dynamic> json) => Score(
        id: json["id"] ?? "",
        questionnaireCode: json["questionnaireCode"] ?? "",
        domain: json["domain"] ?? "",
        rawScore: json["rawScore"] ?? 0,
        finalScore: json["finalScore"] ?? 0,
        category: json["category"] ?? "",
        submittedAt: json["submittedAt"] != null ? DateTime.parse(json["submittedAt"]) : DateTime.fromMillisecondsSinceEpoch(0),
    );

    Score copyWith({
        String? id,
        String? questionnaireCode,
        String? domain,
        int? rawScore,
        int? finalScore,
        String? category,
        DateTime? submittedAt,
    }) => 
        Score(
            id: id ?? this.id,
            questionnaireCode: questionnaireCode ?? this.questionnaireCode,
            domain: domain ?? this.domain,
            rawScore: rawScore ?? this.rawScore,
            finalScore: finalScore ?? this.finalScore,
            category: category ?? this.category,
            submittedAt: submittedAt ?? this.submittedAt,
        );
}

class Summary {
    final int totalResponses;
    final List<String> questionnaires;
    final DateTime latestSubmission;

    Summary({
        required this.totalResponses,
        required this.questionnaires,
        required this.latestSubmission,
    });

    factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        totalResponses: json["totalResponses"] ?? 0,
        questionnaires: json["questionnaires"] != null && json["questionnaires"] is List
            ? List<String>.from(json["questionnaires"].map((x) => x.toString()))
            : const [],
        latestSubmission: json["latestSubmission"] != null ? DateTime.parse(json["latestSubmission"]) : DateTime.fromMillisecondsSinceEpoch(0),
    );

    Summary copyWith({
        int? totalResponses,
        List<String>? questionnaires,
        DateTime? latestSubmission,
    }) => 
        Summary(
            totalResponses: totalResponses ?? this.totalResponses,
            questionnaires: questionnaires ?? this.questionnaires,
            latestSubmission: latestSubmission ?? this.latestSubmission,
        );
}
