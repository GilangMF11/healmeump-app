import 'package:equatable/equatable.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/mental_health_entities.dart';

class MentalhealthState extends Equatable {
  final bool? loadingQuestionnaire;
  final String? statusQuestionnaire;
  final String? messageQuestionnaire;
  final MentalHealthEntities? dataQuestionnaire;

  const MentalhealthState({
    this.loadingQuestionnaire = false,
    this.statusQuestionnaire,
    this.messageQuestionnaire,
    this.dataQuestionnaire,
  });

  MentalhealthState copyWith({
    bool? loadingQuestionnaire,
    String? statusQuestionnaire,
    String? messageQuestionnaire,
    MentalHealthEntities? dataQuestionnaire,
  }) => MentalhealthState(
    loadingQuestionnaire: loadingQuestionnaire ?? this.loadingQuestionnaire,
    statusQuestionnaire: statusQuestionnaire ?? this.statusQuestionnaire,
    messageQuestionnaire: messageQuestionnaire ?? this.messageQuestionnaire,
    dataQuestionnaire: dataQuestionnaire ?? this.dataQuestionnaire,
  );

  @override
  List<Object?> get props => [
    loadingQuestionnaire,
    statusQuestionnaire,
    messageQuestionnaire,
    dataQuestionnaire,
  ];
}
