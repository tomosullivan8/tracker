import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/provider/cardinal.dart';
import 'package:tracker/src/pages/settings/clear.dart';
import 'package:tracker/src/pages/settings/credit.dart';
import 'package:tracker/src/pages/settings/image.dart';
import 'package:tracker/src/pages/settings/title.dart';
import 'package:tracker/src/pages/settings/values.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Material(
      color: theme.scaffoldBackgroundColor,
      child: Container(
        height: screen.size.height,
        padding: EdgeInsets.only(
          top: screen.padding.top + 16.0,
          bottom: kBottomNavigationBarHeight + 16.0,
        ),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                TrackerImage(),
                TrackerTitle(),
                TrackerValues(),
                Spacer(),
                Clear(),
              ],
            ),
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: Credit(),
            )
          ],
        ),
      ),
    );
  }
}
