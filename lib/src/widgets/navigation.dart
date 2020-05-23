import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/provider/conductor.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _value = context.watch<Conductor>().value;
    return Material(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      elevation: 24.0 * (_value * 2),
      child: Container(
        alignment: Alignment.center,
        height: kBottomNavigationBarHeight * (1.0 - _value),
        child: ListView(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
              height: kBottomNavigationBarHeight,
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Material(
                color: Color(0xFFF7F7FA),
                borderRadius: BorderRadius.circular(8.0),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      _navigationItem(
                        context: context,
                        label: 'Dashboard',
                        index: 0,
                      ),
                      _navigationItem(
                        context: context,
                        label: 'Settings',
                        index: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navigationItem({BuildContext context, String label, int index}) {
    Conductor conductor = context.watch<Conductor>();
    bool selected = conductor.index == index;
    final theme = Theme.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: () => conductor.changeIndex(index),
        child: AnimatedContainer(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: selected ? Colors.white : Color(0xFFF7F7FA),
            boxShadow: [
              BoxShadow(
                color: selected ? Colors.grey[300] : Color(0xFFF7F7FA),
                blurRadius: selected ? 1.0 : 0.0,
                spreadRadius: selected ? 2.0 : 0.0,
                offset: Offset(0.0, 1.0),
              )
            ],
          ),
          duration: Duration(milliseconds: 220),
          margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
          child: AnimatedDefaultTextStyle(
            textAlign: TextAlign.center,
            duration: Duration(milliseconds: 120),
            style: selected
                ? theme.textTheme.headline6.copyWith(fontSize: 15.0)
                : theme.textTheme.headline6.copyWith(fontSize: 12.0),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}
