import 'package:equatable/equatable.dart';

class MentalhealthEvent extends Equatable {
  const MentalhealthEvent();

  @override
  List<Object> get props => [];
}

class GetQuestionnairebyCodeNameEvent extends MentalhealthEvent {
  final String codeName;

  const GetQuestionnairebyCodeNameEvent({required this.codeName});

  @override
  List<Object> get props => [codeName];
}
