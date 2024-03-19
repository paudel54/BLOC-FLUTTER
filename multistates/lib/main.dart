import 'package:flutter/material.dart';
import 'package:multistates/bloc/switch_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screen/Homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SwitchBloc(),
        ),
      ],
      child: const MaterialApp(
        title: 'Multi State BLOC',
        home: HomeScreen(),
      ),
    );
  }
}
