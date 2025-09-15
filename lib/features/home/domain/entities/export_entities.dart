import 'package:equatable/equatable.dart';
import 'package:healmeumpapp/features/home/data/model/export_model.dart';

class ExportEntities extends Equatable {
  final bool success;
  final DataExport dataExport;
  final String message;

  const ExportEntities({
    required this.success,
    required this.dataExport,
    required this.message,
  });

  @override
  List<Object?> get props => [success, dataExport, message];
}

