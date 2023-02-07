import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_stream_controller/api/todos.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final todoStreamController = StreamController<List<Todo>>();

  Future<void> callAPI() async {
    final response = await http.get(Uri.parse("https://dummyjson.com/todos"));
    final todo = todosFromJson(response.body);

    todoStreamController.sink.add(todo.todos);
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    callAPI();

    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Demo Home Page")),
      body: Center(
        child: Column(
          children:  [
            const Text('huge'),
            StreamBuilder<List<Todo>>(
              stream: todoStreamController.stream,
              builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
                if (snapshot.hasError) {
                  return Text("error: ${snapshot.error}");
                }

                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                return Text(snapshot.data?.map((e) => e.todo).join(",") ?? "empty");
              },
            )
          ],
        ),
      ),
    );
  }

}
