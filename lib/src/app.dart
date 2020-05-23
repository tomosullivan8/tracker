import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tracker/provider/conductor.dart';
import 'home.dart';
import 'theme.dart';
import '../provider/cardinal.dart';
import 'widgets/loading.dart';
import 'widgets/tabs.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      builder: (context, child) {
        Conductor conductor = context.watch<Conductor>();
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Color.lerp(
              Colors.white,
              Color(0xFFF7F7FA),
              conductor.value,
            ),
          ),
          child: ScrollConfiguration(
            behavior: _BouncingScrollBehavior(),
            child: child,
          ),
        );
      },
      home: Home(
        child: _Backdrop(),
      ),
    );
  }
}

class _Backdrop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cardinal>(
      builder: (context, cardinal, child) {
        switch (cardinal.loading) {
          case true:
            return Loading();
          case false:
            return Tabs();
          default:
            return Loading();
        }
      },
    );
  }
}

class _BouncingScrollBehavior extends ScrollBehavior {
  const _BouncingScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics();
}
