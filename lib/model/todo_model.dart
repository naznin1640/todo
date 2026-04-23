
import 'package:flutter/cupertino.dart';

@immutable
class Todo {
  final String title;
  final bool completed;

const Todo({
  required this.title,
  required this.completed
});


Todo copywith({
  String? title,
  bool? completed,
}) {
  return Todo(
    title: title?? this.title, 
    completed: completed ?? this.completed);
}
}