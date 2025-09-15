import 'package:bloc/bloc.dart';
import 'package:healmeumpapp/core/handling_service_response/response_validation.dart';
import 'package:healmeumpapp/features/home/domain/usecase/version_usecase.dart';
import 'package:healmeumpapp/features/home/presentation/bloc/home_event.dart';
import 'package:healmeumpapp/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final VersionUsecase versionUsecase;
  HomeBloc({required this.versionUsecase}) : super(const HomeState()) {
    on<GetVersionEvent>((_getVersion));
    on<GetScoreHistoryEvent>((_getScoreHistory));
    on<GetScoreAdminHistoryEvent>((_getScoreAdminHistory));
    on<GetExportAdminHistoryEvent>((_getExportAdminHistory));
  }

  Future<void> _getVersion(
    GetVersionEvent event,
    Emitter<HomeState> emit
  ) async {
    emit(state.copyWith(loadingVersion: ResponseValidation.LOADING));

    await Future.delayed(const Duration(seconds: 1));

    final result = await versionUsecase.call();
    result.fold((failure) {
      print("gagal");
      emit(state.copyWith(
        loadingVersion: ResponseValidation.LOADED,
        statusVersion: ResponseValidation.FAIL,
        messageVersion: failure.message
      ));
    }, (success) {
      print("berhasil");
      //print("Version Data: ${success.success.toString()}");
      emit(state.copyWith(
        loadingVersion: ResponseValidation.LOADED,
        statusVersion: ResponseValidation.SUCCESS,
        messageVersion: success.message,
        dataVersion: success
        ));
    });
  }

  Future<void> _getScoreHistory(
    GetScoreHistoryEvent event,
    Emitter<HomeState> emit
  ) async {
    emit(state.copyWith(loadingScoreHistory: ResponseValidation.LOADING));

    final result = await versionUsecase.getScoreHistory(event.userId, event.questionnaireCode);
    result.fold((failure) {
      emit(state.copyWith(loadingScoreHistory: ResponseValidation.LOADED, statusScoreHistory: ResponseValidation.FAIL, messageScoreHistory: failure.message));
    }, (success) {
      emit(state.copyWith(loadingScoreHistory: ResponseValidation.LOADED, statusScoreHistory: ResponseValidation.SUCCESS, messageScoreHistory: success.message, dataScoreHistory: success));
    });
  }

  Future<void> _getScoreAdminHistory(
    GetScoreAdminHistoryEvent event,
    Emitter<HomeState> emit
  ) async {
    emit(state.copyWith(loadingScoreAdminHistory: ResponseValidation.LOADING));

    final result = await versionUsecase.getScoreAdminHistory(event.limit);
    result.fold((failure) {
      emit(state.copyWith(loadingScoreAdminHistory: ResponseValidation.LOADED, statusScoreAdminHistory: ResponseValidation.FAIL, messageScoreAdminHistory: failure.message));
    }, (success) {
      emit(state.copyWith(loadingScoreAdminHistory: ResponseValidation.LOADED, statusScoreAdminHistory: ResponseValidation.SUCCESS, messageScoreAdminHistory: success.message, dataScoreAdminHistory: success));
    });
  }

  Future<void> _getExportAdminHistory(
    GetExportAdminHistoryEvent event,
    Emitter<HomeState> emit
  ) async {
    emit(state.copyWith(loadingExportAdminHistory: ResponseValidation.LOADING));

    final result = await versionUsecase.getExportAdminHistory(event.includeEncryptedData, event.format, event.questionnaireCode);
    result.fold((failure) {
      emit(state.copyWith(loadingExportAdminHistory: ResponseValidation.LOADED, statusExportAdminHistory: ResponseValidation.FAIL, messageExportAdminHistory: failure.message));
    }, (success) {
      emit(state.copyWith(loadingExportAdminHistory: ResponseValidation.LOADED, statusExportAdminHistory: ResponseValidation.SUCCESS, messageExportAdminHistory: success.message, dataExportAdminHistory: success));
    });
  }

}
