import 'package:autonexa/data/models/repair_tracking.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:autonexa/core/constants/app_constants.dart';
import 'package:autonexa/presentation/pages/welcome_page.dart';
import 'package:autonexa/presentation/pages/auth_page.dart';
import 'package:autonexa/presentation/pages/customer_home_page.dart';
import 'package:autonexa/presentation/pages/admin_dashboard_page.dart';
import 'package:autonexa/presentation/pages/repair_shop_dashboard_page.dart';
import 'package:autonexa/presentation/pages/customer_upload_page.dart';
import 'package:autonexa/presentation/pages/scan_page.dart';
import 'package:autonexa/presentation/pages/ai_damage_detection_page.dart';
import 'package:autonexa/presentation/pages/repair_cost_page.dart';
import 'package:autonexa/presentation/pages/scan_history_page.dart';
import 'package:autonexa/presentation/pages/repair_tracking_page.dart';
import 'package:autonexa/presentation/widgets/predictive_intelligence_card.dart';
import 'package:autonexa/presentation/pages/ai_chat_page.dart';
import 'package:autonexa/presentation/pages/workshop_review_page.dart';
import 'package:autonexa/presentation/pages/book_appointment_page.dart';
import 'package:autonexa/presentation/pages/export_report_page.dart';
import 'package:autonexa/presentation/pages/settings_page.dart';
import 'package:autonexa/presentation/pages/workshop_dashboard_page.dart';
import 'package:autonexa/presentation/pages/quote_request_page.dart';
import 'package:autonexa/presentation/pages/workshop_comparison_page.dart';
import 'package:autonexa/presentation/pages/enterprise_dashboard_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.welcome,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: AppRoutes.welcome,
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: AppRoutes.auth,
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      path: AppRoutes.customerHome,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const CustomerHomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      routes: [
        GoRoute(
          path: 'upload',
          builder: (context, state) => const CustomerUploadPage(),
        ),
        GoRoute(
          path: 'history',
          builder: (context, state) => const ScanHistoryPage(),
        ),
      ],
    ),
    GoRoute(path: '/scan', builder: (context, state) => const ScanPage()),
    GoRoute(
      path: '/ai-damage',
      builder: (context, state) => const AiDamageDetectionPage(),
    ),
    GoRoute(
      path: '/cost-estimate',
      builder: (context, state) => const RepairCostPage(),
    ),
    GoRoute(
      path: AppRoutes.adminDashboard,
      builder: (context, state) => const AdminDashboardPage(),
    ),
    GoRoute(
      path: AppRoutes.repairShopDashboard,
      builder: (context, state) => const RepairShopDashboardPage(),
    ),
    GoRoute(
      path: '/customer/history',
      builder: (context, state) => const ScanHistoryPage(),
    ),
    GoRoute(path: '/ai-chat', builder: (context, state) => const AIChatPage()),
    GoRoute(
      path: '/workshop-comparison',
      builder: (context, state) => const WorkshopComparisonPage(workshops: [],),
    ),
    GoRoute(
      path: '/workshop-reviews',
      builder: (context, state) => const WorkshopReviewPage(reviews: [],),
    ),
    GoRoute(
      path: '/book-appointment',
      builder: (context, state) => const BookAppointmentPage(workshopName: '',),
    ),
    GoRoute(
      path: '/export-report',
      builder: (context, state) => const ExportReportPage(reportText: '',),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/enterprise-dashboard',
      builder: (context, state) => const EnterpriseDashboardPage(),
    ),
    GoRoute(
      path: '/workshop-dashboard',
      builder: (context, state) => const WorkshopDashboardPage(),
    ),
    GoRoute(
      path: '/predictive-intelligence',
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('Predictive Intelligence')),
        body: const Center(
          child: PredictiveIntelligenceCard(
            risk: 'Low',
            advice: 'No major risks detected.',
          ),
        ),
      ),
    ),
    GoRoute(
      path: '/repair-tracking',
      builder: (context, state) => RepairTrackingPage(
        tracking: RepairTracking(
          id: 'mock',
          car: state.extra is Map && (state.extra as Map).containsKey('car')
              ? (state.extra as Map)['car']
              : 'Unknown',
          steps: [],
          currentStatus: RepairStatus.inProgress,
          createdAt: DateTime.now(),
        ),
      ),
    ),
    GoRoute(
      path: '/quote-request',
      builder: (context, state) => QuoteRequestPage(
        damageSummary:
            state.extra is Map &&
                (state.extra as Map).containsKey('damageSummary')
            ? (state.extra as Map)['damageSummary']
            : 'No summary provided.',
      ),
    ),
  ],
);
