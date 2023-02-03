import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: MyInheritedWidget(
          count: _counter,
          child: const Message(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Message extends StatelessWidget {
  const Message({super.key});

  @override
  Widget build(BuildContext context) {
  return  Text(
      '${MyInheritedWidget.of(context).count}',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  const MyInheritedWidget({
    Key? key,
    required Widget child,
    required this.count,
  }) : super(key: key, child: child);

  final int count;

  static MyInheritedWidget of(BuildContext context, {bool listen = true}) {
    return listen ?
    (context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>())! :
    (context
        .getElementForInheritedWidgetOfExactType<MyInheritedWidget>()!
        .widget as MyInheritedWidget);
  }

  @override
  bool updateShouldNotify(covariant MyInheritedWidget oldWidget) {
    return true;
  }
}
