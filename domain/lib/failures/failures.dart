abstract class WizardingFailure implements Exception {}

extension FailureMessageExtension on WizardingFailure {
  String message() {
    switch (runtimeType) {
      case const (ServerFailure):
        return 'Oops, API Error. Please try again.';
      case const (ChacheFailure):
        return 'Oops, Cache Error. Please try again.';
      default:
        return 'Oops, something went wrong.';
    }
  }
}

class ServerFailure extends WizardingFailure {}

class ChacheFailure extends WizardingFailure {}

class GeneralFailure extends WizardingFailure {}
