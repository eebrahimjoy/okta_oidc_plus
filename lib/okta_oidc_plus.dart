library;

export 'src/models/okta_oidc_auth_result.dart';
export 'src/models/okta_oidc_config.dart';
export 'src/models/okta_oidc_user_profile.dart';

import 'src/models/okta_oidc_auth_result.dart';
import 'src/models/okta_oidc_config.dart';
import 'src/models/okta_oidc_user_profile.dart';
import 'src/okta_oidc_plus_platform_interface.dart';

/// The main entry point for the [OktaOidcPlus] Flutter plugin package.
///
/// Published and maintained by [Ebrahim Joy](https://eebrahimjoy.com).
class OktaOidcPlus {
  OktaOidcPlus._();

  /// Singleton instance of [OktaOidcPlus].
  static final OktaOidcPlus instance = OktaOidcPlus._();

  /// Default factory constructor returning the singleton instance for legacy compatibility.
  factory OktaOidcPlus() => instance;

  // --- Modern Strongly-Typed API ---

  /// Initializes the Okta plugin with the specified strongly-typed [config].
  Future<bool> initialize({required OktaOidcConfig config}) {
    return OktaOidcPlusPlatform.instance.initialize(config);
  }

  /// Performs interactive Okta user sign-in returning an [OktaOidcAuthResult].
  Future<OktaOidcAuthResult> signIn() async {
    try {
      final res = await OktaOidcPlusPlatform.instance.signIn();
      if (res != null) {
        return OktaOidcAuthResult.fromMap(res);
      }
      return OktaOidcAuthResult.failure('Sign in returned null response.');
    } catch (e) {
      return OktaOidcAuthResult.failure('Sign in error: ${e.toString()}');
    }
  }

  /// Performs social login using identity provider [idp].
  Future<OktaOidcAuthResult> signInWithIdp({
    required String idp,
    String? scope,
  }) async {
    try {
      final res = await OktaOidcPlusPlatform.instance.signInWithIdp(idp, scope);
      if (res != null) {
        return OktaOidcAuthResult.fromMap(res);
      }
      return OktaOidcAuthResult.failure('Social login returned null response.');
    } catch (e) {
      return OktaOidcAuthResult.failure('Social login error: ${e.toString()}');
    }
  }

  /// Fetches current access token returning an [OktaOidcAuthResult].
  Future<OktaOidcAuthResult> fetchAccessToken() async {
    try {
      final res = await OktaOidcPlusPlatform.instance.fetchAccessToken();
      if (res != null) {
        return OktaOidcAuthResult.fromMap(res);
      }
      return OktaOidcAuthResult.failure('Fetch access token returned null.');
    } catch (e) {
      return OktaOidcAuthResult.failure('Fetch access token error: ${e.toString()}');
    }
  }

  /// Fetches Okta UserInfo claims profile returning an [OktaOidcUserProfile].
  Future<OktaOidcUserProfile?> fetchUserProfile() async {
    try {
      final res = await OktaOidcPlusPlatform.instance.fetchUserProfile();
      if (res != null) {
        if (res is String) {
          return OktaOidcUserProfile.fromJsonString(res);
        } else if (res is Map<String, dynamic>) {
          return OktaOidcUserProfile.fromClaims(res);
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Signs out and invalidates the user session.
  Future<bool> signOut() {
    return OktaOidcPlusPlatform.instance.signOut();
  }

  // --- Legacy Backward Compatibility API ---

  /// Legacy helper method for initializing with a [Map] configuration.
  Future<bool?> initOkta(Map<String, dynamic>? configMap) async {
    if (configMap == null) return false;
    final config = OktaOidcConfig.fromJson(configMap);
    return initialize(config: config);
  }

  /// Legacy helper method returning raw token response [Map].
  Future<Map?> login() {
    return OktaOidcPlusPlatform.instance.signIn();
  }

  /// Legacy helper method for social login with map parameters.
  Future<Map?> socialLogin(Map<String, String> map) {
    final idp = map['idp'] ?? '';
    final scope = map['idp-scope'];
    return OktaOidcPlusPlatform.instance.signInWithIdp(idp, scope);
  }

  /// Legacy helper method returning access token [Map].
  Future<Map?> getAccessToken() {
    return OktaOidcPlusPlatform.instance.fetchAccessToken();
  }

  /// Legacy helper method returning user profile response.
  Future<dynamic> getUserProfile() {
    return OktaOidcPlusPlatform.instance.fetchUserProfile();
  }

  /// Legacy helper method clearing user session.
  Future<bool?> logout() {
    return OktaOidcPlusPlatform.instance.signOut();
  }
}
