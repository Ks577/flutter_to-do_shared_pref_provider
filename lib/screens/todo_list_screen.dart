import 'package:flutter/material.dart';
import 'package:simple_todo_app/const/colors.dart';
import 'dart:core';
import '../widgets/todo_form.dart';
import '../widgets/todo_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: backgroundColors,
          ),
        ),
        title: const Text(
          'To-Do List',
          style: TextStyle(color: Colors.white, fontSize: 35),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: backgroundColors,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 10),
              Expanded(child: TodoListView(),),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) {
              return TodoForm();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}