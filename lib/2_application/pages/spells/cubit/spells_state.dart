import 'package:equatable/equatable.dart';
import 'package:wizarding_world/1_domain/entities/spell_entities/spell_entity.dart';

sealed class SpellsCubitState extends Equatable {
  const SpellsCubitState();

  @override
  List<Object?> get props => [];
}

final class SpellsStateInitial extends SpellsCubitState {}

final class SpellsStateLoading extends SpellsCubitState {}

final class SpellsStateLoaded extends SpellsCubitState {
  final List<SpellEntity> spells;
  const SpellsStateLoaded({required this.spells});

  @override
  List<Object?> get props => [spells];
}

final class SpellsStateError extends SpellsCubitState {
  final String message;
  const SpellsStateError({required this.message});

  @override
  List<Object?> get props => [message];
}
