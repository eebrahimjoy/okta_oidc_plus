import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_constants.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/okta_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final OktaRemoteDataSource remoteDataSource;

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
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(AppConstants.isLoggedInKey, true);
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
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(AppConstants.isLoggedInKey);
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
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.isLoggedInKey) ?? false;
  }
}
