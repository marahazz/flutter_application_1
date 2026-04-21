import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';

/// Repair shop dashboard (placeholder for step 8).
class RepairShopDashboardPage extends StatelessWidget {
  const RepairShopDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repair Shop Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.go(AppRoutes.auth),
          ),
        ],
      ),
      body: const Center(child: Text('Repair shop dashboard (step 8)')),
    );
  }
}
