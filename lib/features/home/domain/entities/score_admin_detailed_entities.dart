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
  final String userId;
  final List<ScoreAdminEntities> scores;
  final SummaryAdminEntities summary;

  const DataScoreAdminDetailedEntities({
    required this.userId,
    required this.scores,
    required this.summary,
  });

  @override
  List<Object?> get props => [userId, scores, summary];
}

class ScoreAdminEntities extends Equatable {
  final String id;
  final String questionnaireCode;
  final DateTime submittedAt;
  final List<DomainScoreEntities> domains;

  const ScoreAdminEntities({
    required this.id,
    required this.questionnaireCode,
    required this.submittedAt,
    required this.domains,
  });

  @override
  List<Object?> get props => [
    id,
    questionnaireCode,
    submittedAt,
    domains,
  ];
}

class DomainScoreEntities extends Equatable {
  final String domain;
  final int rawScore;
  final int finalScore;
  final String category;

  const DomainScoreEntities({
    required this.domain,
    required this.rawScore,
    required this.finalScore,
    required this.category,
  });

  @override
  List<Object?> get props => [domain, rawScore, finalScore, category];
}

class SummaryAdminEntities extends Equatable {
  final int totalResponses;
  final List<String> questionnaires;
  final DateTime latestSubmission;

  const SummaryAdminEntities({
    required this.totalResponses,
    required this.questionnaires,
    required this.latestSubmission,
  });

  @override
  List<Object?> get props => [totalResponses, questionnaires, latestSubmission];
}

