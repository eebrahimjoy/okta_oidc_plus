import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'okta_oidc_plus_platform_interface.dart';

/// An implementation of [OktaOidcPlusPlatform] that uses method channels.
class MethodChannelOktaOidcPlus extends OktaOidcPlusPlatform {
  /// Tracks whether Okta client has been initialized.
  bool isInitialized = false;

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('okta_oidc_plus');

  @override
  Future<bool?> initOkta(Map<String, dynamic>? oktaConfig) async {
    final initStatus = await methodChannel.invokeMethod<bool>(
      'initialize-okta',
      {'config': jsonEncode(oktaConfig)},
    );
    isInitialized = initStatus ?? false;
    return initStatus;
  }

  @override
  Future<Map<dynamic, dynamic>?> login() async {
    if (isInitialized) {
      final loginResponse =
          await methodChannel.invokeMethod<Map<dynamic, dynamic>>('sign-in');
      return loginResponse;
    } else {
      return {'status': false, 'message': 'Okta not initialized'};
    }
  }

  @override
  Future<Map<dynamic, dynamic>?> socialLogin(Map<String, String> map) async {
    if (isInitialized) {
      final loginResponse =
          await methodChannel.invokeMethod<Map<dynamic, dynamic>>(
        'social-login',
        map,
      );
      return loginResponse;
    } else {
      return {'status': false, 'message': 'Okta not initialized'};
    }
  }

  @override
  Future<Map<dynamic, dynamic>?> getAccessToken() async {
    if (isInitialized) {
      final accessToken = await methodChannel
          .invokeMethod<Map<dynamic, dynamic>>('get-access-token');
      return accessToken;
    } else {
      return {'status': false, 'message': 'Okta not initialized'};
    }
  }

  @override
  Future<bool?> logout() async {
    if (isInitialized) {
      final logoutStatus =
          await methodChannel.invokeMethod<bool>('logout');
      return logoutStatus;
    } else {
      return false;
    }
  }

  @override
  Future<dynamic> getUserProfile() async {
    if (isInitialized) {
      final userProfile =
          await methodChannel.invokeMethod<dynamic>('get-user-profile');
      return userProfile;
    } else {
      throw FlutterError('Okta not initialized');
    }
  }
}
