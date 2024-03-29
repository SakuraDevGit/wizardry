import 'package:equatable/equatable.dart';

sealed class WizardryCubitState extends Equatable {
  const WizardryCubitState();

  @override
  List<Object?> get props => [];
}

final class WizardryStateInitial extends WizardryCubitState {}

final class WizardryStateLoading extends WizardryCubitState {}

final class WizardryStateLoaded extends WizardryCubitState {
  // final String advice;
  // const WizardryStateLoaded({required this.advice});

  // @override
  // List<Object?> get props => [advice];
}

final class WizardryStateError extends WizardryCubitState {
  final String message;
  const WizardryStateError({required this.message});

  @override
  List<Object?> get props => [message];
}
