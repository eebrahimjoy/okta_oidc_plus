import '../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase implements UseCase<bool, NoParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<bool> call(NoParams params) {
    return repository.login();
  }
}
