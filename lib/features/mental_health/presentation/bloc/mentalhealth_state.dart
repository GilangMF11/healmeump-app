import 'package:equatable/equatable.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/create_answers_entities.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/mental_health_entities.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/save_answers_entities.dart';
import 'package:healmeumpapp/features/mental_health/domain/entities/submit_answers_entities.dart';

class MentalhealthState extends Equatable {
  // Loading
  final bool? loadingQuestionnaire;
  final bool? loadingCreateAnswers;
  final bool? loadingSaveAnswers;
  final bool? loadingSubmitAnswers;
  // Status
  final String? statusQuestionnaire;
  final String? statusCreateAnswers;
  final String? statusSaveAnswers;
  final String? statusSubmitAnswers;
  // Message
  final String? messageQuestionnaire;
  final String? messageCreateAnswers;
  final String? messageSaveAnswers;
  final String? messageSubmitAnswers;
  // Data
  final MentalHealthEntities? dataQuestionnaire;
  final CreateAnswersEntities? dataCreateAnswers;
  final SaveAnswersEntities? dataSaveAnswers;
  final SubmitAnswersEntities? dataSubmitAnswers;

  
  const MentalhealthState({
    // Loading
    this.loadingQuestionnaire = false,
    this.loadingCreateAnswers = false,
    this.loadingSaveAnswers = false,
    this.loadingSubmitAnswers = false,
    // Status
    this.statusQuestionnaire,
    this.statusCreateAnswers,
    this.statusSaveAnswers,
    this.statusSubmitAnswers,
    // Message
    this.messageQuestionnaire,
    this.messageCreateAnswers,
    this.messageSaveAnswers,  
    this.messageSubmitAnswers,
    // Data
    this.dataQuestionnaire,
    this.dataCreateAnswers,
    this.dataSaveAnswers,
    this.dataSubmitAnswers,
  });

  MentalhealthState copyWith({
    // Loading
    bool? loadingQuestionnaire,
    bool? loadingCreateAnswers,
    bool? loadingSaveAnswers,
    bool? loadingSubmitAnswers,
    // Status
    String? statusQuestionnaire,
    String? messageQuestionnaire,
    String? statusCreateAnswers,
    String? messageCreateAnswers,
    String? statusSaveAnswers,
    String? messageSaveAnswers,
    String? statusSubmitAnswers,
    String? messageSubmitAnswers,
    // Data
    CreateAnswersEntities? dataCreateAnswers,
    SaveAnswersEntities? dataSaveAnswers,
    MentalHealthEntities? dataQuestionnaire,
    SubmitAnswersEntities? dataSubmitAnswers,
  }) => MentalhealthState(
    // Loading
    loadingQuestionnaire: loadingQuestionnaire ?? this.loadingQuestionnaire,
    loadingCreateAnswers: loadingCreateAnswers ?? this.loadingCreateAnswers,
    loadingSaveAnswers: loadingSaveAnswers ?? this.loadingSaveAnswers,
    loadingSubmitAnswers: loadingSubmitAnswers ?? this.loadingSubmitAnswers,
    // Status
    statusQuestionnaire: statusQuestionnaire ?? this.statusQuestionnaire,
    messageQuestionnaire: messageQuestionnaire ?? this.messageQuestionnaire,
    statusCreateAnswers: statusCreateAnswers ?? this.statusCreateAnswers,
    messageCreateAnswers: messageCreateAnswers ?? this.messageCreateAnswers,
    statusSaveAnswers: statusSaveAnswers ?? this.statusSaveAnswers,
    messageSaveAnswers: messageSaveAnswers ?? this.messageSaveAnswers,
    statusSubmitAnswers: statusSubmitAnswers ?? this.statusSubmitAnswers,
    messageSubmitAnswers: messageSubmitAnswers ?? this.messageSubmitAnswers,
    // Data
    dataQuestionnaire: dataQuestionnaire ?? this.dataQuestionnaire,
    dataCreateAnswers: dataCreateAnswers ?? this.dataCreateAnswers,
    dataSaveAnswers: dataSaveAnswers ?? this.dataSaveAnswers,
    dataSubmitAnswers: dataSubmitAnswers ?? this.dataSubmitAnswers,
    
  );

  @override
  List<Object?> get props => [
    // Loading
    loadingQuestionnaire,
    loadingCreateAnswers,
    loadingSaveAnswers,
    loadingSubmitAnswers,
    // Status
    statusQuestionnaire,
    statusCreateAnswers,
    statusSaveAnswers,
    statusSubmitAnswers,
    // Message
    messageQuestionnaire,
    messageCreateAnswers,
    messageSaveAnswers,
    messageSubmitAnswers,
    // Data
    dataQuestionnaire,
    dataSubmitAnswers,
    dataCreateAnswers,
    dataSaveAnswers,
  ];
}
