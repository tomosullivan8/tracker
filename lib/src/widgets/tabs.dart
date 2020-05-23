import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/provider/conductor.dart';
import 'package:tracker/src/pages/dashboard/dashboard.dart';
import 'package:tracker/src/pages/settings/settings.dart';

class Tabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Conductor conductor = context.watch<Conductor>();
    return AnimatedSwitcher(
      transitionBuilder: (child, animation) {
        final slideOut = Tween<Offset>(
          begin: Offset(-0.2, 0.0),
          end: Offset(0.0, 0.0),
        ).animate(animation);
        if (child.key == ValueKey<int>(conductor.index)) {
          return ClipRect(
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        } else {
          return ClipRect(
            child: SlideTransition(
              position: slideOut,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          );
        }
      },
      duration: Duration(milliseconds: 220),
      child: Container(
        key: ValueKey<int>(conductor.index),
        child: [
          Dashboard(),
          Settings(),
        ][conductor.index],
      ),
    );
  }
}
