import 'package:flutter_riverpod/legacy.dart';
import 'package:todos/model/todo_model.dart';

class TodNotifier extends StateNotifier<List<Todo>> {
  TodNotifier(): super([]);

  void addTodo(Todo todo){
    state = [...state, todo];
  }

  void removeTodo(int index){
    state = [
      for(int i = 0; i < state.length; i++)
      if(i != index) state[i]
    ];
  }
  void toggleTodo(int index){
    state = [
      for(int i = 0; i< state.length; i++)
      if(i == index)
      state[i].copywith(completed: !state[i].completed)
      else
      state[i]
    ];
  }
}
  final todoNotifierProvider =  
  StateNotifierProvider<TodNotifier, List<Todo>>((ref) => TodNotifier());
  
