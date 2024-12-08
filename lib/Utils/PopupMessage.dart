import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class PopupManager {
  static final PopupManager _instance = PopupManager._internal();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  bool show = false;
  String txt = "";
  Duration entryd = const Duration(milliseconds: 100);
  Duration midd = const Duration(milliseconds: 3500);
  Duration exitd = const Duration(milliseconds: 100);

  final ValueNotifier<String> animationState = ValueNotifier("idle");

  OverlayEntry? _overlayEntry;

  PopupManager._internal();

  factory PopupManager() {
    return _instance;
  }

  /// Attach the navigator key to the root navigator
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  Future<void> showmessage({
    required String text,
    Duration entry = const Duration(milliseconds: 100),
    Duration mid = const Duration(milliseconds: 3000),
    Duration exit = const Duration(milliseconds: 100),
  }) async {
    if (show) {
      return; // Évite les superpositions multiples
    }

    entryd = entry;
    midd = mid;
    exitd = exit;
    txt = text;
    show = true;

    final overlayState = _navigatorKey.currentState?.overlay;

    if (overlayState == null) {
      show = false;
      return;
    }

    _overlayEntry = _createOverlayEntry();
    overlayState.insert(_overlayEntry!);

    await Future.delayed(const Duration(milliseconds: 100));

    animationState.value = "entry";
    await Future.delayed(entry);

    animationState.value = "mid";
    await Future.delayed(mid);

    animationState.value = "exit";
    await Future.delayed(exit);

    await Future.delayed(const Duration(milliseconds: 100));
    _overlayEntry?.remove();
    _overlayEntry = null;

    animationState.value = "idle";
    show = false;
    txt = "";
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned(
                left: (constraints.maxWidth - _calculateWidgetWidth()) / 2,
                bottom: 550,
                child: ValueListenableBuilder<String>(
                  valueListenable: animationState,
                  builder: (context, state, child) {
                    double scale;
                    Duration duration;
                    double opa;

                    if (state == "entry") {
                      scale = 1;
                      opa = 1;
                      duration = entryd;
                    } else if (state == "mid") {
                      scale = 1;
                      opa = 1;

                      duration = midd;
                    } else if (state == "exit") {
                      scale = 0.6;
                      opa = 0;

                      duration = exitd;
                    } else {
                      scale = 0.6;
                      opa = 0;
                      duration = const Duration(milliseconds: 0);
                    }

                    return AnimatedScale(
                      duration: duration,
                      scale: scale,
                      curve: Curves.easeInOut,
                      child: AnimatedOpacity(
                        opacity: opa,
                        duration: const Duration(milliseconds: 100),
                        child: child,
                      ),
                    );
                  },
                  child: GlassContainer(
                    color: Colors.black.withOpacity(0.5),
                    blur: 10,
                    borderRadius: BorderRadius.circular(14),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Center(
                        child: DefaultTextStyle(
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          child: Text(
                            txt,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  double _calculateWidgetWidth() {
    const double basePadding = 24;
    const double charWidth = 8;
    return basePadding + (txt.length * charWidth).clamp(50, 300);
  }
}