import 'package:bloc/bloc.dart';
import 'package:healmeumpapp/core/handling_service_response/response_validation.dart';
import 'package:healmeumpapp/features/mental_health/domain/usecase/mental_health_usecase.dart';
import 'package:healmeumpapp/features/mental_health/presentation/bloc/mentalhealth_event.dart';
import 'package:healmeumpapp/features/mental_health/presentation/bloc/mentalhealth_state.dart';

class MentalhealthBloc extends Bloc<MentalhealthEvent, MentalhealthState> {
  final MentalHealthUsecase mentalHealthUsecase;

  MentalhealthBloc({
    required this.mentalHealthUsecase,
  }) : super(const MentalhealthState()) {
    on<GetQuestionnairebyCodeNameEvent>((_getQuestionnairebyCodeName));
    on<CreateAnswersEvent>((_createAnswers));
    on<SaveAnswersEvent>((_saveAnswers));
    on<SubmitAnswersEvent>((_submitAnswers));
    on<ResetMentalHealthStateEvent>((_resetState));
    on<ResetSubmitStateEvent>((_resetSubmitState));
  }

  Future<void> _getQuestionnairebyCodeName(
      GetQuestionnairebyCodeNameEvent event,
      Emitter<MentalhealthState> emit) async {
    emit(state.copyWith(loadingQuestionnaire: ResponseValidation.LOADING));

    await Future.delayed(const Duration(seconds: 1));

    final result = await mentalHealthUsecase.getQuestionnaire(event.codeName);
    result.fold((failure) {
      print("gagal dibloc mental health");
      emit(state.copyWith(
          loadingQuestionnaire: ResponseValidation.LOADED,
          statusQuestionnaire: ResponseValidation.FAIL,
          messageQuestionnaire: failure.message));
    }, (success) {
      print("berhasil dibloc mental health");
      emit(state.copyWith(
          loadingQuestionnaire: ResponseValidation.LOADED,
          statusQuestionnaire: ResponseValidation.SUCCESS,
          messageQuestionnaire: success.message,
          dataQuestionnaire: success));
    });
  }

  Future<void> _createAnswers(
      CreateAnswersEvent event, Emitter<MentalhealthState> emit) async {
    emit(state.copyWith(loadingCreateAnswers: ResponseValidation.LOADING));

    final result = await mentalHealthUsecase.createAnswers(
        event.questionnaireCode,
        event.userId,
        event.namaPegawai,
        event.nip,
        event.jenisPegawai,
        event.prodi,
        event.email,
        event.hp);
    result.fold((failure) {
      print("gagal create answers: ${failure.message}");
      emit(state.copyWith(
          loadingCreateAnswers: ResponseValidation.LOADED,
          statusCreateAnswers: ResponseValidation.FAIL,
          messageCreateAnswers: failure.message));
    }, (success) {
      print("berhasil create answers: ${success.data.responseId}");
      emit(state.copyWith(
          loadingCreateAnswers: ResponseValidation.LOADED,
          statusCreateAnswers: ResponseValidation.SUCCESS,
          messageCreateAnswers: success.message,
          dataCreateAnswers: success));
    });
  }

  Future<void> _saveAnswers(
      SaveAnswersEvent event, Emitter<MentalhealthState> emit) async {
    emit(state.copyWith(loadingSaveAnswers: ResponseValidation.LOADING));

    final result =
        await mentalHealthUsecase.saveAnswers(event.answers, event.responseId);
    result.fold((failure) {
      print("gagal save answers: ${failure.message}");
      emit(state.copyWith(
          loadingSaveAnswers: ResponseValidation.LOADED,
          statusSaveAnswers: ResponseValidation.FAIL,
          messageSaveAnswers: failure.message));
    }, (success) {
      print("berhasil save answers: ${success.message}");
      emit(state.copyWith(
          loadingSaveAnswers: ResponseValidation.LOADED,
          statusSaveAnswers: ResponseValidation.SUCCESS,
          messageSaveAnswers: success.message,
          dataSaveAnswers: success));
    });
  }

  Future<void> _submitAnswers(
      SubmitAnswersEvent event, Emitter<MentalhealthState> emit) async {
    emit(state.copyWith(loadingSubmitAnswers: ResponseValidation.LOADING));

    final result = await mentalHealthUsecase.submitAnswers(event.responseId);
    result.fold((failure) {
      print("gagal submit answers: ${failure.message}");
      emit(state.copyWith(
          loadingSubmitAnswers: ResponseValidation.LOADED,
          statusSubmitAnswers: ResponseValidation.FAIL,
          messageSubmitAnswers: failure.message));
    }, (success) {
      print("berhasil submit answers: ${success.message}");
      emit(state.copyWith(
          loadingSubmitAnswers: ResponseValidation.LOADED,
          statusSubmitAnswers: ResponseValidation.SUCCESS,
          messageSubmitAnswers: success.message,
          dataSubmitAnswers: success));
    });
  }

  Future<void> _resetState(
      ResetMentalHealthStateEvent event, Emitter<MentalhealthState> emit) async {
    print("=== RESETTING MENTAL HEALTH STATE ===");
    emit(const MentalhealthState());
  }

  Future<void> _resetSubmitState(
      ResetSubmitStateEvent event, Emitter<MentalhealthState> emit) async {
    print("=== RESETTING SUBMIT STATE ONLY ===");
    emit(state.copyWith(
      loadingSubmitAnswers: false,
      statusSubmitAnswers: null,
      messageSubmitAnswers: null,
      dataSubmitAnswers: null,
    ));
  }
}
