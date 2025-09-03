import 'package:healmeumpapp/features/home/domain/entities/version_entities.dart';

class VersionModel {
    final bool success;
    final List<DataVersion> data;
    final String message;

    VersionModel({
        required this.success,
        required this.data,
        required this.message,
    });

    VersionEntities toEntity() => VersionEntities(
        success: success,
        dataVersion: data,
        message: message,
    );

    factory VersionModel.fromJson(Map<String, dynamic> json) => VersionModel(
        success: json["success"],
        data: json["data"] == null 
        ? [] 
        : List<DataVersion>.from(json["data"].map((x) => DataVersion.fromJson(x))),
        message: json["message"],
    );

    VersionModel copyWith({
        bool? success,
        List<DataVersion>? data,
        String? message,
    }) => 
        VersionModel(
            success: success ?? this.success,
            data: data ?? this.data,
            message: message ?? this.message,
        );
}

class DataVersion {
    final String id;
    final String platform;
    final String versionSemver;
    final int buildNumber;
    final bool isForced;
    final String minSupported;
    final String storeUrl;
    final dynamic downloadUrl;
    final String releaseNotes;
    final bool isActive;
    final DateTime releasedAt;

    DataVersion({
        required this.id,
        required this.platform,
        required this.versionSemver,
        required this.buildNumber,
        required this.isForced,
        required this.minSupported,
        required this.storeUrl,
        required this.downloadUrl,
        required this.releaseNotes,
        required this.isActive,
        required this.releasedAt,
    });

    factory DataVersion.fromJson(Map<String, dynamic> json) => DataVersion(
        id: json["id"],
        platform: json["platform"],
        versionSemver: json["versionSemver"],
        buildNumber: json["buildNumber"],
        isForced: json["isForced"],
        minSupported: json["minSupported"],
        storeUrl: json["storeUrl"],
        downloadUrl: json["downloadUrl"],
        releaseNotes: json["releaseNotes"],
        isActive: json["isActive"],
        releasedAt: json["releasedAt"],
    );

    DataVersion copyWith({
        String? id,
        String? platform,
        String? versionSemver,
        int? buildNumber,
        bool? isForced,
        String? minSupported,
        String? storeUrl,
        dynamic downloadUrl,
        String? releaseNotes,
        bool? isActive,
        DateTime? releasedAt,
    }) => 
        DataVersion(
            id: id ?? this.id,
            platform: platform ?? this.platform,
            versionSemver: versionSemver ?? this.versionSemver,
            buildNumber: buildNumber ?? this.buildNumber,
            isForced: isForced ?? this.isForced,
            minSupported: minSupported ?? this.minSupported,
            storeUrl: storeUrl ?? this.storeUrl,
            downloadUrl: downloadUrl ?? this.downloadUrl,
            releaseNotes: releaseNotes ?? this.releaseNotes,
            isActive: isActive ?? this.isActive,
            releasedAt: releasedAt ?? this.releasedAt,
        );
}
