import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_cubit_database/Database/database.dart';
import 'package:todo_app_cubit_database/Screens/todo_view.dart';
import 'package:todo_app_cubit_database/cubit/task_cubit.dart';

void main() {
  runApp(
    
    
    BlocProvider(
      create: (_) => TaskCubit(db: DatabaseHelper.instance), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const ToDo_Screen(),
    );
  }
}
