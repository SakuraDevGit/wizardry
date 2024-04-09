import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wizarding_world/1_domain/failures/failures.dart';
import 'package:wizarding_world/1_domain/usecases/get_elixers_usecase.dart';
import 'package:wizarding_world/2_application/pages/elixirs/cubit/elixirs_state.dart';

class ElixirsCubit extends Cubit<ElixirsCubitState> {
  final GetElixirsUseCase getElixirsUseCase;

  ElixirsCubit({required this.getElixirsUseCase})
      : super(ElixirsStateInitial());

  void elixirsRequested() async {
    if (state is ElixirsStateLoading) return;
    emit(ElixirsStateLoading());

    final housesOrFailure = await getElixirsUseCase.getElixirs();
    if (isClosed) return;
    housesOrFailure.fold(
        (failure) => emit(ElixirsStateError(message: failure.message())),
        (elixirs) => emit(ElixirsStateLoaded(elixirs: elixirs)));
  }
}
