import 'package:bloc/bloc.dart';
import 'package:healmeumpapp/core/handling_service_response/response_validation.dart';
import 'package:healmeumpapp/features/auth/domain/usecase/login_usecase.dart';
import 'package:healmeumpapp/features/auth/presentation/bloc/auth_event.dart';
import 'package:healmeumpapp/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  AuthBloc({
    required this.loginUsecase,
  }) : super(const AuthState()) {
    on<AuthLoginEvent>((_authLogin));
  }

  Future<void> _authLogin(
    AuthLoginEvent event, 
    Emitter<AuthState> emit
    ) async {
    Map<String, dynamic> dataBody = {
      "user_name": event.username,
      "user_password": event.password,
      "login_sebagai": event.role,
    };

    emit(state.copyWith(
      loadingLogin: ResponseValidation.LOADING
    ));

    await Future.delayed(const Duration(seconds: 1));

    final result = await loginUsecase.call(dataBody);

    result.fold( (failure) {
      emit(state.copyWith(
        loadingLogin: ResponseValidation.LOADED,
        statusLogin: ResponseValidation.FAIL,
        messageLogin: failure.message
      ));
    }, (success) {
      if (success.metaData.code == "200") {
        emit(state.copyWith(
          loadingLogin: ResponseValidation.LOADED,
          statusLogin: ResponseValidation.SUCCESS,
          messageLogin: success.metaData.message,
          dataLogin: success
        ));
      } else {
        emit(state.copyWith(
          loadingLogin: ResponseValidation.LOADED,
          statusLogin: ResponseValidation.FAIL,
          messageLogin: success.metaData.message
        ));
      }
    }
    );
  }
}
