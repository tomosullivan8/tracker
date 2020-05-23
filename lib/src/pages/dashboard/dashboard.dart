import 'package:flutter/material.dart';
import 'package:tracker/provider/cardinal.dart';
import 'package:tracker/src/pages/dashboard/chart.dart';
import 'package:provider/provider.dart';
import 'package:tracker/src/pages/dashboard/empty_state.dart';

class Dashboard extends StatelessWidget {
  Widget _buildDashboard(context, cardinal) {
    final screen = MediaQuery.of(context);
    final theme = Theme.of(context);
//    Cardinal cardinal = context.watch<Cardinal>();
    int total = cardinal.items.fold(
      0,
      (j, i) => i.items.fold(0, (j, i) => (i.item + j)) + j,
    );
    return Material(
      color: theme.scaffoldBackgroundColor,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              alignment: Alignment.center,
              height: kToolbarHeight * 2,
              margin: EdgeInsets.only(top: screen.padding.top),
              child: Text(
                '$total',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Chart(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cardinal>(
      builder: (context, cardinal, child) {
        switch (cardinal.items.isEmpty) {
          case true:
            return EmptyState();
          case false:
            return _buildDashboard(context, cardinal);
          default:
            return EmptyState();
        }
      },
    );
  }
}
