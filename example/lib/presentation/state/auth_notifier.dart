import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_constants.dart';
import '../../core/usecase/usecase.dart';
import '../../domain/entities/auth_status.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_access_token_usecase.dart';
import '../../domain/usecases/get_user_profile_usecase.dart';
import '../../domain/usecases/initialize_okta_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

class AuthNotifier extends ChangeNotifier {
  final InitializeOktaUseCase _initializeOktaUseCase;
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetUserProfileUseCase _getUserProfileUseCase;
  final GetAccessTokenUseCase _getAccessTokenUseCase;

  AuthStatus _status = AuthStatus.initial;
  UserEntity _user = UserEntity.empty();
  String _accessToken = '';
  String? _errorMessage;

  AuthStatus get status => _status;
  UserEntity get user => _user;
  String get accessToken => _accessToken;
  String? get errorMessage => _errorMessage;

  AuthNotifier({
    required InitializeOktaUseCase initializeOktaUseCase,
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
    required GetUserProfileUseCase getUserProfileUseCase,
    required GetAccessTokenUseCase getAccessTokenUseCase,
  })  : _initializeOktaUseCase = initializeOktaUseCase,
        _loginUseCase = loginUseCase,
        _logoutUseCase = logoutUseCase,
        _getUserProfileUseCase = getUserProfileUseCase,
        _getAccessTokenUseCase = getAccessTokenUseCase;

  Future<void> initialize() async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      final configString =
          await rootBundle.loadString(AppConstants.oktaConfigAssetPath);
      final Map<String, dynamic> config = jsonDecode(configString);

      final initialized = await _initializeOktaUseCase(config);
      if (initialized) {
        _status = AuthStatus.unauthenticated;
      } else {
        _status = AuthStatus.error;
        _errorMessage = 'Failed to initialize Okta client';
      }
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<bool> login() async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _loginUseCase(NoParams());
      if (success) {
        await fetchUserProfile();
        _status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      } else {
        _status = AuthStatus.unauthenticated;
        _errorMessage = 'Sign in was cancelled or failed.';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> fetchUserProfile() async {
    try {
      _user = await _getUserProfileUseCase(NoParams());
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  Future<String> fetchAccessToken() async {
    try {
      _accessToken = await _getAccessTokenUseCase(NoParams());
      notifyListeners();
      return _accessToken;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return '';
    }
  }

  Future<bool> logout() async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      final success = await _logoutUseCase(NoParams());
      if (success) {
        _user = UserEntity.empty();
        _accessToken = '';
        _status = AuthStatus.unauthenticated;
        notifyListeners();
        return true;
      }
      _status = AuthStatus.authenticated;
      notifyListeners();
      return false;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
