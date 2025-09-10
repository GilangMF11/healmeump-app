import 'package:equatable/equatable.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/create_answers_entities.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/mental_health_entities.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/save_answers_entities.dart';

class MentalhealthState extends Equatable {
  // Loading
  final bool? loadingQuestionnaire;
  final bool? loadingCreateAnswers;
  final bool? loadingSaveAnswers;
  // Status
  final String? statusQuestionnaire;
  final String? statusCreateAnswers;
  final String? statusSaveAnswers;
  // Message
  final String? messageQuestionnaire;
  final String? messageCreateAnswers;
  final String? messageSaveAnswers;
  // Data
  final MentalHealthEntities? dataQuestionnaire;
  final CreateAnswersEntities? dataCreateAnswers;
  final SaveAnswersEntities? dataSaveAnswers;

  const MentalhealthState({
    // Loading
    this.loadingQuestionnaire = false,
    this.loadingCreateAnswers = false,
    this.loadingSaveAnswers = false,
    // Status
    this.statusQuestionnaire,
    this.statusCreateAnswers,
    this.statusSaveAnswers,
    // Message
    this.messageQuestionnaire,
    this.messageCreateAnswers,
    this.messageSaveAnswers,
    // Data
    this.dataQuestionnaire,
    this.dataCreateAnswers,
    this.dataSaveAnswers,
  });

  MentalhealthState copyWith({
    // Loading
    bool? loadingQuestionnaire,
    bool? loadingCreateAnswers,
    bool? loadingSaveAnswers,
    // Status
    String? statusQuestionnaire,
    String? messageQuestionnaire,
    String? statusCreateAnswers,
    String? messageCreateAnswers,
    String? statusSaveAnswers,
    String? messageSaveAnswers,
    CreateAnswersEntities? dataCreateAnswers,
    SaveAnswersEntities? dataSaveAnswers,
    MentalHealthEntities? dataQuestionnaire,
  }) => MentalhealthState(
    // Loading
    loadingQuestionnaire: loadingQuestionnaire ?? this.loadingQuestionnaire,
    loadingCreateAnswers: loadingCreateAnswers ?? this.loadingCreateAnswers,
    loadingSaveAnswers: loadingSaveAnswers ?? this.loadingSaveAnswers,
    // Status
    statusQuestionnaire: statusQuestionnaire ?? this.statusQuestionnaire,
    messageQuestionnaire: messageQuestionnaire ?? this.messageQuestionnaire,
    statusCreateAnswers: statusCreateAnswers ?? this.statusCreateAnswers,
    messageCreateAnswers: messageCreateAnswers ?? this.messageCreateAnswers,
    statusSaveAnswers: statusSaveAnswers ?? this.statusSaveAnswers,
    messageSaveAnswers: messageSaveAnswers ?? this.messageSaveAnswers,
    // Data
    dataQuestionnaire: dataQuestionnaire ?? this.dataQuestionnaire,
    dataCreateAnswers: dataCreateAnswers ?? this.dataCreateAnswers,
    dataSaveAnswers: dataSaveAnswers ?? this.dataSaveAnswers,
  );

  @override
  List<Object?> get props => [
    loadingQuestionnaire,
    loadingCreateAnswers,
    loadingSaveAnswers,
    statusQuestionnaire,
    statusCreateAnswers,
    statusSaveAnswers,
    messageQuestionnaire,
    messageCreateAnswers,
    messageSaveAnswers,
    dataQuestionnaire,
    dataCreateAnswers,
    dataSaveAnswers,
  ];
}
