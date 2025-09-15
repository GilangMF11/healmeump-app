import 'package:healmeumpapp/features/mental_health/domain/entities/submit_answers_entities.dart';

class SubmitAnswersModel {
    final bool success;
    final DataSubmitAnswers data;
    final String message;

    SubmitAnswersModel({
        required this.success,
        required this.data,
        required this.message,
    });

    SubmitAnswersEntities toEntity() => SubmitAnswersEntities(
        success: success,
        data: data.toEntity(),
        message: message,
    );

    factory SubmitAnswersModel.fromJson(Map<String, dynamic> json) => SubmitAnswersModel(
        success: json["success"] ?? false,
        data: json["data"] != null ? DataSubmitAnswers.fromJson(json["data"]) : DataSubmitAnswers(
            response: Response(
                id: "",
                questionnaireId: "",
                entityType: "",
                prodiCode: "",
                prodiName: "",
                fakultas: null,
                externalProvider: "",
                externalSubject: "",
                rawIdentity: RawIdentity(
                    hp: "",
                    nip: "",
                    email: "",
                    prodi: "",
                    namaPegawai: "",
                    jenisPegawai: "",
                ),
                encryptedData: "",
                encryptionKey: "",
                userData: UserData(
                    hp: "",
                    nip: "",
                    email: "",
                    prodi: "",
                    namaPegawai: "",
                    jenisPegawai: "",
                ),
                startedAt: DateTime.now(),
                submittedAt: DateTime.now(),
            ),
            scores: [],
            summary: Summary(
                totalScores: 0,
                domains: [],
            ),
        ),
        message: json["message"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
    };

    SubmitAnswersModel copyWith({
        bool? success,
        DataSubmitAnswers? data,
        String? message,
    }) => 
        SubmitAnswersModel(
            success: success ?? this.success,
            data: data ?? this.data,
            message: message ?? this.message,
        );
}

class DataSubmitAnswers {
    final Response response;
    final List<Score> scores;
    final Summary summary;

    DataSubmitAnswers({
        required this.response,
        required this.scores,
        required this.summary,
    });

    DataSubmitAnswersEntities toEntity() => DataSubmitAnswersEntities(
        response: response.toEntity(),
        scores: scores.map((score) => score.toEntity()).toList(),
        summary: summary.toEntity(),
    );

    factory DataSubmitAnswers.fromJson(Map<String, dynamic> json) => DataSubmitAnswers(
        response: json["response"] != null 
            ? Response.fromJson(json["response"]) 
            : Response(
                id: "",
                questionnaireId: "",
                entityType: "",
                prodiCode: "",
                prodiName: "",
                fakultas: null,
                externalProvider: "",
                externalSubject: "",
                rawIdentity: RawIdentity(
                    hp: "",
                    nip: "",
                    email: "",
                    prodi: "",
                    namaPegawai: "",
                    jenisPegawai: "",
                ),
                encryptedData: "",
                encryptionKey: "",
                userData: UserData(
                    hp: "",
                    nip: "",
                    email: "",
                    prodi: "",
                    namaPegawai: "",
                    jenisPegawai: "",
                ),
                startedAt: DateTime.now(),
                submittedAt: DateTime.now(),
            ),
        scores: json["scores"] != null 
            ? (json["scores"] as List).map((score) => Score.fromJson(score)).toList()
            : [],
        summary: json["summary"] != null 
            ? Summary.fromJson(json["summary"]) 
            : Summary(
                totalScores: 0,
                domains: [],
            ),
    );

    Map<String, dynamic> toJson() => {
        "response": response.toJson(),
        "scores": scores.map((score) => score.toJson()).toList(),
        "summary": summary.toJson(),
    };

    DataSubmitAnswers copyWith({
        Response? response,
        List<Score>? scores,
        Summary? summary,
    }) => 
        DataSubmitAnswers(
            response: response ?? this.response,
            scores: scores ?? this.scores,
            summary: summary ?? this.summary,
        );
}

class Score {
    final String id;
    final String responseId;
    final String domain;
    final int rawScore;
    final int finalScore;
    final String category;
    final DateTime createdAt;

    Score({
        required this.id,
        required this.responseId,
        required this.domain,
        required this.rawScore,
        required this.finalScore,
        required this.category,
        required this.createdAt,
    });

    ScoreEntities toEntity() => ScoreEntities(
        id: id,
        responseId: responseId,
        domain: domain,
        rawScore: rawScore,
        finalScore: finalScore,
        category: category,
        createdAt: createdAt,
    );

    factory Score.fromJson(Map<String, dynamic> json) => Score(
        id: json["id"] ?? "",
        responseId: json["responseId"] ?? "",
        domain: json["domain"] ?? "",
        rawScore: json["rawScore"] ?? 0,
        finalScore: json["finalScore"] ?? 0,
        category: json["category"] ?? "",
        createdAt: json["createdAt"] != null 
            ? DateTime.parse(json["createdAt"]) 
            : DateTime.now(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "responseId": responseId,
        "domain": domain,
        "rawScore": rawScore,
        "finalScore": finalScore,
        "category": category,
        "createdAt": createdAt.toIso8601String(),
    };

    Score copyWith({
        String? id,
        String? responseId,
        String? domain,
        int? rawScore,
        int? finalScore,
        String? category,
        DateTime? createdAt,
    }) => 
        Score(
            id: id ?? this.id,
            responseId: responseId ?? this.responseId,
            domain: domain ?? this.domain,
            rawScore: rawScore ?? this.rawScore,
            finalScore: finalScore ?? this.finalScore,
            category: category ?? this.category,
            createdAt: createdAt ?? this.createdAt,
        );
}

class Summary {
    final int totalScores;
    final List<DomainSummary> domains;

    Summary({
        required this.totalScores,
        required this.domains,
    });

    SummaryEntities toEntity() => SummaryEntities(
        totalScores: totalScores,
        domains: domains.map((domain) => domain.toEntity()).toList(),
    );

    factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        totalScores: json["totalScores"] ?? 0,
        domains: json["domains"] != null 
            ? (json["domains"] as List).map((domain) => DomainSummary.fromJson(domain)).toList()
            : [],
    );

    Map<String, dynamic> toJson() => {
        "totalScores": totalScores,
        "domains": domains.map((domain) => domain.toJson()).toList(),
    };

    Summary copyWith({
        int? totalScores,
        List<DomainSummary>? domains,
    }) => 
        Summary(
            totalScores: totalScores ?? this.totalScores,
            domains: domains ?? this.domains,
        );
}

class Response {
    final String id;
    final String questionnaireId;
    final String entityType;
    final String prodiCode;
    final String prodiName;
    final String? fakultas;
    final String externalProvider;
    final String externalSubject;
    final RawIdentity rawIdentity;
    final String encryptedData;
    final String encryptionKey;
    final UserData userData;
    final DateTime startedAt;
    final DateTime submittedAt;

    Response({
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

    ResponseEntities toEntity() => ResponseEntities(
        id: id,
        questionnaireId: questionnaireId,
        entityType: entityType,
        prodiCode: prodiCode,
        prodiName: prodiName,
        fakultas: fakultas,
        externalProvider: externalProvider,
        externalSubject: externalSubject,
        rawIdentity: rawIdentity.toEntity(),
        encryptedData: encryptedData,
        encryptionKey: encryptionKey,
        userData: userData.toEntity(),
        startedAt: startedAt,
        submittedAt: submittedAt,
    );

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: json["id"] ?? "",
        questionnaireId: json["questionnaireId"] ?? "",
        entityType: json["entityType"] ?? "",
        prodiCode: json["prodiCode"] ?? "",
        prodiName: json["prodiName"] ?? "",
        fakultas: json["fakultas"],
        externalProvider: json["externalProvider"] ?? "",
        externalSubject: json["externalSubject"] ?? "",
        rawIdentity: json["rawIdentity"] != null 
            ? RawIdentity.fromJson(json["rawIdentity"]) 
            : RawIdentity(
                hp: "",
                nip: "",
                email: "",
                prodi: "",
                namaPegawai: "",
                jenisPegawai: "",
            ),
        encryptedData: json["encryptedData"] ?? "",
        encryptionKey: json["encryptionKey"] ?? "",
        userData: json["userData"] != null 
            ? UserData.fromJson(json["userData"]) 
            : UserData(
                hp: "",
                nip: "",
                email: "",
                prodi: "",
                namaPegawai: "",
                jenisPegawai: "",
            ),
        startedAt: json["startedAt"] != null 
            ? DateTime.parse(json["startedAt"]) 
            : DateTime.now(),
        submittedAt: json["submittedAt"] != null 
            ? DateTime.parse(json["submittedAt"]) 
            : DateTime.now(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "questionnaireId": questionnaireId,
        "entityType": entityType,
        "prodiCode": prodiCode,
        "prodiName": prodiName,
        "fakultas": fakultas,
        "externalProvider": externalProvider,
        "externalSubject": externalSubject,
        "rawIdentity": rawIdentity.toJson(),
        "encryptedData": encryptedData,
        "encryptionKey": encryptionKey,
        "userData": userData.toJson(),
        "startedAt": startedAt.toIso8601String(),
        "submittedAt": submittedAt.toIso8601String(),
    };
}

class RawIdentity {
    final String hp;
    final String nip;
    final String email;
    final String prodi;
    final String namaPegawai;
    final String jenisPegawai;

    RawIdentity({
        required this.hp,
        required this.nip,
        required this.email,
        required this.prodi,
        required this.namaPegawai,
        required this.jenisPegawai,
    });

    RawIdentityEntities toEntity() => RawIdentityEntities(
        hp: hp,
        nip: nip,
        email: email,
        prodi: prodi,
        namaPegawai: namaPegawai,
        jenisPegawai: jenisPegawai,
    );

    factory RawIdentity.fromJson(Map<String, dynamic> json) => RawIdentity(
        hp: json["hp"] ?? "",
        nip: json["NIP"] ?? "",
        email: json["email"] ?? "",
        prodi: json["prodi"] ?? "",
        namaPegawai: json["nama_pegawai"] ?? "",
        jenisPegawai: json["jenis_pegawai"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "hp": hp,
        "NIP": nip,
        "email": email,
        "prodi": prodi,
        "nama_pegawai": namaPegawai,
        "jenis_pegawai": jenisPegawai,
    };
}

class UserData {
    final String hp;
    final String nip;
    final String email;
    final String prodi;
    final String namaPegawai;
    final String jenisPegawai;

    UserData({
        required this.hp,
        required this.nip,
        required this.email,
        required this.prodi,
        required this.namaPegawai,
        required this.jenisPegawai,
    });

    UserDataEntities toEntity() => UserDataEntities(
        hp: hp,
        nip: nip,
        email: email,
        prodi: prodi,
        namaPegawai: namaPegawai,
        jenisPegawai: jenisPegawai,
    );

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        hp: json["hp"] ?? "",
        nip: json["NIP"] ?? "",
        email: json["email"] ?? "",
        prodi: json["prodi"] ?? "",
        namaPegawai: json["nama_pegawai"] ?? "",
        jenisPegawai: json["jenis_pegawai"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "hp": hp,
        "NIP": nip,
        "email": email,
        "prodi": prodi,
        "nama_pegawai": namaPegawai,
        "jenis_pegawai": jenisPegawai,
    };
}

class DomainSummary {
    final String domain;
    final String category;

    DomainSummary({
        required this.domain,
        required this.category,
    });

    DomainSummaryEntities toEntity() => DomainSummaryEntities(
        domain: domain,
        category: category,
    );

    factory DomainSummary.fromJson(Map<String, dynamic> json) => DomainSummary(
        domain: json["domain"] ?? "",
        category: json["category"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "domain": domain,
        "category": category,
    };
}
