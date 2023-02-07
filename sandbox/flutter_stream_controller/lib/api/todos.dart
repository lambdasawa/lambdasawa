// To parse this JSON data, do
//
//     final todos = todosFromJson(jsonString);

import 'dart:convert';

Todos todosFromJson(String str) => Todos.fromJson(json.decode(str));

String todosToJson(Todos data) => json.encode(data.toJson());

class Todos {
    Todos({
        required this.todos,
        required this.total,
        required this.skip,
        required this.limit,
    });

    List<Todo> todos;
    int total;
    int skip;
    int limit;

    factory Todos.fromJson(Map<String, dynamic> json) => Todos(
        todos: List<Todo>.from(json["todos"].map((x) => Todo.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "todos": List<dynamic>.from(todos.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
    };
}

class Todo {
    Todo({
        required this.id,
        required this.todo,
        required this.completed,
        required this.userId,
    });

    int id;
    String todo;
    bool completed;
    int userId;

    factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        todo: json["todo"],
        completed: json["completed"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "todo": todo,
        "completed": completed,
        "userId": userId,
    };
}
