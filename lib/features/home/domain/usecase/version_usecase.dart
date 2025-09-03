import 'package:dartz/dartz.dart';
import 'package:healmeumpapp/core/handling_service_response/failure_response.dart';
import 'package:healmeumpapp/features/home/domain/entities/version_entities.dart';
import 'package:healmeumpapp/features/home/domain/repository/home_repository.dart';

class VersionUsecase {
  final HomeRepository homeRepository;

  VersionUsecase(this.homeRepository);

  Future<Either<FailureResponse, VersionEntities>> call() async {
    return await homeRepository.getVersion();
  }
}