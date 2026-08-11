# okta_oidc_plus

[![pub package](https://img.shields.io/pub/v/okta_oidc_plus.svg)](https://pub.dev/packages/okta_oidc_plus)

A modern, high-performance Flutter plugin for Okta OIDC authentication. Seamlessly integrate secure user login, token management, PKCE flows, and identity integration with Okta in your Flutter applications.

## Features

- 🔐 **Secure OIDC Authentication**: Built-in support for Okta WebAuth PKCE flow.
- 🌐 **Social Sign-In**: Support for LinkedIn, Google, Apple, and custom IDP identity providers.
- 🔑 **Automatic Token Refresh**: Transparently fetches and renews access tokens.
- 👤 **User Claims & Profile**: Direct access to authenticated user claims payload.
- 🏗️ **Clean Architecture Example**: Bundled with a production-ready Clean Architecture sample app.

---

## Installation

Add `okta_oidc_plus` to your `pubspec.yaml`:

```yaml
dependencies:
  okta_oidc_plus: ^1.0.0
```

### Platform Setup

#### Android

1. Ensure your `minSdkVersion` is set to `21` or higher in `android/app/build.gradle`:

```groovy
android {
    compileSdkVersion 34

    defaultConfig {
        minSdkVersion 21
        manifestPlaceholders = [
            "appAuthRedirectScheme": "com.yourdomain.app"
        ]
    }
}
```

2. Register your redirect URI scheme in your Android manifest or build placeholders as shown above.

#### iOS

1. Set the minimum deployment target in `ios/Podfile` to `13.0` or higher:

```ruby
platform :ios, '13.0'
```

---

## Configuration

Create an `assets/okta_config.json` file in your root project directory:

```json
{
  "client_id": "YOUR_OKTA_CLIENT_ID",
  "redirect_uri": "com.yourdomain.app:/callback",
  "end_session_redirect_uri": "com.yourdomain.app:/logout",
  "scopes": ["openid", "profile", "email", "offline_access"],
  "discovery_uri": "https://YOUR_OKTA_DOMAIN.okta.com/oauth2/default"
}
```

Remember to declare the asset in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/okta_config.json
```

---

## Usage

### 1. Initialize Okta Client

```dart
import 'package:okta_oidc_plus/okta_oidc_plus.dart';

final oktaOidcPlus = OktaOidcPlus();

Future<void> initOkta() async {
  final configString = await rootBundle.loadString('assets/okta_config.json');
  final Map<String, dynamic> oktaConfig = jsonDecode(configString);
  await oktaOidcPlus.initOkta(oktaConfig);
}
```

### 2. User Sign-In

```dart
final response = await oktaOidcPlus.login();
if (response != null && response['status'] == true) {
  print('Successfully logged in');
}
```

### 3. Social Sign-In

```dart
final response = await oktaOidcPlus.socialLogin({
  "idp": "YOUR_IDP_ID",
  "idp-scope": "email profile",
});
```

### 4. Fetch Access Token

```dart
final tokenResponse = await oktaOidcPlus.getAccessToken();
final accessToken = tokenResponse?['message'];
```

### 5. Fetch User Profile

```dart
final userProfile = await oktaOidcPlus.getUserProfile();
print(userProfile);
```

### 6. Sign Out

```dart
final isLoggedOut = await oktaOidcPlus.logout();
```

---

## Sample App & Clean Architecture

Check out the included [`example`](example) application featuring a production-ready **Clean Architecture** layout:
- **Domain Layer**: Entities (`UserEntity`, `AuthStatus`), Repositories, and UseCases (`LoginUseCase`, `LogoutUseCase`, `GetUserProfileUseCase`, `GetAccessTokenUseCase`).
- **Data Layer**: DataSources (`OktaRemoteDataSource`), Models (`UserModel`), and Repository Implementations.
- **Presentation Layer**: State Notification (`AuthNotifier`), Custom Theme, Glassmorphism UI Components, and Dashboard views.

---

## Author & Contact

Developed and maintained by **Eebrahim Joy**.

- 📧 **Email**: [eebrahimjoy@gmail.com](mailto:eebrahimjoy@gmail.com)
- 🌐 **Website**: [eebrahimjoy.com](https://eebrahimjoy.com)
- 🐙 **GitHub**: [@eebrahimjoy](https://github.com/eebrahimjoy)

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.