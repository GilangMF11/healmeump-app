import 'package:healmeumpapp/features/mental_health/domain/entities/depression_questionnaire_entities.dart';

class DepressionQuestionnaireModel {
  final bool success;
  final List<DepressionQuestion> data;
  final String message;

  DepressionQuestionnaireModel({
    required this.success,
    required this.data,
    required this.message,
  });

  DepressionQuestionnaireEntities toEntity() => DepressionQuestionnaireEntities(
    success: success,
    data: data.map((question) => question.toEntity()).toList(),
    message: message,
  );

  factory DepressionQuestionnaireModel.fromJson(Map<String, dynamic> json) => DepressionQuestionnaireModel(
    success: json["success"] ?? false,
    data: json["data"] != null 
      ? (json["data"] as List).map((question) => DepressionQuestion.fromJson(question)).toList()
      : [],
    message: json["message"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.map((question) => question.toJson()).toList(),
    "message": message,
  };
}

class DepressionQuestion {
  final String id;
  final String questionnaireId;
  final int number;
  final int orderNumber;
  final String text;
  final String domain;
  final bool isReverse;
  final int maxScore;
  final DepressionQuestionMeta meta;
  final List<dynamic> options;

  DepressionQuestion({
    required this.id,
    required this.questionnaireId,
    required this.number,
    required this.orderNumber,
    required this.text,
    required this.domain,
    required this.isReverse,
    required this.maxScore,
    required this.meta,
    required this.options,
  });

  DepressionQuestionEntities toEntity() => DepressionQuestionEntities(
    id: id,
    questionnaireId: questionnaireId,
    number: number,
    orderNumber: orderNumber,
    text: text,
    domain: domain,
    isReverse: isReverse,
    maxScore: maxScore,
    meta: meta.toEntity(),
    options: options,
  );

  factory DepressionQuestion.fromJson(Map<String, dynamic> json) => DepressionQuestion(
    id: json["id"] ?? "",
    questionnaireId: json["questionnaireId"] ?? "",
    number: json["number"] ?? 0,
    orderNumber: json["orderNumber"] ?? 0,
    text: json["text"] ?? "",
    domain: json["domain"] ?? "",
    isReverse: json["isReverse"] ?? false,
    maxScore: json["maxScore"] ?? 0,
    meta: json["meta"] != null 
      ? DepressionQuestionMeta.fromJson(json["meta"]) 
      : DepressionQuestionMeta(options: []),
    options: json["options"] != null ? List<dynamic>.from(json["options"]) : [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "questionnaireId": questionnaireId,
    "number": number,
    "orderNumber": orderNumber,
    "text": text,
    "domain": domain,
    "isReverse": isReverse,
    "maxScore": maxScore,
    "meta": meta.toJson(),
    "options": options,
  };
}

class DepressionQuestionMeta {
  final List<DepressionQuestionOption> options;

  DepressionQuestionMeta({
    required this.options,
  });

  DepressionQuestionMetaEntities toEntity() => DepressionQuestionMetaEntities(
    options: options.map((option) => option.toEntity()).toList(),
  );

  factory DepressionQuestionMeta.fromJson(Map<String, dynamic> json) => DepressionQuestionMeta(
    options: json["options"] != null 
      ? (json["options"] as List).map((option) => DepressionQuestionOption.fromJson(option)).toList()
      : [],
  );

  Map<String, dynamic> toJson() => {
    "options": options.map((option) => option.toJson()).toList(),
  };
}

class DepressionQuestionOption {
  final String label;
  final int score;

  DepressionQuestionOption({
    required this.label,
    required this.score,
  });

  DepressionQuestionOptionEntities toEntity() => DepressionQuestionOptionEntities(
    label: label,
    score: score,
  );

  factory DepressionQuestionOption.fromJson(Map<String, dynamic> json) => DepressionQuestionOption(
    label: json["label"] ?? "",
    score: json["score"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "score": score,
  };
}
