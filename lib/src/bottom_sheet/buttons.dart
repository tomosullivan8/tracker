import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/provider/cardinal.dart';
import 'package:tracker/provider/conductor.dart';

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Cardinal cardinal = context.watch<Cardinal>();
    return Consumer<Conductor>(
      builder: (context, conductor, child) => Opacity(
        opacity: conductor.value,
        child: child,
      ),
      child: Container(
        height: kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _button(
              Icons.keyboard_arrow_up,
              cardinal.increaseIncrement,
            ),
            _button(
              Icons.add,
              cardinal.addItem,
              color: Colors.grey[200],
            ),
            _button(
              Icons.keyboard_arrow_down,
              cardinal.decreaseIncrement,
            ),
          ],
        ),
      ),
    );
  }

  Widget _button(IconData icon, Function onTap, {Color color}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      child: Material(
        type: MaterialType.circle,
        color: color ?? Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(icon),
          ),
        ),
      ),
    );
  }
}
