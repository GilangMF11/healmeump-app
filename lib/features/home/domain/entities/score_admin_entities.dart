import 'package:equatable/equatable.dart';
import 'package:healmeumpapp/features/home/data/model/score_model.dart';

class ScoreAdminEntities extends Equatable {
  final bool success;
  final DataScore dataScore;
  final String message;

  const ScoreAdminEntities({
    required this.success,
    required this.dataScore,
    required this.message,
  });

  @override
  List<Object?> get props => [success, dataScore, message];
}


