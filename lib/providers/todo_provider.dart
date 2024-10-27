import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/todo_model.dart';

class TodoProvider with ChangeNotifier {
  Box<Todo>? _todoBox = Hive.box<Todo>('todos'); // Объявляем коробку типа Todo

  List<Todo> _todos = [];
  bool _isLoading = true;

  List<Todo> get todos => _todos;

  bool get isLoading => _isLoading;

  TodoProvider() {
    _initHive(); // Инициализация Hive при создании провайдера
  }

  // Инициализация Hive и загрузка данных
  Future<void> _initHive() async {
    // Открываем коробку, если она еще не открыта
    _todoBox = await Hive.openBox<Todo>('todo_box');
    _loadTodos(); // Загружаем задачи после открытия коробки
  }

  // Загрузка данных из коробки Hive
  void _loadTodos() {
    // Проверяем, что коробка открыта, прежде чем работать с ней
    if (_todoBox != null) {
      _todos = _todoBox!.values.toList(); // Получаем список задач из коробки
      _isLoading = false;
      notifyListeners(); // Уведомляем слушателей о том, что данные изменились
    }
  }

  // Добавление новой задачи
  Future<void> addTodo(Todo todo) async {
    if (_todoBox != null) {
      await _todoBox!.add(todo); // Добавляем задачу в коробку
      _loadTodos(); // Обновляем локальный список задач
    }
  }

  // Обновление существующей задачи
  Future<void> updateTodo(int index, Todo todo) async {
    if (_todoBox != null) {
      await _todoBox!.putAt(index, todo); // Обновляем задачу по индексу
      _loadTodos(); // Обновляем локальный список задач
    }
  }

  // Удаление задачи по индексу
  Future<void> deleteTodoAt(int index) async {
    if (_todoBox != null) {
      await _todoBox!.deleteAt(index); // Удаляем задачу по индексу
      _loadTodos(); // Обновляем локальный список задач
    }
  }
}
