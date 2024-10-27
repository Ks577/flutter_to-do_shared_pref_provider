import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/widgets/todo_form.dart';
import '../const/text_style.dart';
import '../providers/todo_provider.dart';
import 'package:intl/intl.dart';
class TodoListView extends StatelessWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        final todos = todoProvider.todos;

        if (todos.isEmpty) {
          return Center(
            child: Text(
              'No tasks available',
              style: TextStyle(color: textColor, fontSize: 18),
            ),
          );
        }

        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            final formattedDateTime = todo.dateTime != null
                ? DateFormat('yyyy-MM-dd HH:mm').format(todo.dateTime!)
                : 'No Date';
            return Card(
              color: Colors.white70,
              margin: const EdgeInsets.all(5),
              child: ListTile(
                title: Text(todo.title),
                subtitle: Text(todo.description),
                leading: Text(formattedDateTime),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    todoProvider.deleteTodoAt(index);
                  },
                ),
                onTap: () {
                  // Показать форму редактирования
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) {
                      return TodoForm(
                          todo:
                              todo); // Передаем существующий todo для редактирования
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
