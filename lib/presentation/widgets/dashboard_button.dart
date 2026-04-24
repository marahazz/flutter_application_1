import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DashboardButton extends StatefulWidget {
  const DashboardButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.description,
    this.height = 54,
    this.showArrow = true,
    this.fullWidth = true,
    this.gradient,
  });

  final IconData icon;
  final String title;
  final String? description;
  final VoidCallback onTap;
  final double height;
  final bool showArrow;
  final bool fullWidth;
  final LinearGradient? gradient;

  @override
  State<DashboardButton> createState() => _DashboardButtonState();
}

class _DashboardButtonState extends State<DashboardButton> {
  static const _dur = Duration(milliseconds: 200);
  static const _curve = Curves.easeInOut;

  bool _hovered = false;
  bool _pressed = false;

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

  void _setPressed(bool v) {
    if (_pressed == v) return;
    setState(() => _pressed = v);
  }

  @override
  Widget build(BuildContext context) {
    double a(double opacity) => opacity.clamp(0.0, 1.0).toDouble();
    final radius = BorderRadius.circular(widget.height / 2);

    final scale = _pressed ? 0.992 : (_hovered ? 1.01 : 1.0);
    final slide = _pressed
        ? const Offset(0, 0.010)
        : (_hovered ? const Offset(0, -0.006) : Offset.zero);

    final glow = _hovered ? 1.0 : 0.65;
    final baseShadow = BoxShadow(
      color: const Color(0xFF000814).withValues(alpha: a(0.40)),
      blurRadius: _hovered ? 22 : 16,
      offset: const Offset(0, 10),
    );
    final neonShadowA = BoxShadow(
      color: const Color(0xFF22D3EE).withValues(alpha: a(0.18 * glow)),
      blurRadius: _hovered ? 30 : 18,
      offset: const Offset(0, 10),
    );
    final neonShadowB = BoxShadow(
      color: const Color(0xFF60A5FA).withValues(alpha: a(0.14 * glow)),
      blurRadius: _hovered ? 44 : 26,
      offset: const Offset(0, 14),
    );

    final gradient = widget.gradient ??
        const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0x1260A5FA),
            Color(0x0D5EEAD4),
            Color(0x085EEAD4),
          ],
        );

    final child = MouseRegion(
      onEnter: (_) => _setHovered(true),
      onExit: (_) => _setHovered(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => _setPressed(true),
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),
        onTap: widget.onTap,
        child: AnimatedScale(
          duration: _dur,
          curve: _curve,
          scale: scale,
          child: AnimatedSlide(
            duration: _dur,
            curve: _curve,
            offset: slide,
            child: AnimatedContainer(
              duration: _dur,
              curve: _curve,
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: radius,
                boxShadow: [baseShadow, neonShadowA, neonShadowB],
              ),
              child: ClipRRect(
                borderRadius: radius,
                child: Stack(
                  children: [
                    // glass blur layer
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: _hovered ? 18 : 14,
                          sigmaY: _hovered ? 18 : 14,
                        ),
                        child: const SizedBox.expand(),
                      ),
                    ),
                    // glass tint + neon border
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: gradient,
                          color: const Color(0xFFFFFFFF)
                              .withValues(alpha: a(_hovered ? 0.08 : 0.06)),
                          borderRadius: radius,
                          border: Border.all(
                            color: Color.lerp(
                              const Color(0xFF22D3EE).withValues(alpha: a(0.38)),
                              const Color(0xFF60A5FA).withValues(alpha: a(0.30)),
                              0.55,
                            )!
                                .withValues(alpha: a(_hovered ? 0.85 : 0.55)),
                            width: 1.2,
                          ),
                        ),
                      ),
                    ),
                    // soft inner light (top sheen)
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: radius,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withValues(
                                alpha: a(_hovered ? 0.12 : 0.09),
                              ),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.55],
                          ),
                        ),
                      ),
                    ),
                    // content
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: _dur,
                            curve: _curve,
                            height: widget.height - 14,
                            width: widget.height - 14,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(widget.height / 2),
                              color: const Color(0xFFFFFFFF)
                                  .withValues(alpha: a(0.06)),
                              border: Border.all(
                                color: const Color(0xFF22D3EE).withValues(
                                  alpha: a(_hovered ? 0.55 : 0.32),
                                ),
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              widget.icon,
                              color: Color.lerp(
                                const Color(0xFF93C5FD),
                                const Color(0xFF67E8F9),
                                _hovered ? 0.55 : 0.25,
                              ),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              widget.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withValues(
                                  alpha: a(_hovered ? 0.98 : 0.92),
                                ),
                                fontWeight: FontWeight.w700,
                                fontSize: 14.5,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                          if (widget.showArrow) ...[
                            const SizedBox(width: 10),
                            AnimatedContainer(
                              duration: _dur,
                              curve: _curve,
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF)
                                    .withValues(alpha: a(_hovered ? 0.07 : 0.05)),
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                  color: const Color(0xFF60A5FA).withValues(
                                    alpha: a(_hovered ? 0.38 : 0.20),
                                  ),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                size: 16,
                                color: const Color(0xFF93C5FD).withValues(
                                  alpha: a(_hovered ? 0.95 : 0.75),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (widget.fullWidth) return SizedBox(width: double.infinity, child: child);
    return child;
  }
}

