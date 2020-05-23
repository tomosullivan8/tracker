import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/cardinal.dart';

class Clear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      child: Text('Clear'),
      highlightedBorderColor: Colors.black,
      onPressed: () {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('This will reset all data...'),
            action: SnackBarAction(
              label: 'CLEAR',
              onPressed: context.read<Cardinal>().clear,
            ),
          ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }
}
