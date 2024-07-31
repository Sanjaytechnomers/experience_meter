import 'package:experience_meter/experience_meter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meter Painter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meter Painter Demo'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 150,
          child: CustomPaint(
            painter: ExperienceMeter(
              value: 75,
              centerText: '75',
            ),
          ),
        ),
      ),
    );
  }
}
