import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo_model.dart';
import '../providers/todo_provider.dart';
class TodoForm extends StatefulWidget {
  final Todo? todo;
  final int? index;

  const TodoForm({super.key, this.todo, this.index});

  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _titleController.text = widget.todo!.title;
      _descriptionController.text = widget.todo!.description;
      _selectedDate = widget.todo!.dateTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 30,
        left: 15,
        right: 15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: _selectedDate ?? DateTime.now(),
                firstDate: DateTime(2023),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                setState(() {
                  _selectedDate = pickedDate;
                });
              }
            },
            child: const Text('Select Date'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final newTodo = Todo(
                title: _titleController.text,
                description: _descriptionController.text,
                dateTime: _selectedDate,
              );

              if (widget.index == null) {
                Provider.of<TodoProvider>(context, listen: false).addTodo(newTodo);
              } else {
                Provider.of<TodoProvider>(context, listen: false)
                    .updateTodo(widget.index!, newTodo);
              }

              Navigator.of(context).pop();
            },
            child: const Text('Save Task'),
          ),
        ],
      ),
    );
  }
}