import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:autonexa/l10n/app_localizations.dart';

import '../../core/providers/locale_provider.dart';
import '../../core/providers/theme_provider.dart';

class PremiumTopNavBar extends StatelessWidget implements PreferredSizeWidget {
  const PremiumTopNavBar({
    super.key,
    this.title,
    this.height = 72,
  });

  final String? title;
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      bottom: false,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: scheme.surface.withValues(alpha: 0.35),
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xFF60A5FA).withValues(alpha: 0.10),
                  width: 1,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.18),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                Text(
                  l10n.appName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.8,
                    fontSize: 15.5,
                    color: scheme.onSurface.withValues(alpha: 0.92),
                  ),
                ),
                if (title != null) ...[
                  const SizedBox(width: 10),
                  Container(
                    height: 26,
                    width: 1,
                    color: scheme.onSurface.withValues(alpha: 0.10),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                        fontSize: 14.5,
                        color: scheme.onSurface.withValues(alpha: 0.88),
                      ),
                    ),
                  ),
                ] else
                  const Spacer(),
                const SizedBox(width: 12),
                _LangToggle(
                  isArabic: localeProvider.isArabic,
                  onChanged: localeProvider.toggle,
                ),
                const SizedBox(width: 10),
                _ThemeToggle(
                  isDark: themeProvider.isDark,
                  onChanged: themeProvider.toggle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LangToggle extends StatefulWidget {
  const _LangToggle({required this.isArabic, required this.onChanged});

  final bool isArabic;
  final VoidCallback onChanged;

  @override
  State<_LangToggle> createState() => _LangToggleState();
}

class _LangToggleState extends State<_LangToggle> {
  bool _hovered = false;

  bool get _enableHover => kIsWeb || {
        TargetPlatform.macOS,
        TargetPlatform.windows,
        TargetPlatform.linux,
      }.contains(defaultTargetPlatform);

  void _setHovered(bool v) {
    if (!_enableHover) return;
    if (_hovered == v) return;
    setState(() => _hovered = v);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final activeOnLeft = !widget.isArabic; // EN left, AR right

    return MouseRegion(
      onEnter: (_) => _setHovered(true),
      onExit: (_) => _setHovered(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onChanged,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: scheme.surface.withValues(alpha: 0.32),
            border: Border.all(
              color: const Color(0xFF22D3EE).withValues(alpha: _hovered ? 0.30 : 0.18),
              width: 1,
            ),
            boxShadow: [
              if (_hovered)
                BoxShadow(
                  color: const Color(0xFF22D3EE).withValues(alpha: 0.14),
                  blurRadius: 22,
                  offset: const Offset(0, 10),
                ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.language_rounded,
                size: 18,
                color: scheme.onSurface.withValues(alpha: 0.78),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 72,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      alignment:
                          activeOnLeft ? Alignment.centerLeft : Alignment.centerRight,
                      child: Container(
                        width: 34,
                        height: 26,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF60A5FA).withValues(alpha: 0.60),
                              const Color(0xFF22D3EE).withValues(alpha: 0.55),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _ToggleLabel(
                            label: l10n.langEnShort,
                            active: activeOnLeft,
                          ),
                        ),
                        Expanded(
                          child: _ToggleLabel(
                            label: l10n.langArShort,
                            active: !activeOnLeft,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeToggle extends StatefulWidget {
  const _ThemeToggle({required this.isDark, required this.onChanged});
  final bool isDark;
  final VoidCallback onChanged;

  @override
  State<_ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<_ThemeToggle> {
  bool _hovered = false;

  bool get _enableHover => kIsWeb || {
        TargetPlatform.macOS,
        TargetPlatform.windows,
        TargetPlatform.linux,
      }.contains(defaultTargetPlatform);

  void _setHovered(bool v) {
    if (!_enableHover) return;
    if (_hovered == v) return;
    setState(() => _hovered = v);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final knobOnLeft = !widget.isDark; // sun left, moon right

    return MouseRegion(
      onEnter: (_) => _setHovered(true),
      onExit: (_) => _setHovered(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onChanged,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: scheme.surface.withValues(alpha: 0.32),
            border: Border.all(
              color: const Color(0xFF60A5FA).withValues(alpha: _hovered ? 0.28 : 0.16),
              width: 1,
            ),
            boxShadow: [
              if (_hovered)
                BoxShadow(
                  color: const Color(0xFF60A5FA).withValues(alpha: 0.14),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 78,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      alignment:
                          knobOnLeft ? Alignment.centerLeft : Alignment.centerRight,
                      child: Container(
                        width: 34,
                        height: 26,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: knobOnLeft
                                ? [
                                    const Color(0xFFFDE68A).withValues(alpha: 0.75),
                                    const Color(0xFF60A5FA).withValues(alpha: 0.35),
                                  ]
                                : [
                                    const Color(0xFF93C5FD).withValues(alpha: 0.65),
                                    const Color(0xFF22D3EE).withValues(alpha: 0.45),
                                  ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            switchInCurve: Curves.easeOut,
                            switchOutCurve: Curves.easeIn,
                            child: Icon(
                              Icons.wb_sunny_rounded,
                              key: ValueKey('sun-${widget.isDark}'),
                              size: 18,
                              color: scheme.onSurface.withValues(
                                alpha: knobOnLeft ? 0.92 : 0.55,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            switchInCurve: Curves.easeOut,
                            switchOutCurve: Curves.easeIn,
                            child: Icon(
                              Icons.nightlight_round,
                              key: ValueKey('moon-${widget.isDark}'),
                              size: 18,
                              color: scheme.onSurface.withValues(
                                alpha: knobOnLeft ? 0.55 : 0.92,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToggleLabel extends StatelessWidget {
  const _ToggleLabel({required this.label, required this.active});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
          color: scheme.onSurface.withValues(alpha: active ? 0.95 : 0.60),
        ),
      ),
    );
  }
}

