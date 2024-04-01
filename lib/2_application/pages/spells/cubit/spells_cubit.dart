import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wizarding_world/1_domain/failures/failures.dart';
import 'package:wizarding_world/1_domain/usecases/get_spells_usecase.dart';
import 'package:wizarding_world/2_application/pages/spells/cubit/spells_state.dart';

class SpellsCubit extends Cubit<SpellsCubitState> {
  final GetSpellsUseCase getSpellsUseCase = GetSpellsUseCase();

  // MainCubit({required this.adviceUseCases}) : super(AdvicerInitial());
  SpellsCubit() : super(SpellsStateInitial());

  void spellsRequested() async {
    emit(SpellsStateLoading());

    final spellsOrFailure = await getSpellsUseCase.getSpells();
    spellsOrFailure.fold(
        (failure) => emit(SpellsStateError(message: failure.message())),
        (spells) => emit(SpellsStateLoaded(spells: spells)));
  }

  void spellRequested(String name, String type, String incantation) async {
    if (name.isEmpty && type.isEmpty && incantation.isEmpty) {
      spellsRequested();
    } else {
      emit(SpellsStateLoading());

      final spellsOrFailure =
          await getSpellsUseCase.getSpellsWith(name, type, incantation);
      spellsOrFailure.fold(
          (failure) => emit(SpellsStateError(message: failure.message())),
          (spells) => emit(SpellsStateLoaded(spells: spells)));
    }
  }
}
