import 'package:equatable/equatable.dart';
import 'package:healmeumpapp/features/home/data/model/version_model.dart';

class VersionEntities extends Equatable {
  final bool success;
  final List<DataVersion> dataVersion;
  final String message;

  const VersionEntities({
    required this.success,
    required this.dataVersion,
    required this.message,
  });
  
  @override
  List<Object?> get props => [success, dataVersion, message];
}