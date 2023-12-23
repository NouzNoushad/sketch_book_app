import 'package:flutter/material.dart';
import 'package:sketch_book_app/utils/colors.dart';

import 'features/presentation/sketch_home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorPicker.seedColor),
      ),
      debugShowCheckedModeBanner: false,
      home: const SketchHomeScreen(),
    );
  }
}
