import 'package:equatable/equatable.dart';
import 'package:healmeumpapp/features/mental_health/data/model/create_answers_model.dart';

class CreateAnswersEntities extends Equatable {
  final bool success;
  final DataCreateAnswers data;
  final String message;

  const CreateAnswersEntities({
    required this.success,
    required this.data,
    required this.message,
  });
  
  @override
  List<Object?> get props => [success, data, message];
}

class DataCreateAnswersEntities extends Equatable {
  final String responseId;
  final String questionnaireCode;
  final String status;
  final DateTime createdAt;

  const DataCreateAnswersEntities({
    required this.responseId,
    required this.questionnaireCode,
    required this.status,
    required this.createdAt,
  });
  
  @override
  List<Object?> get props => [responseId, questionnaireCode, status, createdAt];
}
