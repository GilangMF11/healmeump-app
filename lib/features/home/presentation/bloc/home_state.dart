import 'package:equatable/equatable.dart';
import 'package:healmeumpapp/features/home/domain/entities/export_entities.dart';
import 'package:healmeumpapp/features/home/domain/entities/score_admin_entities.dart';
import 'package:healmeumpapp/features/home/domain/entities/score_entities.dart';
import 'package:healmeumpapp/features/home/domain/entities/version_entities.dart';

class HomeState extends Equatable {
  // Loading
  final bool? loadingVersion;
  final bool? loadingScoreHistory;
  final bool? loadingScoreAdminHistory;
  final bool? loadingExportAdminHistory;
  // Status
  final String? statusVersion;
  final String? statusScoreHistory;
  final String? statusScoreAdminHistory;
  final String? statusExportAdminHistory;
  // Message
  final String? messageVersion;
  final String? messageScoreHistory;
  final String? messageScoreAdminHistory;
  final String? messageExportAdminHistory;
  // Data
  final VersionEntities? dataVersion;
  final ScoreEntities? dataScoreHistory;
  final ScoreAdminEntities? dataScoreAdminHistory;
  final ExportEntities? dataExportAdminHistory;

  const HomeState({
    this.loadingVersion = false,
    this.loadingScoreHistory = false,
    this.loadingScoreAdminHistory = false,
    this.loadingExportAdminHistory = false,
    this.statusVersion,
    this.statusScoreHistory,
    this.statusScoreAdminHistory,
    this.statusExportAdminHistory,
    this.messageVersion,
    this.messageScoreHistory,
    this.messageScoreAdminHistory,
    this.messageExportAdminHistory,
    this.dataVersion,
    this.dataScoreHistory,
    this.dataScoreAdminHistory,
    this.dataExportAdminHistory,
  });

  HomeState copyWith({
    bool? loadingVersion,
    bool? loadingScoreHistory,
    bool? loadingScoreAdminHistory,
    bool? loadingExportAdminHistory,
    String? statusVersion,
    String? statusScoreHistory,
    String? statusScoreAdminHistory,
    String? statusExportAdminHistory,
    String? messageVersion,
    String? messageScoreHistory,
    String? messageScoreAdminHistory,
    String? messageExportAdminHistory,
    VersionEntities? dataVersion,
    ScoreEntities? dataScoreHistory,
    ScoreAdminEntities? dataScoreAdminHistory,
    ExportEntities? dataExportAdminHistory,
  }) =>
      HomeState(
        loadingVersion: loadingVersion ?? this.loadingVersion,
        loadingScoreHistory: loadingScoreHistory ?? this.loadingScoreHistory,
        loadingScoreAdminHistory:
            loadingScoreAdminHistory ?? this.loadingScoreAdminHistory,
        loadingExportAdminHistory:
            loadingExportAdminHistory ?? this.loadingExportAdminHistory,
        statusVersion: statusVersion ?? this.statusVersion,
        statusScoreHistory: statusScoreHistory ?? this.statusScoreHistory,
        statusScoreAdminHistory:
            statusScoreAdminHistory ?? this.statusScoreAdminHistory,
        statusExportAdminHistory:
            statusExportAdminHistory ?? this.statusExportAdminHistory,
        messageVersion: messageVersion ?? this.messageVersion,
        messageScoreHistory: messageScoreHistory ?? this.messageScoreHistory,
        messageScoreAdminHistory:
            messageScoreAdminHistory ?? this.messageScoreAdminHistory,
        messageExportAdminHistory:
            messageExportAdminHistory ?? this.messageExportAdminHistory,
        dataVersion: dataVersion ?? this.dataVersion,
        dataScoreHistory: dataScoreHistory ?? this.dataScoreHistory,
        dataScoreAdminHistory: dataScoreAdminHistory ?? this.dataScoreAdminHistory,
        dataExportAdminHistory: dataExportAdminHistory ?? this.dataExportAdminHistory,
      );

  @override
  List<Object?> get props => [
        loadingVersion,
        statusVersion,
        messageVersion,
        dataVersion,
        loadingScoreHistory,
        statusScoreHistory,
        messageScoreHistory,
        loadingScoreAdminHistory,
        statusScoreAdminHistory,
        messageScoreAdminHistory,
        loadingExportAdminHistory,
        statusExportAdminHistory,
        messageExportAdminHistory,
        dataScoreHistory,
        dataScoreAdminHistory,
        dataExportAdminHistory,
      ];
}
