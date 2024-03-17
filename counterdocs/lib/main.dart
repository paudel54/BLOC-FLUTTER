import 'package:flutter/material.dart';
import 'counter_observer.dart';
import 'package:bloc/bloc.dart';
import 'app.dart';

void main() {
  Bloc.observer = const CounterObserver();
  runApp(const CounterApp());
}
