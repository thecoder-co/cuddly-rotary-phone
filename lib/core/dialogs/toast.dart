import "dart:async";
import "dart:ui";

import "package:calorie_tracker/packages/packages.dart";
import "package:flutter_svg/svg.dart";
import 'package:flutter/material.dart';

enum AppToastType { success, error, info }

class AppToast {
  static void success(String? message) {
    _show(message, type: AppToastType.success);
  }

  static void error(String? message) {
    _show(message, type: AppToastType.error);
  }

  static void info(String? message) {
    _show(message, type: AppToastType.info);
  }

  static void _show(String? message, {required AppToastType type}) {
    // Use the navigator state's overlay directly — Overlay.of(context) would
    // search upward for an ancestor Overlay, but the Navigator IS the root
    // overlay host so there's nothing above it to find.
    final overlay = NavigationService.navigatorKey.currentState?.overlay;
    if (overlay == null) return;

    final Color backgroundColor;
    final Color borderColor;

    switch (type) {
      case AppToastType.success:
        backgroundColor = const Color(0xff124D00).withValues(alpha: .22);
        borderColor = const Color(0xFF00CD60);
        break;
      case AppToastType.error:
        backgroundColor = const Color(0xff530000).withValues(alpha: .22);
        borderColor = const Color(0xFFFF0707);
        break;
      case AppToastType.info:
        backgroundColor = const Color(0xff875003).withValues(alpha: .22);
        borderColor = const Color(0xFFCD7700);
        break;
    }

    OverlayEntry? entry;

    entry = OverlayEntry(
      builder: (context) {
        return _TopNotificationBanner(
          message: message ?? "",
          backgroundColor: backgroundColor,
          borderColor: borderColor,
          onDismissed: () {
            entry?.remove();
          },
        );
      },
    );

    overlay.insert(entry);
  }
}

class _TopNotificationBanner extends StatefulWidget {
  const _TopNotificationBanner({
    super.key,
    required this.message,
    required this.backgroundColor,
    required this.borderColor,
    required this.onDismissed,
  });

  final String message;
  final Color backgroundColor;
  final Color borderColor;

  final VoidCallback onDismissed;

  @override
  State<_TopNotificationBanner> createState() => _TopNotificationBannerState();
}

class _TopNotificationBannerState extends State<_TopNotificationBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  Timer? _dismissTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        widget.onDismissed();
      }
    });

    _controller.forward();

    _dismissTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _dismiss() {
    _dismissTimer?.cancel();
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Material(
        color: Colors.transparent,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            if (_controller.isDismissed) {
              return const SizedBox.shrink();
            }
            return SlideTransition(position: _offsetAnimation, child: child);
          },
          child: GestureDetector(
            onTap: _dismiss,
            behavior: HitTestBehavior.translucent,
            onVerticalDragEnd: (details) => _dismiss,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  height: MediaQuery.paddingOf(context).top + 35,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    color: widget.backgroundColor,
                    border: Border(
                      bottom: BorderSide(color: widget.borderColor, width: .5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          widget.message,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
