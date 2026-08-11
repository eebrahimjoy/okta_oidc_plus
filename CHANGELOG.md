# 1.0.2

- Removed unnecessary `shared_preferences` dependency from example app repository implementation for complete zero-external-dependency self-containment.

# 1.0.1

- Package optimization: Excluded example app build artifacts from pub package upload via `.pubignore` for a lightweight package download.
- Added direct GitHub repository link for full Clean Architecture sample app in `README.md`.
- Updated author metadata and contact links (`eebrahimjoy@gmail.com`, `eebrahimjoy.com`).

# 1.0.0

- **Breaking Change**: Renamed package from `okta_oidc` to `okta_oidc_plus`.
- **Android**: Added explicit `namespace 'com.okta.okta_oidc_plus'` in plugin `build.gradle` (fixes AGP 8+ build issue). Updated `minSdkVersion` to 21, `compileSdkVersion` to 34, and Java target to 17.
- **iOS**: Upgraded minimum deployment target to iOS 13.0+, updated Swift plugin bindings.
- **Example App**: Complete architectural overhaul using **Clean Architecture** (Domain, Data, Presentation layers) with a modern dark theme and custom glassmorphism design system.
- **Code Quality**: Updated Dart SDK constraint (`>=3.0.0 <4.0.0`), resolved all lint warnings and deprecated API usages.
