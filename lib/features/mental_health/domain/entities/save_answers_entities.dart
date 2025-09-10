import 'package:equatable/equatable.dart';
import 'package:healmeumpapp/features/mental_health/data/model/save_answers_model.dart';

class SaveAnswersEntities extends Equatable {
  final bool success;
  final DataSaveAnswers data;
  final String message;

  const SaveAnswersEntities({
    required this.success,
    required this.data,
    required this.message,
  });
  
  @override
  List<Object?> get props => [success, data, message];
}

class DataSaveAnswersEntities extends Equatable {
  final int updatedCount;

  const DataSaveAnswersEntities({
    required this.updatedCount,
  });
  
  @override
  List<Object?> get props => [updatedCount];
}
