import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/todo_model.dart';
import 'package:todos/todo_provider.dart';

class TodoHome extends ConsumerWidget {
  const TodoHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todoProvider = ref.watch(todoNotifierProvider);
    final TextEditingController todoTextController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Todo App"),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                if (!context.mounted) return;
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              });
            },
            icon: Icon(Icons.logout_sharp),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: todoProvider.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todoProvider[index].title),
            leading: Checkbox(
              value: todoProvider[index].completed,
              onChanged: (value) {
                ref.read(todoNotifierProvider.notifier).toogledTodo(index);
              },
            ),
            trailing: Visibility(
              visible: todoProvider[index].completed,
              child: IconButton(
                onPressed: () {
                  ref.read(todoNotifierProvider.notifier).removeTodo(index);
                },
                icon: Icon(Icons.delete),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Add Todo"),
              content: TextField(
                controller: todoTextController,
                decoration: InputDecoration(hint: Text("Enter todo")),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    final todo = Todo(
                      title: todoTextController.text,
                      completed: false,
                    );
                    ref.read(todoNotifierProvider.notifier).addTodo(todo);
                    Navigator.pop(context);
                  },
                  child: Text("Add"),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
