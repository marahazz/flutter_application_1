/// Application-wide constants for AUTONEXA.
/// Centralizes route names, role identifiers, and app metadata.
library;

/// Route path names for navigation.
abstract class AppRoutes {

  /// 🔹 First screen (Welcome Page)
  static const String welcome = '/';

  /// 🔹 Role selection page
  static const String auth = '/auth';

  /// 🔹 Customer routes
  static const String customerHome = '/customer';
  static const String customerUpload = '/customer/upload';
  static const String customerHistory = '/customer/history';

  /// 🔹 Admin route
  static const String adminDashboard = '/admin';

  /// 🔹 Repair shop route
  static const String repairShopDashboard = '/repair-shop';

  /// 🔹 Enterprise dashboard route
  static const String enterpriseDashboard = '/enterprise-dashboard';
}

/// User role identifiers (role selection only - no real auth for now).
enum AppRole {
  customer('Customer'),
  admin('Admin'),
  repairShop('Repair Shop');

  const AppRole(this.label);
  final String label;
}

/// App metadata.
abstract class AppConstants {
  static const String appName = 'AUTONEXA';
  static const String appTagline =
      'Vehicle Damage Assessment & Cost Estimation';
}