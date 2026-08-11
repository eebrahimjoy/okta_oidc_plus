import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'okta_oidc_plus_method_channel.dart';

/// The interface that platform implementations of [OktaOidcPlusPlatform] must implement.
abstract class OktaOidcPlusPlatform extends PlatformInterface {
  /// Constructs a OktaOidcPlusPlatform.
  OktaOidcPlusPlatform() : super(token: _token);

  static final Object _token = Object();

  static OktaOidcPlusPlatform _instance = MethodChannelOktaOidcPlus();

  /// The default instance of [OktaOidcPlusPlatform] to use.
  ///
  /// Defaults to [MethodChannelOktaOidcPlus].
  static OktaOidcPlusPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OktaOidcPlusPlatform] when
  /// they register themselves.
  static set instance(OktaOidcPlusPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Initializes the Okta OIDC client with configuration parameters.
  Future<bool?> initOkta(Map<String, dynamic>? oktaConfig) {
    throw UnimplementedError('initOkta() has not been implemented.');
  }

  /// Initiates web-based OIDC sign-in flow.
  Future<Map<dynamic, dynamic>?> login() {
    throw UnimplementedError('login() has not been implemented.');
  }

  /// Initiates social login flow with specified provider parameters.
  Future<Map<dynamic, dynamic>?> socialLogin(Map<String, String> map) {
    throw UnimplementedError('socialLogin() has not been implemented.');
  }

  /// Fetches current valid access token or refreshes it.
  Future<Map<dynamic, dynamic>?> getAccessToken() {
    throw UnimplementedError('getAccessToken() has not been implemented.');
  }

  /// Logs out the user and revokes session tokens.
  Future<bool?> logout() {
    throw UnimplementedError('logout() has not been implemented.');
  }

  /// Fetches authenticated user profile claims.
  Future<dynamic> getUserProfile() {
    throw UnimplementedError('getUserProfile() has not been implemented.');
  }
}
