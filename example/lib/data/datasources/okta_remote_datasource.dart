import 'package:okta_oidc_plus/okta_oidc_plus.dart';

abstract class OktaRemoteDataSource {
  Future<bool> initialize(Map<String, dynamic> config);
  Future<Map<dynamic, dynamic>?> login();
  Future<bool?> logout();
  Future<Map<dynamic, dynamic>?> getAccessToken();
  Future<dynamic> getUserProfile();
}

class OktaRemoteDataSourceImpl implements OktaRemoteDataSource {
  final OktaOidcPlus _oktaOidcPlus;

  OktaRemoteDataSourceImpl({OktaOidcPlus? oktaOidcPlus})
      : _oktaOidcPlus = oktaOidcPlus ?? OktaOidcPlus();

  @override
  Future<bool> initialize(Map<String, dynamic> config) async {
    final result = await _oktaOidcPlus.initOkta(config);
    return result ?? false;
  }

  @override
  Future<Map<dynamic, dynamic>?> login() {
    return _oktaOidcPlus.login();
  }

  @override
  Future<bool?> logout() {
    return _oktaOidcPlus.logout();
  }

  @override
  Future<Map<dynamic, dynamic>?> getAccessToken() {
    return _oktaOidcPlus.getAccessToken();
  }

  @override
  Future<dynamic> getUserProfile() {
    return _oktaOidcPlus.getUserProfile();
  }
}
