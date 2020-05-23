import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/provider/cardinal.dart';

class TrackerTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      alignment: Alignment.center,
      height: kToolbarHeight,
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Consumer<Cardinal>(
        builder: (context, cardinal, child) => TextField(
          controller: cardinal.textEditingController,
          cursorColor: theme.accentColor,
          style: theme.textTheme.headline6.copyWith(fontSize: 15.0),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
            enabled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.grey[300]),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.5, color: theme.accentColor),
            ),
            hintText: 'Name of the tracker...',
            hintStyle: TextStyle(
              color: Colors.grey[300],
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          onChanged: cardinal.changeTitle,
        ),
      ),
    );
  }
}
