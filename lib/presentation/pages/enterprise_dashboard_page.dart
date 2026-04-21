import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EnterpriseDashboardPage extends StatelessWidget {
  const EnterpriseDashboardPage({super.key});

  static const List<_DashboardItem> _items = [
    _DashboardItem(
      icon: Icons.history_edu_outlined,
      title: 'View Scan History',
      description: 'Review past assessments and reports',
      route: '/customer/history',
    ),
    _DashboardItem(
      icon: Icons.chat_bubble_outline,
      title: 'AI Chat Assistant',
      description: 'Ask questions and get intelligent guidance',
      route: '/ai-chat',
    ),
    _DashboardItem(
      icon: Icons.dashboard_outlined,
      title: 'Workshop Dashboard',
      description: 'Monitor workshop performance and status',
      route: '/repair-shop',
    ),
    _DashboardItem(
      icon: Icons.calendar_today_outlined,
      title: 'Book Appointment',
      description: 'Schedule service visits with confidence',
      route: '/book-appointment',
    ),
    _DashboardItem(
      icon: Icons.rate_review_outlined,
      title: 'Workshop Reviews',
      description: 'Analyze service quality and feedback',
      route: '/workshop-reviews',
    ),
    _DashboardItem(
      icon: Icons.compare_arrows_outlined,
      title: 'Compare Workshops',
      description: 'Evaluate providers side by side',
      route: '/workshop-comparison',
    ),
    _DashboardItem(
      icon: Icons.share_outlined,
      title: 'Export/Share Report',
      description: 'Produce official reports for stakeholders',
      route: '/export-report',
    ),
    _DashboardItem(
      icon: Icons.settings_outlined,
      title: 'Settings',
      description: 'Manage system policies and preferences',
      route: '/settings',
    ),
    _DashboardItem(
      icon: Icons.analytics_outlined,
      title: 'Predictive Intelligence',
      description: 'View forecasts and operational insights',
      route: '/customer',
    ),
  ];

  static const List<_NavigationItem> _navigationItems = [
    _NavigationItem(label: 'Overview', icon: Icons.home_outlined),
    _NavigationItem(label: 'Workshops', icon: Icons.storefront_outlined),
    _NavigationItem(label: 'Reports', icon: Icons.insert_chart_outlined),
    _NavigationItem(label: 'Administration', icon: Icons.account_tree_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _governmentTheme,
      child: Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0F172A),
          elevation: 1,
          centerTitle: false,
          title: const Text(
            'AUTONEXA Command Center',
            style: TextStyle(
              color: Color(0xFFF8FAFC),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.notifications_none,
                color: Color(0xFFCBD5E1),
                size: 24,
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 14),
            _ProfileTile(),
            const SizedBox(width: 18),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final showSidebar = constraints.maxWidth >= 1100;
            final crossAxisCount = constraints.maxWidth > 1200
                ? 3
                : constraints.maxWidth > 800
                ? 2
                : 1;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showSidebar) ...[
                    _SidebarPanel(),
                    const SizedBox(width: 24),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _PageHeader(),
                        const SizedBox(height: 24),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _items.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                                childAspectRatio: 1.18,
                              ),
                          itemBuilder: (context, index) {
                            final item = _items[index];
                            return _DashboardCard(item: item);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  static final ThemeData _governmentTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF3B82F6),
      surface: Color(0xFF111827),
      background: Color(0xFF0F172A),
      onSurface: Color(0xFFF8FAFC),
      onBackground: Color(0xFFF8FAFC),
    ),
    scaffoldBackgroundColor: const Color(0xFF0F172A),
    cardTheme: CardThemeData(
      color: const Color(0xFF111827),
      elevation: 3,
      shadowColor: Colors.black45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        color: Color(0xFFF8FAFC),
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: Color(0xFFF8FAFC),
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        color: Color(0xFFCBD5E1),
        fontSize: 14,
        height: 1.6,
      ),
    ),
    fontFamily: 'Roboto',
  );
}

class _SidebarPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF334155), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enterprise Access',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          const Text(
            'Core system sections and quick navigation for secure operations.',
            style: TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          ...EnterpriseDashboardPage._navigationItems.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _SidebarItem(item: item),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF334155), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'System Status',
                  style: TextStyle(
                    color: Color(0xFFF8FAFC),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Operational • Secure • Compliant',
                  style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  const _SidebarItem({required this.item});

  final _NavigationItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(item.icon, color: const Color(0xFF60A5FA), size: 20),
        const SizedBox(width: 12),
        Text(
          item.label,
          style: const TextStyle(
            color: Color(0xFFF8FAFC),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Operational Overview',
          style: TextStyle(
            color: Color(0xFFF8FAFC),
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'A secure government dashboard with structured access and clear service controls.',
          style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 15, height: 1.6),
        ),
      ],
    );
  }
}

class _ProfileTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF334155), width: 1),
      ),
      child: const Icon(
        Icons.person_outline,
        color: Color(0xFFCBD5E1),
        size: 22,
      ),
    );
  }
}

class _DashboardCard extends StatefulWidget {
  const _DashboardCard({required this.item});

  final _DashboardItem item;

  @override
  State<_DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<_DashboardCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: const Color(0xFF111827),
          borderRadius: BorderRadius.circular(14),
          boxShadow: _isHovering
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.22),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
          border: Border.all(
            color: _isHovering
                ? const Color(0xFF334155)
                : const Color(0xFF111827),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => context.go(widget.item.route),
            borderRadius: BorderRadius.circular(14),
            splashColor: const Color(0xFF3B82F6).withOpacity(0.12),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF334155),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      widget.item.icon,
                      color: const Color(0xFF3B82F6),
                      size: 22,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    widget.item.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.item.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardItem {
  const _DashboardItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.route,
  });

  final IconData icon;
  final String title;
  final String description;
  final String route;
}

class _NavigationItem {
  const _NavigationItem({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
