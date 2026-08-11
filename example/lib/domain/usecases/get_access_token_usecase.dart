import '../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class GetAccessTokenUseCase implements UseCase<String, NoParams> {
  final AuthRepository repository;

  GetAccessTokenUseCase(this.repository);

  @override
  Future<String> call(NoParams params) {
    return repository.getAccessToken();
  }
}
