import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/cardinal.dart';
import 'provider/conductor.dart';
import 'src/app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Cardinal()),
        ChangeNotifierProvider(create: (context) => Conductor()),
      ],
      child: App(),
    ),
  );
}
