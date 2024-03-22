import 'package:expense_tracker/bloc/transaction_bloc.dart';
import 'package:expense_tracker/screens/home_page.dart';
import 'package:expense_tracker/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionBloc>(
      create: (context) => TransactionBloc()
        ..add(
          AppStarted(),
        ),
      child: const Homepage(),
    );
  }
}
