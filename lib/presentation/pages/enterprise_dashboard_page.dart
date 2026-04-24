
// ignore_for_file: unnecessary_underscores

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:autonexa/l10n/app_localizations.dart';

import '../widgets/dashboard_button.dart';
import '../widgets/premium_top_nav_bar.dart';

class EnterpriseDashboardPage extends StatelessWidget {
  const EnterpriseDashboardPage({super.key});

  static const List<_DashboardItem> _items = [
    _DashboardItem(
      icon: Icons.history_edu_outlined,
      titleKey: _DashboardTitleKey.viewScanHistory,
      route: '/customer/history',
    ),
    _DashboardItem(
      icon: Icons.chat_bubble_outline,
      titleKey: _DashboardTitleKey.aiChatAssistant,
      route: '/ai-chat',
    ),
    _DashboardItem(
      icon: Icons.dashboard_outlined,
      titleKey: _DashboardTitleKey.workshopDashboard,
      route: '/repair-shop',
    ),
    _DashboardItem(
      icon: Icons.calendar_today_outlined,
      titleKey: _DashboardTitleKey.bookAppointment,
      route: '/book-appointment',
    ),
    _DashboardItem(
      icon: Icons.rate_review_outlined,
      titleKey: _DashboardTitleKey.workshopReviews,
      route: '/workshop-reviews',
    ),
    _DashboardItem(
      icon: Icons.compare_arrows_outlined,
      titleKey: _DashboardTitleKey.compareWorkshops,
      route: '/workshop-comparison',
    ),
    _DashboardItem(
      icon: Icons.share_outlined,
      titleKey: _DashboardTitleKey.exportShareReport,
      route: '/export-report',
    ),
    _DashboardItem(
      icon: Icons.settings_outlined,
      titleKey: _DashboardTitleKey.settings,
      route: '/settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF070A12),
      appBar: PremiumTopNavBar(title: AppLocalizations.of(context)!.commandCenter),
      body: Stack(
        children: [
          // dark gradient base
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF060913),
                    Color(0xFF070A12),
                    Color(0xFF0B1222),
                  ],
                ),
              ),
            ),
          ),
          // subtle tech pattern
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _TechPatternPainter(),
                child: const SizedBox.expand(),
              ),
            ),
          ),
          // subtle background glow so the grid doesn't feel empty
          Positioned(
            right: -120,
            top: size.height * 0.12,
            child: Container(
              height: 280,
              width: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF60A5FA).withValues(alpha: 0.14),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: -130,
            bottom: -120,
            child: Container(
              height: 320,
              width: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF22D3EE).withValues(alpha: 0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final maxWidth = w >= 980 ? 760.0 : (w >= 620 ? 560.0 : w);

              return Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
                    itemCount: _items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final l10n = AppLocalizations.of(context)!;
                      final item = _items[index];

                      final gradient = _dashboardGradientForIndex(index);
                      return DashboardButton(
                        icon: item.icon,
                        title: _titleForKey(l10n, item.titleKey),
                        description: null,
                        gradient: gradient,
                        height: 54,
                        showArrow: true,
                        fullWidth: true,
                        onTap: () => context.go(item.route),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  LinearGradient _dashboardGradientForIndex(int index) {
    const palettes = [
      [Color(0x2460A5FA), Color(0x165EEAD4), Color(0x0FDB2777)],
      [Color(0x245EEAD4), Color(0x1A22C55E), Color(0x0F60A5FA)],
      [Color(0x24A78BFA), Color(0x1618A34A), Color(0x0F5EEAD4)],
      [Color(0x24F472B6), Color(0x16FB7185), Color(0x0F60A5FA)],
      [Color(0x24F59E0B), Color(0x16F97316), Color(0x0F5EEAD4)],
    ];
    final colors = palettes[index % palettes.length];
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: colors,
    );
  }

  static String _titleForKey(AppLocalizations l10n, _DashboardTitleKey key) {
    switch (key) {
      case _DashboardTitleKey.viewScanHistory:
        return l10n.viewScanHistory;
      case _DashboardTitleKey.aiChatAssistant:
        return l10n.aiChatAssistant;
      case _DashboardTitleKey.workshopDashboard:
        return l10n.workshopDashboard;
      case _DashboardTitleKey.bookAppointment:
        return l10n.bookAppointment;
      case _DashboardTitleKey.workshopReviews:
        return l10n.workshopReviews;
      case _DashboardTitleKey.compareWorkshops:
        return l10n.compareWorkshops;
      case _DashboardTitleKey.exportShareReport:
        return l10n.exportShareReport;
      case _DashboardTitleKey.settings:
        return l10n.settings;
    }
  }
}

class _DashboardItem {
  const _DashboardItem({
    required this.icon,
    required this.titleKey,
    required this.route,
  });

  final IconData icon;
  final _DashboardTitleKey titleKey;
  final String route;
}

enum _DashboardTitleKey {
  viewScanHistory,
  aiChatAssistant,
  workshopDashboard,
  bookAppointment,
  workshopReviews,
  compareWorkshops,
  exportShareReport,
  settings,
}

class _TechPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6
      ..color = const Color(0xFF93C5FD).withValues(alpha: 0.035);

    const step = 28.0;
    for (var x = 0.0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (var y = 0.0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final dots = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFF22D3EE).withValues(alpha: 0.05);
    for (var y = 12.0; y < size.height; y += 56) {
      for (var x = 14.0; x < size.width; x += 56) {
        canvas.drawCircle(Offset(x, y), 1.1, dots);
      }
    }

    final diag = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = const Color(0xFF60A5FA).withValues(alpha: 0.04);
    canvas.drawLine(const Offset(0, 0), Offset(size.width, size.height), diag);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}