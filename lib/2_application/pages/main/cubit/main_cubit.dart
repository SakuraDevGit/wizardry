import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wizarding_world/2_application/pages/main/cubit/main_state.dart';

class MainCubit extends Cubit<WizardryCubitState> {
  MainCubit() : super(WizardryStateInitial());

  void dataRequested() async {
    emit(WizardryStateLoading());
  }
}
