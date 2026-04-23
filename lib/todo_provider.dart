import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/todo_model.dart';

class TodoNotifier extends Notifier<List<Todo>> {
  @override
  List<Todo> build() {
    return [];
  }

void addTodo (Todo todo){
  state = [...state, todo];
}

void removeTodo (int index){
  state = state.where((element) => state.indexOf(element) != index).toList();
}

void toogledTodo (int index){
  state = [
    for(int i = 0; i < state.length; i++)
    if(i == index)
    state[i].copywith(completed: !state[i].completed)
    else
    state[i]
  ];
}
}

final todoNotifierProvider = NotifierProvider<TodoNotifier, List<Todo>>(
  () => TodoNotifier()
);