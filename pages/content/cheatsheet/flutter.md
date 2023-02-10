---
title: Flutter
---


## Dart

- [DartPad](https://dartpad.dev)
- [A tour of the Dart language](https://dart.dev/guides/language/language-tour)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)

## Flutter

- [Flutter documentation | Flutter](https://docs.flutter.dev/)
- [Cookbook | Flutter](https://docs.flutter.dev/cookbook)
- [pub.dev](https://pub.dev/packages?q=is%3Aflutter-favorite)
- [Flutterの効率良い学び方](https://medium.com/flutter-jp/flutter-learning-c5640c5f05b9)
- [Flutter実践入門](https://zenn.dev/kazutxt/books/flutter_practice_introduction/)
- [/Solido/awesome-flutter](https://github.com/Solido/awesome-flutter)
- [flutterawesome.com](https://flutterawesome.com)
- [Tips](https://github.com/erluxman/awesomefluttertips)
- [Roadmap](https://github.com/olexale/flutter_roadmap)

## example 集

- [flutter.github.io/samples](https://flutter.github.io/samples)
- [gallery.flutter.dev](https://gallery.flutter.dev)
- [flutter/gallery](https://github.com/flutter/gallery)
- [flutter/samples](https://github.com/flutter/samples)
- [itsallwidgets.com](https://itsallwidgets.com/)
- [nisrulz/flutter-examples](https://github.com/nisrulz/flutter-examples)

## オープンソースのアプリケーション

- <https://github.com/TheAlphamerc/flutter_twitter_clone>
- <https://github.com/burhanrashid52/WhatTodo>
- <https://github.com/GeekyAnts/flutter-login-home-animation>
- <https://github.com/yumemi-inc/flutter-training-template>

## レイアウト

- [Layouts in Flutter | Flutter](https://docs.flutter.dev/development/ui/layout)
- [FlutterのBoxConstraintsを理解する](https://itome.team/blog/2019/12/flutter-advent-calendar-day9/)

## ナビゲーション

- [Navigation | Flutter](https://docs.flutter.dev/cookbook/navigation)
- [Navigator class - widgets library - Dart API](https://api.flutter.dev/flutter/widgets/Navigator-class.html)
- [FlutterのNavigationとRoutingを理解する](https://itome.team/blog/2019/12/flutter-advent-calendar-day10/)

## i18n

- [Internationalizing Flutter apps | Flutter](https://docs.flutter.dev/development/accessibility-and-localization/internationalization#localizing-for-ios-updating-the-ios-app-bundle)

## 状態管理

- [【2021年版】Flutterの状態管理パターン総まとめ](https://qiita.com/datake914/items/f91acf30a640447c57c8)
- [Flutterの状態管理手法の選定](https://medium.com/flutter-jp/state-1daa7fd66b94)
- [Flutter状態管理フローチャートを書いた(　´･‿･｀)](https://twitter.com/_mono/status/1170516947970097152)

## Inside Flutter

- [Inside Flutter | Flutter](https://docs.flutter.dev/resources/inside-flutter)
- [Flutter の Widget ツリーの裏側で起こっていること](https://medium.com/flutter-jp/dive-into-flutter-4add38741d07)
- [Stateful Widget のパフォーマンスを考慮した正しい扱い方](https://medium.com/flutter-jp/state-performance-7a5f67d62edd)
- [【Flutter】Navigator.of(context) から理解する 3つのツリー](https://zenn.dev/chooyan/articles/77a2ba6b02dd4f)

## stateful widget

```dart
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

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
      appBar: AppBar(),
      body: Text('$_counter'),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
      ),
    );
  }
}
```

## InheritedWidget

- [InheritedWidget/InheritedModelとは何か - Qiita](https://qiita.com/ko2ic/items/d7b744f19f213ef1e647)
- [【Flutter】InheritedWidget とは何か](https://zenn.dev/chooyan/articles/bd8b5990eb210f)
- [InheritedWidget を完全に理解する 🎯](https://medium.com/flutter-jp/inherited-widget-37495200d965)

## ChangeNotifier

- [ChangeNotifier class - foundation library - Dart API](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html)

```dart
class Counter {
  int value = 0;
}

class CounterNotifier extends ChangeNotifier {
  Counter counter = Counter();

  void increment() {
    counter.value++;
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final counterNotifier = CounterNotifier();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AnimatedBuilder(
        animation: counterNotifier,
        builder: (BuildContext context, Widget? child) {
          return Text('${counterNotifier.counter.value}');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterNotifier.increment,
      ),
    );
  }
}
```

## ValueNotifier

- [ValueNotifier class - foundation library - Dart API](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html)
- [ValueNotifierを使うメリットとその使い方 - Qiita](https://qiita.com/tetsufe/items/87c37f713309fb4b0e91)

```dart
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final counterNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AnimatedBuilder(
        animation: counterNotifier,
        builder: (BuildContext context, Widget? child) {
          return Text('${counterNotifier.value}');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counterNotifier.value++,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

## Provider

- [provider | Flutter Package](https://pub.dev/packages/provider)
- [FlutterのProviderパッケージを使いこなす](https://itome.team/blog/2019/12/flutter-advent-calendar-day7/)

## StateNotifier

- [flutter_state_notifier | Flutter Package](https://pub.dev/packages/flutter_state_notifier)

`provider` + `flutter_state_notifier`:

```dart
import 'package:provider/provider.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';

@immutable
class Counter {
  final int value;

  const Counter({this.value = 0});
}

class CounterNotifier extends StateNotifier<Counter> {
  CounterNotifier() : super(const Counter());

  void increment() {
    state = Counter(value: state.value + 1);
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<CounterNotifier, Counter>(
      create: (_) => CounterNotifier(),
      child: Builder(
        builder: (context) {
          final counter = Provider.of<Counter>(context);

          final counterNotifier = Provider.of<CounterNotifier>(context);

          return Scaffold(
            appBar: AppBar(),
            body: Text("${counter.value}"),
            floatingActionButton: FloatingActionButton(
              onPressed: counterNotifier.increment,
            ),
          );
        },
      ),
    );
  }
}
```

## Riverpod

- [Getting started | Riverpod](https://riverpod.dev/docs/getting_started)

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

@immutable
class Counter {
  final int value;

  const Counter({this.value = 0});
}

class CounterNotifier extends StateNotifier<Counter> {
  CounterNotifier() : super(const Counter());

  void increment() {
    state = Counter(value: state.value + 1);
  }
}

final counterProvider =
    StateNotifierProvider<CounterNotifier, Counter>((ref) => CounterNotifier());

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);

    final counterNotifier = ref.watch(counterProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: Text("${counter.value}"),
      floatingActionButton: FloatingActionButton(
        onPressed: counterNotifier.increment,
      ),
    );
  }
}
```

## BLoC

- [長めだけどたぶんわかりやすいBLoCパターンの解説 - Qiita](https://qiita.com/kabochapo/items/8738223894fb74f952d3)
