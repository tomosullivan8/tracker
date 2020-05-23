import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeText extends StatefulWidget {
  DateTimeText({this.style});

  final TextStyle style;

  @override
  _DateTimeTextState createState() => _DateTimeTextState();
}

class _DateTimeTextState extends State<DateTimeText> {
  @override
  void initState() {
    _timer();
    super.initState();
  }

  void _timer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          DateFormat('EEEE, d MMMM').format(DateTime.now()),
          style: widget.style ?? TextStyle(),
        ),
        Text(
          ' | ',
          style: TextStyle(color: widget.style.color),
        ),
        Text(
          DateFormat('H:mm').format(DateTime.now()),
          style: widget.style ?? TextStyle(),
        ),
      ],
    );
  }
}
