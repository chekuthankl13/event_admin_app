abstract class Failure {
  final String error;

  Failure({required this.error});
}

class ServerFailure extends Failure {
  ServerFailure({required super.error});
}

class ValidationFailure extends Failure {
  ValidationFailure({required super.error});
}

class NetworkFailure extends Failure {
  NetworkFailure({required super.error});
}

class CredentialFailure extends Failure {
  CredentialFailure({required super.error});
}

class ExpectionFailure extends Failure {
  ExpectionFailure({required super.error});
}
