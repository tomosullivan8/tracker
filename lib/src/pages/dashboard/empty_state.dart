import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String image =
      'https://image.freepik.com/free-vector/data-report-illustration-concept_114360-883.jpg';

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Stack(
      children: [
        Container(
          height: screen.size.height,
          width: screen.size.width,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/data_report.jpg'),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        SafeArea(
          child: Container(
            alignment: Alignment.center,
            height: kToolbarHeight,
            child: Text(
              'Get tracking!',
              style: theme.textTheme.headline6,
            ),
          ),
        ),
      ],
    );
  }
}
