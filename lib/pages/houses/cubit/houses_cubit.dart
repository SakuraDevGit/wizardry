import 'package:domain/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain/failures/failures.dart';
import 'package:domain/usecases/get_houses_usecase.dart';
import 'package:wizarding_world/pages/houses/cubit/houses_state.dart';

class HousesCubit extends Cubit<HousesCubitState> {
  final GetHousesUseCase getHousesUseCase;

  HousesCubit({required this.getHousesUseCase}) : super(HousesStateInitial());

  void housesRequested() async {
    if (state is HousesStateLoading) return;
    emit(HousesStateLoading());

    final housesOrFailure = await getHousesUseCase.getHouses();
    if (isClosed) return;
    switch (housesOrFailure) {
      case Success(value: final houses):
        emit(HousesStateLoaded(houses: houses));
      case Failure(exception: final failure):
        emit(HousesStateError(message: failure.message()));
      default:
    }
  }
}
