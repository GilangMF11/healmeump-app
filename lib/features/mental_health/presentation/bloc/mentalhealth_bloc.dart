import 'package:bloc/bloc.dart';
import 'package:healmeumpapp/core/handling_service_response/response_validation.dart';
import 'package:healmeumpapp/features/mental_health/domain/usecase/create_answers_usecase.dart';
import 'package:healmeumpapp/features/mental_health/domain/usecase/mental_health_usecase.dart';
import 'package:healmeumpapp/features/mental_health/domain/usecase/save_answers_usecase.dart';
import 'package:healmeumpapp/features/mental_health/presentation/bloc/mentalhealth_event.dart';
import 'package:healmeumpapp/features/mental_health/presentation/bloc/mentalhealth_state.dart';

class MentalhealthBloc extends Bloc<MentalhealthEvent, MentalhealthState> {
  final MentalHealthUsecase mentalHealthUsecase;
  final CreateAnswersUsecase createAnswersUsecase;
  final SaveAnswersUsecase saveAnswersUsecase;
  MentalhealthBloc({
    required this.mentalHealthUsecase,
    required this.createAnswersUsecase,
    required this.saveAnswersUsecase,
  }) : super(const MentalhealthState()) {
    on<GetQuestionnairebyCodeNameEvent>((_getQuestionnairebyCodeName));
    on<CreateAnswersEvent>((_createAnswers));
    on<SaveAnswersEvent>((_saveAnswers));
  }

  Future<void> _getQuestionnairebyCodeName(
      GetQuestionnairebyCodeNameEvent event,
      Emitter<MentalhealthState> emit) async {
    emit(state.copyWith(loadingQuestionnaire: ResponseValidation.LOADING));

    await Future.delayed(const Duration(seconds: 1));

    final result = await mentalHealthUsecase.call(event.codeName);
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

    final result = await createAnswersUsecase.call(
        event.questionnaireCode,
        event.userId,
        event.namaPegawai,
        event.nip,
        event.jenisPegawai,
        event.prodi,
        event.email,
        event.hp);
    result.fold((failure) {
      emit(state.copyWith(
          loadingCreateAnswers: ResponseValidation.LOADED,
          statusCreateAnswers: ResponseValidation.FAIL,
          messageCreateAnswers: failure.message));
    }, (success) {
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
        await saveAnswersUsecase.call(event.answers, event.responseId);
    result.fold((failure) {
      emit(state.copyWith(
          loadingSaveAnswers: ResponseValidation.LOADED,
          statusSaveAnswers: ResponseValidation.FAIL,
          messageSaveAnswers: failure.message));
    }, (success) {
      emit(state.copyWith(
          loadingSaveAnswers: ResponseValidation.LOADED,
          statusSaveAnswers: ResponseValidation.SUCCESS,
          messageSaveAnswers: success.message,
          dataSaveAnswers: success));
    });
  }
}
