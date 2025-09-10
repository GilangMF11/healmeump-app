import 'package:bloc/bloc.dart';
import 'package:healmeumpapp/core/handling_service_response/response_validation.dart';
import 'package:healmeumpapp/features/home/domain/usecase/version_usecase.dart';
import 'package:healmeumpapp/features/home/presentation/bloc/home_event.dart';
import 'package:healmeumpapp/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final VersionUsecase versionUsecase;
  HomeBloc({required this.versionUsecase}) : super(const HomeState()) {
    on<GetVersionEvent>((_getVersion));
  }

  Future<void> _getVersion(
    GetVersionEvent event,
    Emitter<HomeState> emit
  ) async {
    emit(state.copyWith(loadingVersion: ResponseValidation.LOADING));

    await Future.delayed(const Duration(seconds: 1));

    final result = await versionUsecase.call();
    result.fold((failure) {

      emit(state.copyWith(
        loadingVersion: ResponseValidation.LOADED,
        statusVersion: ResponseValidation.FAIL,
        messageVersion: failure.message
      ));
    }, (success) {
      emit(state.copyWith(
        loadingVersion: ResponseValidation.LOADED,
        statusVersion: ResponseValidation.SUCCESS,
        messageVersion: success.message,
        dataVersion: success
        ));
    });
  }

}
