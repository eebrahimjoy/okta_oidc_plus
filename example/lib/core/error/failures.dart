abstract class Failure {
  final String message;
  const Failure(this.message);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

class ConfigFailure extends Failure {
  const ConfigFailure(super.message);
}

class PlatformFailure extends Failure {
  const PlatformFailure(super.message);
}
