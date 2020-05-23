import 'package:flutter/material.dart';
import 'bottom_sheet/draggable_sheet.dart';
import 'widgets/navigation.dart';

class Home extends StatelessWidget {
  Home({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          child,
          DraggableSheet(),
        ],
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
