import '../../core/usecase/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetUserProfileUseCase implements UseCase<UserEntity, NoParams> {
  final AuthRepository repository;

  GetUserProfileUseCase(this.repository);

  @override
  Future<UserEntity> call(NoParams params) {
    return repository.getUserProfile();
  }
}
