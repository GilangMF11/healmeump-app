import 'package:healmeumpapp/features/mental_health/domain/entities/mental_health_entities.dart';

class MentalHealthModel {
  final bool success;
  final List<DataMentalHealth> data;
  final String message;

  MentalHealthModel({
    required this.success,
    required this.data,
    required this.message,
  });

  MentalHealthEntities toEntity() => MentalHealthEntities(
        success: success,
        data: data.map((item) => item.toEntity()).toList(),
        message: message,
      );

  factory MentalHealthModel.fromJson(Map<String, dynamic> json) => MentalHealthModel(
        success: json["success"] ?? false,
        data: json["data"] != null && json["data"] is List
            ? List<DataMentalHealth>.from(
                json["data"].map((x) => DataMentalHealth.fromJson(x)))
            : [],
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };

  MentalHealthModel copyWith({
    bool? success,
    List<DataMentalHealth>? data,
    String? message,
  }) =>
      MentalHealthModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );
}

class DataMentalHealth {
  final String id;
  final String questionnaireId;
  final int number;
  final int orderNumber;
  final String text;
  final Domain domain;
  final bool isReverse;
  final int maxScore;
  final Meta meta;
  final List<Option> options;

  DataMentalHealth({
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

  DataMentalHealthEntities toEntity() => DataMentalHealthEntities(
        id: id,
        questionnaireId: questionnaireId,
        number: number,
        orderNumber: orderNumber,
        text: text,
        domain: domain,
        isReverse: isReverse,
        maxScore: maxScore,
        meta: meta.toEntity(),
        options: options.map((option) => option.toEntity()).toList(),
      );

  factory DataMentalHealth.fromJson(Map<String, dynamic> json) => DataMentalHealth(
        id: json["id"] ?? "",
        questionnaireId: json["questionnaire_id"] ?? "",
        number: json["number"] ?? 0,
        orderNumber: json["order_number"] ?? 0,
        text: json["text"] ?? "",
        domain: domainValues.map[json["domain"]] ?? Domain.D,
        isReverse: json["is_reverse"] ?? false,
        maxScore: json["max_score"] ?? 0,
        meta: json["meta"] != null ? Meta.fromJson(json["meta"]) : Meta(options: []),
        options: json["options"] != null && json["options"] is List
            ? List<Option>.from(json["options"].map((x) => Option.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "questionnaire_id": questionnaireId,
        "number": number,
        "order_number": orderNumber,
        "text": text,
        "domain": domainValues.reverse[domain],
        "is_reverse": isReverse,
        "max_score": maxScore,
        "meta": meta.toJson(),
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
      };

  DataMentalHealth copyWith({
    String? id,
    String? questionnaireId,
    int? number,
    int? orderNumber,
    String? text,
    Domain? domain,
    bool? isReverse,
    int? maxScore,
    Meta? meta,
    List<Option>? options,
  }) =>
      DataMentalHealth(
        id: id ?? this.id,
        questionnaireId: questionnaireId ?? this.questionnaireId,
        number: number ?? this.number,
        orderNumber: orderNumber ?? this.orderNumber,
        text: text ?? this.text,
        domain: domain ?? this.domain,
        isReverse: isReverse ?? this.isReverse,
        maxScore: maxScore ?? this.maxScore,
        meta: meta ?? this.meta,
        options: options ?? this.options,
      );
}

enum Domain {
  D,
  K,
  S
}

final domainValues = EnumValues({
  "D": Domain.D,
  "K": Domain.K,
  "S": Domain.S
});

class Meta {
  final List<int> options;

  Meta({
    required this.options,
  });

  MetaEntities toEntity() => MetaEntities(
        options: options,
      );

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        options: json["options"] != null && json["options"] is List
            ? List<int>.from(json["options"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "options": List<dynamic>.from(options.map((x) => x)),
      };

  Meta copyWith({
    List<int>? options,
  }) =>
      Meta(
        options: options ?? this.options,
      );
}

class Option {
  final String id;
  final String questionId;
  final int score;
  final Label label;

  Option({
    required this.id,
    required this.questionId,
    required this.score,
    required this.label,
  });

  OptionEntities toEntity() => OptionEntities(
        id: id,
        questionId: questionId,
        score: score,
        label: label,
      );

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"] ?? "",
        questionId: json["question_id"] ?? "",
        score: json["score"] ?? 0,
        label: labelValues.map[json["label"]] ?? Label.TIDAK_PERNAH,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question_id": questionId,
        "score": score,
        "label": labelValues.reverse[label],
      };

  Option copyWith({
    String? id,
    String? questionId,
    int? score,
    Label? label,
  }) =>
      Option(
        id: id ?? this.id,
        questionId: questionId ?? this.questionId,
        score: score ?? this.score,
        label: label ?? this.label,
      );
}

enum Label {
  KADANG_KADANG,
  SANGAT_SERING,
  SERING,
  TIDAK_PERNAH
}

final labelValues = EnumValues({
  "Kadang-kadang": Label.KADANG_KADANG,
  "Sangat sering": Label.SANGAT_SERING,
  "Sering": Label.SERING,
  "Tidak pernah": Label.TIDAK_PERNAH
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}