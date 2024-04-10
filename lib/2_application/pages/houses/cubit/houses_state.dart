import 'package:equatable/equatable.dart';
import 'package:domain/entities/house_entities/house_entity.dart';

sealed class HousesCubitState extends Equatable {
  const HousesCubitState();

  @override
  List<Object?> get props => [];
}

final class HousesStateInitial extends HousesCubitState {}

final class HousesStateLoading extends HousesCubitState {}

final class HousesStateLoaded extends HousesCubitState {
  final List<HouseEntity> houses;
  const HousesStateLoaded({required this.houses});

  @override
  List<Object?> get props => [houses];
}

final class HousesStateError extends HousesCubitState {
  final String message;
  const HousesStateError({required this.message});

  @override
  List<Object?> get props => [message];
}
