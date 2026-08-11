import '../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class InitializeOktaUseCase implements UseCase<bool, Map<String, dynamic>> {
  final AuthRepository repository;

  InitializeOktaUseCase(this.repository);

  @override
  Future<bool> call(Map<String, dynamic> params) {
    return repository.initializeOkta(params);
  }
}
