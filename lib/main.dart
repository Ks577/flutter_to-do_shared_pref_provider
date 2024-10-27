import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/providers/todo_provider.dart';
import 'package:simple_todo_app/screens/todo_list_screen.dart';


import 'models/todo_model.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(
    TodoAdapter(),
  );
  await Hive.openBox<Todo>('todos');

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
