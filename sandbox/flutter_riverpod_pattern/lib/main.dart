import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      home: ProviderScope(child: MyHomePage()),
    );
  }
}

@immutable
class CounterState {
  final int counter;

  const CounterState({
    this.counter = 0,
  });
}

class CounterStateNotifier extends StateNotifier<CounterState> {
  CounterStateNotifier(super.state);

  void increment() {
    state = CounterState(counter: state.counter + 1);
  }
}

final counterProvider =
    StateNotifierProvider<CounterStateNotifier, CounterState>((ref) {
  return CounterStateNotifier(const CounterState());
});

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Riverpod Pattern")),
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

class MyText extends ConsumerWidget {
  const MyText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(counterProvider);

    return Text("${state.counter}");
  }
}

class MyButton extends ConsumerWidget {
  const MyButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(counterProvider.notifier);

    return ElevatedButton(
        onPressed: () {
          notifier.increment();
        },
        child: const Text("increment"),
    );
  }
}
