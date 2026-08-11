import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../state/auth_notifier.dart';
import '../widgets/action_button.dart';
import '../widgets/glass_card.dart';
import '../widgets/status_badge.dart';
import '../widgets/token_modal.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  final AuthNotifier notifier;

  const ProfilePage({super.key, required this.notifier});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    widget.notifier.fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.notifier,
      builder: (context, _) {
        final user = widget.notifier.user;

        return Scaffold(
          appBar: AppBar(
            title: const Text('User Dashboard'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: StatusBadge(status: widget.notifier.status),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlassCard(
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [AppColors.primary, AppColors.secondary],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user.email.isNotEmpty ? user.email : user.preferredUsername,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Profile Details',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                GlassCard(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildDetailRow('User ID', user.id),
                      const Divider(color: AppColors.border),
                      _buildDetailRow('Username', user.preferredUsername),
                      const Divider(color: AppColors.border),
                      _buildDetailRow('Email', user.email),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'OIDC Claims',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                GlassCard(
                  padding: const EdgeInsets.all(16),
                  child: user.rawClaims.isEmpty
                      ? const Text(
                          'No claims returned.',
                          style: TextStyle(color: AppColors.textSecondary),
                        )
                      : Column(
                          children: user.rawClaims.entries.map((entry) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 110,
                                    child: Text(
                                      entry.key,
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      entry.value.toString(),
                                      style: const TextStyle(
                                        color: AppColors.textPrimary,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                ),
                const SizedBox(height: 28),
                ActionButton(
                  label: 'Inspect Access Token',
                  icon: Icons.key_rounded,
                  isSecondary: true,
                  onPressed: () async {
                    final token = await widget.notifier.fetchAccessToken();
                    if (context.mounted) {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (_) => TokenModal(token: token),
                      );
                    }
                  },
                ),
                const SizedBox(height: 14),
                ActionButton(
                  label: 'Sign Out',
                  icon: Icons.logout_rounded,
                  onPressed: () async {
                    final success = await widget.notifier.logout();
                    if (success && context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginPage(notifier: widget.notifier),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          Flexible(
            child: Text(
              value.isEmpty ? 'N/A' : value,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
