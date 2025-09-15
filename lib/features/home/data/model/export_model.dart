import 'package:healmeumpapp/features/home/domain/entities/export_entities.dart';

class ExportModel {
    final bool success;
    final DataExport data;
    final String message;

    ExportModel({
        required this.success,
        required this.data,
        required this.message,
    });

    ExportEntities toEntity() => ExportEntities(
        success: success,
        dataExport: data,
        message: message,
    );

    factory ExportModel.fromJson(Map<String, dynamic> json) => ExportModel(
        success: json["success"] ?? false,
        data: json["data"] != null ? DataExport.fromJson(json["data"]) : DataExport(data: const [], summary: Summary(totalRecords: 0, questionnaires: const [], categories: const [], exportDate: DateTime.fromMillisecondsSinceEpoch(0)), format: ""),
        message: json["message"] ?? "",
    );

    ExportModel copyWith({
        bool? success,
        DataExport? data,
        String? message,
    }) => 
        ExportModel(
            success: success ?? this.success,
            data: data ?? this.data,
            message: message ?? this.message,
        );
}

class DataExport {
    final List<DataExportDetail> data;
    final Summary summary;
    final String format;

    DataExport({
        required this.data,
        required this.summary,
        required this.format,
    });

    factory DataExport.fromJson(Map<String, dynamic> json) => DataExport(
        data: json["data"] != null && json["data"] is List
            ? List<DataExportDetail>.from(json["data"].map((x) => DataExportDetail.fromJson(x)))
            : const [],
        summary: json["summary"] != null ? Summary.fromJson(json["summary"]) : Summary(totalRecords: 0, questionnaires: const [], categories: const [], exportDate: DateTime.fromMillisecondsSinceEpoch(0)),
        format: json["format"] ?? "",
    );

    DataExport copyWith({
        List<DataExportDetail>? data,
        Summary? summary,
        String? format,
    }) => 
        DataExport(
            data: data ?? this.data,
            summary: summary ?? this.summary,
            format: format ?? this.format,
        );
}

class DataExportDetail {
    final String id;
    final String responseId;
    final String questionnaireCode;
    final String domain;
    final int rawScore;
    final int finalScore;
    final String category;
    final DateTime submittedAt;
    final String userId;
    final UserData userData;
    final Encrypt encryptionKey;
    final Encrypt encryptedData;

    DataExportDetail({
        required this.id,
        required this.responseId,
        required this.questionnaireCode,
        required this.domain,
        required this.rawScore,
        required this.finalScore,
        required this.category,
        required this.submittedAt,
        required this.userId,
        required this.userData,
        required this.encryptionKey,
        required this.encryptedData,
    });

    factory DataExportDetail.fromJson(Map<String, dynamic> json) => DataExportDetail(
        id: json["id"] ?? "",
        responseId: json["responseId"] ?? "",
        questionnaireCode: json["questionnaireCode"] ?? "",
        domain: json["domain"] ?? "",
        rawScore: json["rawScore"] ?? 0,
        finalScore: json["finalScore"] ?? 0,
        category: json["category"] ?? "",
        submittedAt: json["submittedAt"] != null ? DateTime.parse(json["submittedAt"]) : DateTime.fromMillisecondsSinceEpoch(0),
        userId: json["userId"] ?? "",
        userData: json["userData"] != null ? UserData.fromJson(json["userData"]) : UserData(nip: "", namaPegawai: "", email: "", hp: "", prodi: Prodi.INFORMATIKA, fakultas: Fakultas.EMPTY),
        encryptionKey: json["encryptionKey"] != null && json["encryptionKey"].toString().isNotEmpty ? Encrypt.ANONYMIZED : Encrypt.ANONYMIZED,
        encryptedData: json["encryptedData"] != null && json["encryptedData"].toString().isNotEmpty ? Encrypt.ANONYMIZED : Encrypt.ANONYMIZED,
    );

    DataExportDetail copyWith({
        String? id,
        String? responseId,
        String? questionnaireCode,
        String? domain,
        int? rawScore,
        int? finalScore,
        String? category,
        DateTime? submittedAt,
        String? userId,
        UserData? userData,
        Encrypt? encryptionKey,
        Encrypt? encryptedData,
    }) => 
        DataExportDetail(
            id: id ?? this.id,
            responseId: responseId ?? this.responseId,
            questionnaireCode: questionnaireCode ?? this.questionnaireCode,
            domain: domain ?? this.domain,
            rawScore: rawScore ?? this.rawScore,
            finalScore: finalScore ?? this.finalScore,
            category: category ?? this.category,
            submittedAt: submittedAt ?? this.submittedAt,
            userId: userId ?? this.userId,
            userData: userData ?? this.userData,
            encryptionKey: encryptionKey ?? this.encryptionKey,
            encryptedData: encryptedData ?? this.encryptedData,
        );
}

enum Encrypt {
    ANONYMIZED
}

class UserData {
    final String nip;
    final String namaPegawai;
    final String email;
    final String hp;
    final Prodi prodi;
    final Fakultas fakultas;

    UserData({
        required this.nip,
        required this.namaPegawai,
        required this.email,
        required this.hp,
        required this.prodi,
        required this.fakultas,
    });

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        nip: json["nip"] ?? "",
        namaPegawai: json["namaPegawai"] ?? "",
        email: json["email"] ?? "",
        hp: json["hp"] ?? "",
        prodi: _prodiFromString(json["prodi"]),
        fakultas: _fakultasFromString(json["fakultas"]),
    );

    UserData copyWith({
        String? nip,
        String? namaPegawai,
        String? email,
        String? hp,
        Prodi? prodi,
        Fakultas? fakultas,
    }) => 
        UserData(
            nip: nip ?? this.nip,
            namaPegawai: namaPegawai ?? this.namaPegawai,
            email: email ?? this.email,
            hp: hp ?? this.hp,
            prodi: prodi ?? this.prodi,
            fakultas: fakultas ?? this.fakultas,
        );
}

enum Fakultas {
    EMPTY,
    FMIPA
}

enum Prodi {
    INFORMATIKA,
    MANAJEMEN_S1
}

Prodi _prodiFromString(dynamic value) {
    switch (value) {
        case 'INFORMATIKA':
            return Prodi.INFORMATIKA;
        case 'MANAJEMEN_S1':
            return Prodi.MANAJEMEN_S1;
        default:
            return Prodi.INFORMATIKA;
    }
}

Fakultas _fakultasFromString(dynamic value) {
    switch (value) {
        case 'FMIPA':
            return Fakultas.FMIPA;
        default:
            return Fakultas.EMPTY;
    }
}

class Summary {
    final int totalRecords;
    final List<Questionnaire> questionnaires;
    final List<Category> categories;
    final DateTime exportDate;

    Summary({
        required this.totalRecords,
        required this.questionnaires,
        required this.categories,
        required this.exportDate,
    });

    factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        totalRecords: json["totalRecords"] ?? 0,
        questionnaires: json["questionnaires"] != null && json["questionnaires"] is List
            ? List<Questionnaire>.from(json["questionnaires"].map((x) => Questionnaire.fromJson(x)))
            : const [],
        categories: json["categories"] != null && json["categories"] is List
            ? List<Category>.from(json["categories"].map((x) => Category.fromJson(x)))
            : const [],
        exportDate: json["exportDate"] != null ? DateTime.parse(json["exportDate"]) : DateTime.fromMillisecondsSinceEpoch(0),
    );

    Summary copyWith({
        int? totalRecords,
        List<Questionnaire>? questionnaires,
        List<Category>? categories,
        DateTime? exportDate,
    }) => 
        Summary(
            totalRecords: totalRecords ?? this.totalRecords,
            questionnaires: questionnaires ?? this.questionnaires,
            categories: categories ?? this.categories,
            exportDate: exportDate ?? this.exportDate,
        );
}

class Category {
    final String category;
    final int count;

    Category({
        required this.category,
        required this.count,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        category: json["category"] ?? "",
        count: json["count"] ?? 0,
    );

    Category copyWith({
        String? category,
        int? count,
    }) => 
        Category(
            category: category ?? this.category,
            count: count ?? this.count,
        );
}

class Questionnaire {
    final String code;
    final int count;

    Questionnaire({
        required this.code,
        required this.count,
    });

    factory Questionnaire.fromJson(Map<String, dynamic> json) => Questionnaire(
        code: json["code"] ?? "",
        count: json["count"] ?? 0,
    );

    Questionnaire copyWith({
        String? code,
        int? count,
    }) => 
        Questionnaire(
            code: code ?? this.code,
            count: count ?? this.count,
        );
}
