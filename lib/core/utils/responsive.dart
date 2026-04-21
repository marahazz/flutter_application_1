import 'package:flutter/material.dart';

/// Responsive breakpoints and layout helpers for AUTONEXA.
class Responsive {
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobileBreakpoint;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w >= mobileBreakpoint && w < desktopBreakpoint;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= desktopBreakpoint;

  /// Max content width for readable layouts on large screens.
  static double contentMaxWidth(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= desktopBreakpoint) return 1200;
    if (w >= tabletBreakpoint) return 900;
    return w;
  }
}
