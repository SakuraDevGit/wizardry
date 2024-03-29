import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wizarding_world/2_application/pages/main/cubit/main_state.dart';

class MainCubit extends Cubit<WizardryCubitState> {
  // final AdviceUseCases adviceUseCases;

  // MainCubit({required this.adviceUseCases}) : super(AdvicerInitial());
  MainCubit() : super(WizardryStateInitial());

  void adviceRequested() async {
    emit(WizardryStateLoading());

    // final failureOrAdvice = await adviceUseCases.getAdvice();
    // failureOrAdvice.fold(
    //     (failure) =>
    //         emit(AdvicerStateError(message: failure.mapFailureToMessage())),
    //     (advice) => emit(AdvicerStateLoaded(advice: advice.advice)));
  }
}
