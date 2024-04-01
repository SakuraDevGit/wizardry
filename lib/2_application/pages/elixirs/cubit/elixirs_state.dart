import 'package:equatable/equatable.dart';
import 'package:wizarding_world/1_domain/entities/elixir_entities/elixir_entity.dart';

sealed class ElixirsCubitState extends Equatable {
  const ElixirsCubitState();

  @override
  List<Object?> get props => [];
}

final class ElixirsStateInitial extends ElixirsCubitState {}

final class ElixirsStateLoading extends ElixirsCubitState {}

final class ElixirsStateLoaded extends ElixirsCubitState {
  final List<ElixirEntity> elixirs;
  const ElixirsStateLoaded({required this.elixirs});

  @override
  List<Object?> get props => [elixirs];
}

final class ElixirsStateError extends ElixirsCubitState {
  final String message;
  const ElixirsStateError({required this.message});

  @override
  List<Object?> get props => [message];
}
