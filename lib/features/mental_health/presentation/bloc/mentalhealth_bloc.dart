import 'package:bloc/bloc.dart';
import 'package:healmeumpapp/core/handling_service_response/response_validation.dart';
import 'package:healmeumpapp/features/mental_health/domain/usecase/mental_health_usecase.dart';
import 'package:healmeumpapp/features/mental_health/presentation/bloc/mentalhealth_event.dart';
import 'package:healmeumpapp/features/mental_health/presentation/bloc/mentalhealth_state.dart';

class MentalhealthBloc extends Bloc<MentalhealthEvent, MentalhealthState> {
  final MentalHealthUsecase mentalHealthUsecase;
  MentalhealthBloc({required this.mentalHealthUsecase})
      : super(const MentalhealthState()) {
    on<GetQuestionnairebyCodeNameEvent>((_getQuestionnairebyCodeName));
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
}
