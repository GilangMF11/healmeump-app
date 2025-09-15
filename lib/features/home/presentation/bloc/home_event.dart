import 'package:equatable/equatable.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetVersionEvent extends HomeEvent {
  const GetVersionEvent();

  @override
  List<Object> get props => [];
}

class GetScoreHistoryEvent extends HomeEvent {
  final String userId;
  final String questionnaireCode;
  const GetScoreHistoryEvent({required this.userId, required this.questionnaireCode});

  @override
  List<Object> get props => [userId, questionnaireCode];
}

class GetScoreAdminHistoryEvent extends HomeEvent {
  final String limit;
  const GetScoreAdminHistoryEvent({required this.limit});

  @override
  List<Object> get props => [limit];
}

class GetExportAdminHistoryEvent extends HomeEvent {
  final bool includeEncryptedData;
  final String format;
  final String questionnaireCode;
  const GetExportAdminHistoryEvent({required this.includeEncryptedData, required this.format, required this.questionnaireCode});

  @override
  List<Object> get props => [includeEncryptedData, format, questionnaireCode];
}
