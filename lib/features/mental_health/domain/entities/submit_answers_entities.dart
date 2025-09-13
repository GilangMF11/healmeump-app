import 'package:equatable/equatable.dart';

class SubmitAnswersEntities extends Equatable {
  final bool success;
  final DataSubmitAnswersEntities data;
  final String message;

  const SubmitAnswersEntities({
    required this.success,
    required this.data,
    required this.message,
  });

  @override
  List<Object?> get props => [success, data, message];
}

class DataSubmitAnswersEntities extends Equatable {
  final String userId;
  final List<ScoreEntities> scores;
  final SummaryEntities summary;

  const DataSubmitAnswersEntities({
    required this.userId,
    required this.scores,
    required this.summary,
  });

  @override
  List<Object?> get props => [userId, scores, summary];
}

class ScoreEntities extends Equatable {
  final String id;
  final String questionnaireCode;
  final String domain;
  final int rawScore;
  final int finalScore;
  final String category;
  final DateTime submittedAt;

  const ScoreEntities({
    required this.id,
    required this.questionnaireCode,
    required this.domain,
    required this.rawScore,
    required this.finalScore,
    required this.category,
    required this.submittedAt,
  });

  @override
  List<Object?> get props => [
        id,
        questionnaireCode,
        domain,
        rawScore,
        finalScore,
        category,
        submittedAt
      ];
}

class SummaryEntities extends Equatable {
  final int totalResponses;
  final List<String> questionnaires;
  final DateTime latestSubmission;

  const SummaryEntities({
    required this.totalResponses,
    required this.questionnaires,
    required this.latestSubmission,
  });

  @override
  List<Object?> get props => [totalResponses, questionnaires, latestSubmission];
}
