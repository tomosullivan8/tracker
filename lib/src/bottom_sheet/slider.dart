import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/provider/cardinal.dart';

class SheetSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cardinal>(
      builder: (context, cardinal, child) => Slider(
        value: cardinal.value.roundToDouble(),
        onChanged: (value) {
          cardinal.changeValue(value.roundToDouble());
        },
        min: cardinal.min,
        max: cardinal.max,
      ),
    );
  }
}
