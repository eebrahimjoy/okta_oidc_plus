import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'data/datasources/okta_remote_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/usecases/get_access_token_usecase.dart';
import 'domain/usecases/get_user_profile_usecase.dart';
import 'domain/usecases/initialize_okta_usecase.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/logout_usecase.dart';
import 'presentation/pages/splash_page.dart';
import 'presentation/state/auth_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Clean Architecture Dependency Injection Setup
  final remoteDataSource = OktaRemoteDataSourceImpl();
  final authRepository = AuthRepositoryImpl(remoteDataSource: remoteDataSource);

  final authNotifier = AuthNotifier(
    initializeOktaUseCase: InitializeOktaUseCase(authRepository),
    loginUseCase: LoginUseCase(authRepository),
    logoutUseCase: LogoutUseCase(authRepository),
    getUserProfileUseCase: GetUserProfileUseCase(authRepository),
    getAccessTokenUseCase: GetAccessTokenUseCase(authRepository),
  );

  runApp(MyApp(authNotifier: authNotifier));
}

class MyApp extends StatelessWidget {
  final AuthNotifier authNotifier;

  const MyApp({super.key, required this.authNotifier});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Okta OIDC Plus Clean Architecture',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: SplashPage(notifier: authNotifier),
    );
  }
}
