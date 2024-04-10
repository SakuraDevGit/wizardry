import 'package:domain/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain/failures/failures.dart';
import 'package:domain/usecases/get_elixers_usecase.dart';
import 'package:wizarding_world/2_application/pages/elixirs/cubit/elixirs_state.dart';

class ElixirsCubit extends Cubit<ElixirsCubitState> {
  final GetElixirsUseCase getElixirsUseCase;

  ElixirsCubit({required this.getElixirsUseCase})
      : super(ElixirsStateInitial());

  void elixirsRequested() async {
    if (state is ElixirsStateLoading) return;
    emit(ElixirsStateLoading());

    final elixirsOrFailure = await getElixirsUseCase.getElixirs();
    if (isClosed) return;
    switch (elixirsOrFailure) {
      case Success(value: final elixirs):
        emit(ElixirsStateLoaded(elixirs: elixirs));
      case Failure(exception: final failure):
        emit(ElixirsStateError(message: failure.message()));
    }
  }
}
