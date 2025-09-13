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

class CreateAnswersEvent extends MentalhealthEvent {
  final String questionnaireCode;
  final String userId;
  final String namaPegawai;
  final String nip;
  final String jenisPegawai;
  final String prodi;
  final String email;
  final String hp;

  const CreateAnswersEvent(
      {required this.questionnaireCode,
      required this.userId,
      required this.namaPegawai,
      required this.nip,
      required this.jenisPegawai,
      required this.prodi,
      required this.email,
      required this.hp,
      });

  @override
  List<Object> get props => [
        questionnaireCode,
        userId,
        namaPegawai,
        nip,
        jenisPegawai,
        prodi,
        email,
        hp
      ];
}

class SaveAnswersEvent extends MentalhealthEvent {
  final List<Map<String, dynamic>> answers;
  final String responseId;

  const SaveAnswersEvent({required this.answers, required this.responseId});

  @override
  List<Object> get props => [answers, responseId];
}

class SubmitAnswersEvent extends MentalhealthEvent {
  final String responseId;

  const SubmitAnswersEvent({required this.responseId});

  @override
  List<Object> get props => [responseId];
}
