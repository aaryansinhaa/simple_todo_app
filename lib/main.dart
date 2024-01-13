import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('To-Do List'),
        ),
        body: const TodoScreen(),
      ),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<String> todos = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TodoInput(onSubmit: addTodo),
        TodoList(todos: todos, onDelete: deleteTodo),
      ],
    );
  }

  void addTodo(String todo) {
    setState(() {
      todos.add(todo);
    });
  }

  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }
}

class TodoInput extends StatelessWidget {
  final Function onSubmit;

  const TodoInput({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Enter your to-do...',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              onSubmit(controller.text);
              controller.clear();
            },
          ),
        ],
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  final List<String> todos;
  final Function onDelete;

  const TodoList({super.key, required this.todos, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index]),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                onDelete(index);
              },
            ),
          );
        },
      ),
    );
  }
}
