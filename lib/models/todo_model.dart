import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 0) // Каждый тип данных должен иметь уникальный идентификатор
class Todo {
  @HiveField(1) // Поле для хранения заголовка
  final String title;

  @HiveField(2) // Поле для хранения описания
  final String description;

  @HiveField(3) // Поле для хранения времени
  final DateTime? dateTime;

  Todo({
    required this.title,
    required this.description,
    required this.dateTime,
  });
}

  