import 'package:equatable/equatable.dart';

class ScoreAdminDetailedEntities extends Equatable {
  final bool success;
  final DataScoreAdminDetailedEntities dataScoreAdmin;
  final String message;

  const ScoreAdminDetailedEntities({
    required this.success,
    required this.dataScoreAdmin,
    required this.message,
  });

  @override
  List<Object?> get props => [success, dataScoreAdmin, message];
}

class DataScoreAdminDetailedEntities extends Equatable {
  final List<ScoreAdminEntities> scores;
  final SummaryAdminEntities summary;
  final PaginationEntities pagination;

  const DataScoreAdminDetailedEntities({
    required this.scores,
    required this.summary,
    required this.pagination,
  });

  @override
  List<Object?> get props => [scores, summary, pagination];
}

class ScoreAdminEntities extends Equatable {
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

  const ScoreAdminEntities({
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

  @override
  List<Object?> get props => [
    id,
    responseId,
    questionnaireCode,
    domain,
    rawScore,
    finalScore,
    category,
    submittedAt,
    encryptedUserId,
    encryptedUserData,
  ];
}

class SummaryAdminEntities extends Equatable {
  final int totalScores;
  final List<QuestionnaireCountEntities> questionnaires;
  final List<CategoryCountEntities> categories;

  const SummaryAdminEntities({
    required this.totalScores,
    required this.questionnaires,
    required this.categories,
  });

  @override
  List<Object?> get props => [totalScores, questionnaires, categories];
}

class QuestionnaireCountEntities extends Equatable {
  final String code;
  final int count;

  const QuestionnaireCountEntities({
    required this.code,
    required this.count,
  });

  @override
  List<Object?> get props => [code, count];
}

class CategoryCountEntities extends Equatable {
  final String category;
  final int count;

  const CategoryCountEntities({
    required this.category,
    required this.count,
  });

  @override
  List<Object?> get props => [category, count];
}

class PaginationEntities extends Equatable {
  final int limit;
  final int offset;
  final int total;

  const PaginationEntities({
    required this.limit,
    required this.offset,
    required this.total,
  });

  @override
  List<Object?> get props => [limit, offset, total];
}
