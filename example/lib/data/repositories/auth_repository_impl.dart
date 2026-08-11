import '../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/okta_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final OktaRemoteDataSource remoteDataSource;
  bool _sessionActive = false;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<bool> initializeOkta(Map<String, dynamic> config) async {
    try {
      return await remoteDataSource.initialize(config);
    } catch (e) {
      throw ConfigFailure(e.toString());
    }
  }

  @override
  Future<bool> login() async {
    try {
      final response = await remoteDataSource.login();
      if (response != null && (response['status'] == true)) {
        _sessionActive = true;
        return true;
      }
      return false;
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<bool> logout() async {
    try {
      final result = await remoteDataSource.logout();
      if (result ?? false) {
        _sessionActive = false;
        return true;
      }
      return false;
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<String> getAccessToken() async {
    try {
      final response = await remoteDataSource.getAccessToken();
      if (response != null && response['status'] == true) {
        return (response['message'] ?? '').toString();
      }
      return '';
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<UserEntity> getUserProfile() async {
    try {
      final profileData = await remoteDataSource.getUserProfile();
      return UserModel.fromJson(profileData);
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<bool> isSessionActive() async {
    return _sessionActive;
  }
}
