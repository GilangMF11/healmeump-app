import 'package:dartz/dartz.dart';
import 'package:healmeumpapp/core/handling_service_response/failure_response.dart';
import 'package:healmeumpapp/features/auth/domain/entities/login_entities.dart';
import 'package:healmeumpapp/features/auth/domain/repository/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecase(this.authRepository);

  Future<Either<FailureResponse, LoginEntities>> call(
    Map<String, dynamic> dataBody
  ) async {
    final result = await authRepository.postLogin(dataBody);
    print("result pada usecase: $result");
    return result;
  }
}