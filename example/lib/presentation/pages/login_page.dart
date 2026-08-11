import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/auth_status.dart';
import '../state/auth_notifier.dart';
import '../widgets/action_button.dart';
import '../widgets/glass_card.dart';
import '../widgets/status_badge.dart';
import 'profile_page.dart';

class LoginPage extends StatefulWidget {
  final AuthNotifier notifier;

  const LoginPage({super.key, required this.notifier});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.notifier,
      builder: (context, _) {
        final isLoading = widget.notifier.status == AuthStatus.loading;
        final error = widget.notifier.errorMessage;

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Okta OIDC Plus',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      StatusBadge(status: widget.notifier.status),
                    ],
                  ),
                  const Spacer(),
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.lock_person_rounded,
                            color: AppColors.primary,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Secure Login',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Authenticate seamlessly with your Okta OpenID Connect identity provider.',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildFeatureRow(
                            Icons.check_circle_outline_rounded, 'PKCE Authorization Flow'),
                        const SizedBox(height: 8),
                        _buildFeatureRow(
                            Icons.token_outlined, 'Secure Token Storage & Refresh'),
                        const SizedBox(height: 8),
                        _buildFeatureRow(
                            Icons.verified_user_outlined, 'Clean Architecture Pattern'),
                        if (error != null) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.error.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: AppColors.error.withValues(alpha: 0.4)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.error_outline,
                                    color: AppColors.error, size: 18),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    error,
                                    style: const TextStyle(
                                      color: AppColors.error,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 28),
                        ActionButton(
                          label: 'Sign in with Okta',
                          icon: Icons.login_rounded,
                          isLoading: isLoading,
                          onPressed: () async {
                            final success = await widget.notifier.login();
                            if (success && context.mounted) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ProfilePage(notifier: widget.notifier),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Powered by okta_oidc_plus',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
