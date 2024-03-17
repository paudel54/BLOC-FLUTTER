import 'package:flutter/material.dart';
import 'counter/view/counter_page.dart';

/// A [MaterialApp] which sets the `home` to [CounterPage].
class CounterApp extends MaterialApp {
  /// {@macro counter_app}
  const CounterApp({super.key}) : super(home: const CounterPage());
}
