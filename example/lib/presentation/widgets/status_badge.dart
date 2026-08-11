import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/auth_status.dart';

class StatusBadge extends StatelessWidget {
  final AuthStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    String label;
    IconData icon;

    switch (status) {
      case AuthStatus.authenticated:
        badgeColor = AppColors.success;
        label = 'Authenticated';
        icon = Icons.check_circle_rounded;
        break;
      case AuthStatus.unauthenticated:
        badgeColor = AppColors.textSecondary;
        label = 'Unauthenticated';
        icon = Icons.lock_outline_rounded;
        break;
      case AuthStatus.loading:
        badgeColor = AppColors.primary;
        label = 'Processing...';
        icon = Icons.sync_rounded;
        break;
      case AuthStatus.error:
        badgeColor = AppColors.error;
        label = 'Auth Error';
        icon = Icons.error_outline_rounded;
        break;
      case AuthStatus.initial:
        badgeColor = AppColors.secondary;
        label = 'Initializing';
        icon = Icons.hourglass_empty_rounded;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: badgeColor.withValues(alpha: 0.5), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: badgeColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: badgeColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
