abstract class Failure implements Exception {}

extension FailureMessageExtension on Failure {
  String message() {
    switch (runtimeType) {
      case const (ServerFailure):
        return "Oops, API Error. Please try again.";
      case const (ChacheFailure):
        return "Oops, Cache Error. Please try again.";
      default:
        return "Oops, something went wrong.";
    }
  }
}

class ServerFailure extends Failure {}

class ChacheFailure extends Failure {}

class GeneralFailure extends Failure {}
