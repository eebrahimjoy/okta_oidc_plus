import 'okta_oidc_plus_platform_interface.dart';

/// Primary plugin class for managing Okta OIDC operations.
///
/// Developed and maintained by Eebrahim Joy (https://eebrahimjoy.com).
class OktaOidcPlus {
  /// Initializes the Okta OIDC SDK with configuration details.
  ///
  /// Required keys in [oktaConfig]:
  /// - `client_id`
  /// - `redirect_uri`
  /// - `end_session_redirect_uri`
  /// - `discovery_uri`
  Future<bool?> initOkta(Map<String, dynamic>? oktaConfig) {
    if (oktaConfig != null) {
      if (oktaConfig['client_id'] == null ||
          (oktaConfig['client_id'] as String).isEmpty) {
        throw ArgumentError('Please provide a valid Okta client_id');
      } else if (oktaConfig['redirect_uri'] == null ||
          (oktaConfig['redirect_uri'] as String).isEmpty) {
        throw ArgumentError('Please provide a valid Okta redirect_uri');
      } else if (oktaConfig['end_session_redirect_uri'] == null ||
          (oktaConfig['end_session_redirect_uri'] as String).isEmpty) {
        throw ArgumentError(
          'Please provide a valid Okta end_session_redirect_uri',
        );
      } else if (oktaConfig['discovery_uri'] == null ||
          (oktaConfig['discovery_uri'] as String).isEmpty) {
        throw ArgumentError('Please provide a valid Okta discovery_uri');
      }
      return OktaOidcPlusPlatform.instance.initOkta(oktaConfig);
    } else {
      throw ArgumentError('Please provide valid Okta configuration');
    }
  }

  /// Initiates sign-in flow via web browser redirect.
  Future<Map<dynamic, dynamic>?> login() {
    return OktaOidcPlusPlatform.instance.login();
  }

  /// Initiates social login flow with identity provider settings.
  Future<Map<dynamic, dynamic>?> socialLogin(Map<String, String> map) {
    return OktaOidcPlusPlatform.instance.socialLogin(map);
  }

  /// Obtains active access token or triggers token refresh.
  Future<Map<dynamic, dynamic>?> getAccessToken() {
    return OktaOidcPlusPlatform.instance.getAccessToken();
  }

  /// Revokes tokens and signs the user out.
  Future<bool?> logout() {
    return OktaOidcPlusPlatform.instance.logout();
  }

  /// Retrieves user profile payload/claims.
  Future<dynamic> getUserProfile() {
    return OktaOidcPlusPlatform.instance.getUserProfile();
  }
}
