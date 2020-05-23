import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tracker/model/item.dart';
import 'package:tracker/provider/cardinal.dart';

class Chart extends StatelessWidget {
  LineChartBarData _lineChartBarData(context) {
    final cardinal = Provider.of<Cardinal>(context, listen: false);
    return LineChartBarData(
      spots: List.generate(
        cardinal.items.length,
        (index) {
          Items items = cardinal.items[index];
          return FlSpot(
            items.date.millisecondsSinceEpoch / 8000000,
            items.items.fold(0, (j, i) => i.item + j),
          );
        },
      ),
      dotData: FlDotData(show: false),
      isStrokeCapRound: true,
      colors: [Colors.black],
      barWidth: 2.0,
      isCurved: true,
    );
  }

  LineChartData _lineChartData(context) {
    final cardinal = Provider.of<Cardinal>(context, listen: false);
    double max = cardinal.items.fold(
      0,
      (j, i) => i.items.fold(0, (j, i) => (i.item + j)),
    );

    double intervals = ((max ~/ 10).floor() * 10) / 6;

    return LineChartData(
      titlesData: FlTitlesData(
        leftTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            fontSize: 10.0,
            color: Colors.grey[400],
          ),
          getTitles: (value) => '${value.round()}',
          interval: intervals,
        ),
        bottomTitles: SideTitles(
            showTitles: true,
            textStyle: TextStyle(
              fontSize: 10.0,
              color: Colors.grey[400],
            ),
            getTitles: (value) {
              int time = (value * 8000000).toInt();
              return DateFormat('d MMM')
                  .format(
                    DateTime.fromMillisecondsSinceEpoch(time),
                  )
                  .toUpperCase();
            },
            interval: 1),
      ),
      lineTouchData: LineTouchData(enabled: false),
      borderData: FlBorderData(show: false),
      gridData: FlGridData(show: false),
      minY: 0.0,
      lineBarsData: [
        if (!cardinal.loading) _lineChartBarData(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context);
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey[200], width: 1.0),
        ),
        padding: EdgeInsets.only(
          top: 16.0,
          left: 24.0,
          right: 8.0,
        ),
        height: screen.size.height / 3.0,
        child: LineChart(
          _lineChartData(context),
          swapAnimationDuration: const Duration(milliseconds: 250),
        ),
      ),
    );
  }
}
