import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<bool> initializeOkta(Map<String, dynamic> config);
  Future<bool> login();
  Future<bool> logout();
  Future<String> getAccessToken();
  Future<UserEntity> getUserProfile();
  Future<bool> isSessionActive();
}
