import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final helloWorldProvider = StateProvider(
  (_) => DateTime.now().toIso8601String(),
);

final summaryHelloWorldProvider = Provider((ref) {
  return ref.watch(helloWorldProvider).split("T")[1];
});

final greetingProvider = Provider.family<String, String>((ref, id) {
  return "Hello, $id";
});

final worldTimeProvider = FutureProvider((ref) async {
  final res = await http
      .get(Uri.parse("https://worldtimeapi.org/api/timezone/Asia/Tokyo"));
  return res.body;
});

@immutable
class Counter {
  final int counter;

  const Counter({
    this.counter = 0,
  });
}

class CounterNotifier extends StateNotifier<Counter> {
  CounterNotifier(super.state);

  void increment() {
    state = Counter(counter: state.counter + 1);
  }
}

final counterProvider = StateNotifierProvider<CounterNotifier, Counter>(
  (ref) => CounterNotifier(const Counter()),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final helloWorld = ref.watch(helloWorldProvider);

    final summaryHelloWorld = ref.watch(summaryHelloWorldProvider);

    final worldTime = ref.watch(worldTimeProvider);

    final greet = ref.watch(greetingProvider("lambdasawa"));

    final counter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Riverpod Example"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Expanded(child: Text(helloWorld)),
              ElevatedButton(
                onPressed: () {
                  final controller = ref.read(helloWorldProvider.notifier);
                  controller.state = DateTime.now().toIso8601String();
                },
                child: const Text("Update"),
              ),
            ],
          ),
          Text(summaryHelloWorld),
          Text(greet),
          Row(
            children: [
              worldTime.when(
                data: (data) => Expanded(child: Text(data)),
                error: (err, stack) => Text("Error: $err"),
                loading: () => const CircularProgressIndicator(),
              ),
              ElevatedButton(
                onPressed: () => ref.refresh(worldTimeProvider),
                child: const Text("Update"),
              ),
            ],
          ),
          Text(counter.counter.toString()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          ref.read(counterProvider.notifier).increment();
        },
      ),
    );
  }
}
