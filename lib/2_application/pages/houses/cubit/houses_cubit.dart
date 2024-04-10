import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain/failures/failures.dart';
import 'package:domain/usecases/get_houses_usecase.dart';
import 'package:wizarding_world/2_application/pages/houses/cubit/houses_state.dart';

class HousesCubit extends Cubit<HousesCubitState> {
  final GetHousesUseCase getHousesUseCase;

  HousesCubit({required this.getHousesUseCase}) : super(HousesStateInitial());

  void housesRequested() async {
    if (state is HousesStateLoading) return;
    emit(HousesStateLoading());

    final housesOrFailure = await getHousesUseCase.getHouses();
    if (isClosed) return;
    housesOrFailure.fold(
        (failure) => emit(HousesStateError(message: failure.message())),
        (houses) => emit(HousesStateLoaded(houses: houses)));
  }
}
