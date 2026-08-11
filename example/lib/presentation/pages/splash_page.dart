import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/auth_status.dart';
import '../state/auth_notifier.dart';
import 'login_page.dart';
import 'profile_page.dart';

class SplashPage extends StatefulWidget {
  final AuthNotifier notifier;

  const SplashPage({super.key, required this.notifier});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    widget.notifier.addListener(_onAuthStatusChanged);
    await widget.notifier.initialize();
  }

  void _onAuthStatusChanged() {
    if (!mounted) return;
    if (widget.notifier.status == AuthStatus.unauthenticated ||
        widget.notifier.status == AuthStatus.error) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LoginPage(notifier: widget.notifier),
        ),
      );
    } else if (widget.notifier.status == AuthStatus.authenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ProfilePage(notifier: widget.notifier),
        ),
      );
    }
  }

  @override
  void dispose() {
    widget.notifier.removeListener(_onAuthStatusChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.background, Color(0xFF1E1B4B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.shield_outlined,
                  size: 44,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Okta OIDC Plus',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Clean Architecture Flutter Example',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 48),
              const CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
