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
  final ResponseEntities response;
  final List<ScoreEntities> scores;
  final SummaryEntities summary;

  const DataSubmitAnswersEntities({
    required this.response,
    required this.scores,
    required this.summary,
  });
  
  @override
  List<Object?> get props => [response, scores, summary];
}

class ScoreEntities extends Equatable {
  final String id;
  final String responseId;
  final String domain;
  final int rawScore;
  final int finalScore;
  final String category;
  final DateTime createdAt;

  const ScoreEntities({
    required this.id,
    required this.responseId,
    required this.domain,
    required this.rawScore,
    required this.finalScore,
    required this.category,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        responseId,
        domain,
        rawScore,
        finalScore,
        category,
        createdAt
      ];
}

class SummaryEntities extends Equatable {
  final int totalScores;
  final List<DomainSummaryEntities> domains;

  const SummaryEntities({
    required this.totalScores,
    required this.domains,
  });

  @override
  List<Object?> get props => [totalScores, domains];
}

class ResponseEntities extends Equatable {
  final String id;
  final String questionnaireId;
  final String entityType;
  final String prodiCode;
  final String prodiName;
  final String? fakultas;
  final String externalProvider;
  final String externalSubject;
  final RawIdentityEntities rawIdentity;
  final String encryptedData;
  final String encryptionKey;
  final UserDataEntities userData;
  final DateTime startedAt;
  final DateTime submittedAt;

  const ResponseEntities({
    required this.id,
    required this.questionnaireId,
    required this.entityType,
    required this.prodiCode,
    required this.prodiName,
    this.fakultas,
    required this.externalProvider,
    required this.externalSubject,
    required this.rawIdentity,
    required this.encryptedData,
    required this.encryptionKey,
    required this.userData,
    required this.startedAt,
    required this.submittedAt,
  });

  @override
  List<Object?> get props => [
    id,
    questionnaireId,
    entityType,
    prodiCode,
    prodiName,
    fakultas,
    externalProvider,
    externalSubject,
    rawIdentity,
    encryptedData,
    encryptionKey,
    userData,
    startedAt,
    submittedAt,
  ];
}

class RawIdentityEntities extends Equatable {
  final String hp;
  final String nip;
  final String email;
  final String prodi;
  final String namaPegawai;
  final String jenisPegawai;

  const RawIdentityEntities({
    required this.hp,
    required this.nip,
    required this.email,
    required this.prodi,
    required this.namaPegawai,
    required this.jenisPegawai,
  });

  @override
  List<Object?> get props => [hp, nip, email, prodi, namaPegawai, jenisPegawai];
}

class UserDataEntities extends Equatable {
  final String hp;
  final String nip;
  final String email;
  final String prodi;
  final String namaPegawai;
  final String jenisPegawai;

  const UserDataEntities({
    required this.hp,
    required this.nip,
    required this.email,
    required this.prodi,
    required this.namaPegawai,
    required this.jenisPegawai,
  });

  @override
  List<Object?> get props => [hp, nip, email, prodi, namaPegawai, jenisPegawai];
}

class DomainSummaryEntities extends Equatable {
  final String domain;
  final String category;

  const DomainSummaryEntities({
    required this.domain,
    required this.category,
  });

  @override
  List<Object?> get props => [domain, category];
}
