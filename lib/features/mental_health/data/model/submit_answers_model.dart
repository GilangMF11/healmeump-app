import 'package:healmeumpapp/features/mental_health/domain/entities/submit_answers_entities.dart';

class SubmitAnswersModel {
    final bool success;
    final DataSubmitAnswers data;
    final String message;

    SubmitAnswersModel({
        required this.success,
        required this.data,
        required this.message,
    });

    SubmitAnswersEntities toEntity() => SubmitAnswersEntities(
        success: success,
        data: data.toEntity(),
        message: message,
    );

    factory SubmitAnswersModel.fromJson(Map<String, dynamic> json) => SubmitAnswersModel(
        success: json["success"] ?? false,
        data: json["data"] != null ? DataSubmitAnswers.fromJson(json["data"]) : DataSubmitAnswers(
            userId: "",
            scores: [],
            summary: Summary(
                totalResponses: 0,
                questionnaires: [],
                latestSubmission: DateTime.now(),
            ),
        ),
        message: json["message"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
    };

    SubmitAnswersModel copyWith({
        bool? success,
        DataSubmitAnswers? data,
        String? message,
    }) => 
        SubmitAnswersModel(
            success: success ?? this.success,
            data: data ?? this.data,
            message: message ?? this.message,
        );
}

class DataSubmitAnswers {
    final String userId;
    final List<Score> scores;
    final Summary summary;

    DataSubmitAnswers({
        required this.userId,
        required this.scores,
        required this.summary,
    });

    DataSubmitAnswersEntities toEntity() => DataSubmitAnswersEntities(
        userId: userId,
        scores: scores.map((score) => score.toEntity()).toList(),
        summary: summary.toEntity(),
    );

    factory DataSubmitAnswers.fromJson(Map<String, dynamic> json) => DataSubmitAnswers(
        userId: json["userId"] ?? "",
        scores: json["scores"] != null 
            ? (json["scores"] as List).map((score) => Score.fromJson(score)).toList()
            : [],
        summary: json["summary"] != null 
            ? Summary.fromJson(json["summary"]) 
            : Summary(
                totalResponses: 0,
                questionnaires: [],
                latestSubmission: DateTime.now(),
            ),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "scores": scores.map((score) => score.toJson()).toList(),
        "summary": summary.toJson(),
    };

    DataSubmitAnswers copyWith({
        String? userId,
        List<Score>? scores,
        Summary? summary,
    }) => 
        DataSubmitAnswers(
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

    ScoreEntities toEntity() => ScoreEntities(
        id: id,
        questionnaireCode: questionnaireCode,
        domain: domain,
        rawScore: rawScore,
        finalScore: finalScore,
        category: category,
        submittedAt: submittedAt,
    );

    factory Score.fromJson(Map<String, dynamic> json) => Score(
        id: json["id"] ?? "",
        questionnaireCode: json["questionnaireCode"] ?? "",
        domain: json["domain"] ?? "",
        rawScore: json["rawScore"] ?? 0,
        finalScore: json["finalScore"] ?? 0,
        category: json["category"] ?? "",
        submittedAt: json["submittedAt"] != null 
            ? DateTime.parse(json["submittedAt"]) 
            : DateTime.now(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "questionnaireCode": questionnaireCode,
        "domain": domain,
        "rawScore": rawScore,
        "finalScore": finalScore,
        "category": category,
        "submittedAt": submittedAt.toIso8601String(),
    };

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

    SummaryEntities toEntity() => SummaryEntities(
        totalResponses: totalResponses,
        questionnaires: questionnaires,
        latestSubmission: latestSubmission,
    );

    factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        totalResponses: json["totalResponses"] ?? 0,
        questionnaires: json["questionnaires"] != null 
            ? List<String>.from(json["questionnaires"])
            : [],
        latestSubmission: json["latestSubmission"] != null 
            ? DateTime.parse(json["latestSubmission"]) 
            : DateTime.now(),
    );

    Map<String, dynamic> toJson() => {
        "totalResponses": totalResponses,
        "questionnaires": questionnaires,
        "latestSubmission": latestSubmission.toIso8601String(),
    };

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
