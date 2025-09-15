class DepressionQuestionnaireEntities {
  final bool success;
  final List<DepressionQuestionEntities> data;
  final String message;

  DepressionQuestionnaireEntities({
    required this.success,
    required this.data,
    required this.message,
  });
}

class DepressionQuestionEntities {
  final String id;
  final String questionnaireId;
  final int number;
  final int orderNumber;
  final String text;
  final String domain;
  final bool isReverse;
  final int maxScore;
  final DepressionQuestionMetaEntities meta;
  final List<dynamic> options;

  DepressionQuestionEntities({
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
}

class DepressionQuestionMetaEntities {
  final List<DepressionQuestionOptionEntities> options;

  DepressionQuestionMetaEntities({
    required this.options,
  });
}

class DepressionQuestionOptionEntities {
  final String label;
  final int score;

  DepressionQuestionOptionEntities({
    required this.label,
    required this.score,
  });
}
