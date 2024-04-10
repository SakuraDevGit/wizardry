import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain/failures/failures.dart';
import 'package:domain/usecases/get_spells_usecase.dart';
import 'package:wizarding_world/2_application/pages/spells/cubit/spells_state.dart';

class SpellsCubit extends Cubit<SpellsCubitState> {
  final GetSpellsUseCase getSpellsUseCase;

  SpellsCubit({required this.getSpellsUseCase}) : super(SpellsStateInitial());

  void spellsRequested() async {
    if (state is SpellsStateLoading) return;
    emit(SpellsStateLoading());

    final spellsOrFailure = await getSpellsUseCase.getSpells();
    if (isClosed) return;
    spellsOrFailure.fold(
        (failure) => emit(SpellsStateError(message: failure.message())),
        (spells) => emit(SpellsStateLoaded(spells: spells)));
  }

  void spellRequested(String name, String type, String incantation) async {
    if (state is SpellsStateLoading) return;
    if (name.isEmpty && type.isEmpty && incantation.isEmpty) {
      spellsRequested();
    } else {
      emit(SpellsStateLoading());

      final spellsOrFailure =
          await getSpellsUseCase.getSpellsWith(name, type, incantation);
      if (isClosed) return;
      spellsOrFailure.fold(
          (failure) => emit(SpellsStateError(message: failure.message())),
          (spells) => emit(SpellsStateLoaded(spells: spells)));
    }
  }
}
