import 'package:domain/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain/failures/failures.dart';
import 'package:domain/usecases/get_spells_usecase.dart';
import 'package:wizarding_world/pages/spells/cubit/spells_state.dart';

class SpellsCubit extends Cubit<SpellsCubitState> {
  final GetSpellsUseCase getSpellsUseCase;

  SpellsCubit({required this.getSpellsUseCase}) : super(SpellsStateInitial());

  void spellsRequested() async {
    if (state is SpellsStateLoading) return;
    emit(SpellsStateLoading());

    final spellsOrFailure = await getSpellsUseCase.getSpells();
    if (isClosed) return;
    switch (spellsOrFailure) {
      case Success(value: final spells):
        emit(SpellsStateLoaded(spells: spells));
      case Failure(exception: final failure):
        emit(SpellsStateError(message: failure.message()));
    }
  }

  void spellsRequestedWith(
      {required String name,
      required String type,
      required String incantation}) async {
    if (state is SpellsStateLoading) return;
    if (name.isEmpty && type.isEmpty && incantation.isEmpty) {
      spellsRequested();
    } else {
      emit(SpellsStateLoading());

      final spellsOrFailure =
          await getSpellsUseCase.getSpellsWith(name, type, incantation);
      if (isClosed) return;
      switch (spellsOrFailure) {
        case Success(value: final spells):
          emit(SpellsStateLoaded(spells: spells));
        case Failure(exception: final failure):
          emit(SpellsStateError(message: failure.message()));
      }
    }
  }
}
