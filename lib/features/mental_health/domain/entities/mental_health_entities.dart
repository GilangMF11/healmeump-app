import 'package:equatable/equatable.dart';
import 'package:healmeumpapp/features/mental_health/data/model/mental_health_model.dart';

class MentalHealthEntities extends Equatable {
  final bool success;
  final List<DataMentalHealthEntities> data;
  final String message;

  const MentalHealthEntities({
    required this.success,
    required this.data,
    required this.message,
  });
  
  @override
  List<Object?> get props => [success, data, message];
}

class DataMentalHealthEntities extends Equatable {
  final String id;
  final String questionnaireId;
  final int number;
  final int orderNumber;
  final String text;
  final Domain domain;
  final bool isReverse;
  final int maxScore;
  final MetaEntities meta;
  final List<OptionEntities> options;

  const DataMentalHealthEntities({
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
  
  @override
  List<Object?> get props => [
    id, 
    questionnaireId, 
    number, 
    orderNumber, 
    text, 
    domain, 
    isReverse, 
    maxScore, 
    meta, 
    options
  ];
}

class MetaEntities extends Equatable {
  final List<int> options;

  const MetaEntities({
    required this.options,
  });
  
  @override
  List<Object?> get props => [options];
}

class OptionEntities extends Equatable {
  final String id;
  final String questionId;
  final int score;
  final Label label;

  const OptionEntities({
    required this.id,
    required this.questionId,
    required this.score,
    required this.label,
  });
  
  @override
  List<Object?> get props => [id, questionId, score, label];
}
