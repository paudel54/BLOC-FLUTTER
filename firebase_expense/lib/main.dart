import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'simple_bloc_observer.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDET6MnYQOUVauQTWr4zrM7ZNWDRH_iBUI",
      appId: "1:935283252848:android:a27fac6d584dfdef18deb5",
      messagingSenderId: "935283252848",
      projectId: "expense-tracker-5e973",
    ),
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}
