import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';

/// Authentication / role selection page.
/// User selects role: Customer, Admin, or Repair Shop (no real auth).
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primaryContainer.withValues(alpha: 0.3),
              colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppConstants.appName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppConstants.appTagline,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: 48),
                    Text(
                      'Select your role',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 24),
                    for (final role in AppRole.values) ...[
                      _RoleCard(
                        role: role,
                        onTap: () {
                          switch (role) {
                            case AppRole.customer:
                              context.go(AppRoutes.customerHome);
                              break;
                            case AppRole.admin:
                              context.go(AppRoutes.adminDashboard);
                              break;
                            case AppRole.repairShop:
                              context.go(AppRoutes.repairShopDashboard);
                              break;
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({required this.role, required this.onTap});

  final AppRole role;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Row(
            children: [
              Icon(
                _iconForRole(role),
                size: 32,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 16),
              Text(
                role.label,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconForRole(AppRole role) {
    switch (role) {
      case AppRole.customer:
        return Icons.person_outline;
      case AppRole.admin:
        return Icons.admin_panel_settings_outlined;
      case AppRole.repairShop:
        return Icons.build_circle_outlined;
    }
  }
}