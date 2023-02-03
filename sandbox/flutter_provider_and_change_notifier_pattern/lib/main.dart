import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      home: ChangeNotifierProvider<Counter>(
        create: (context) => Counter(),
        child:  const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Provider Pattern"),
      ),
      body: Center(
        child: Column(
          children: const <Widget>[
            MyText(),
            MyButton(),
          ],
        ),
      ),
    );
  }
}

class Counter extends ChangeNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }
}

class MyText extends StatelessWidget {
  const MyText({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<Counter>(context);

    return Text("${state.counter}");
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<Counter>(context);

    return ElevatedButton(
        onPressed: () {
          state.increment();
        },
        child: const Text("Increment"),
    );
  }
}