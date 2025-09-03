import 'package:equatable/equatable.dart';
import 'package:healmeumpapp/features/home/domain/entities/version_entities.dart';

class HomeState extends Equatable {
  final bool? loadingVersion;
  final String? statusVersion;
  final String? messageVersion;
  final VersionEntities? dataVersion;

  const HomeState({
    this.loadingVersion = false,
    this.statusVersion,
    this.messageVersion,
    this.dataVersion,
  });

  HomeState copyWith({
    bool? loadingVersion,
    String? statusVersion,
    String? messageVersion,
    VersionEntities? dataVersion,
  }) =>
      HomeState(
        loadingVersion: loadingVersion ?? this.loadingVersion,
        statusVersion: statusVersion ?? this.statusVersion,
        messageVersion: messageVersion ?? this.messageVersion,
        dataVersion: dataVersion ?? this.dataVersion,
      );

  @override
  List<Object?> get props =>
      [loadingVersion, statusVersion, messageVersion, dataVersion];
}
