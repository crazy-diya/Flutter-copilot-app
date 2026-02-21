import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/widget_card.dart';
import '../widgets/section_header.dart';

// InheritedWidget demo
class _CounterData extends InheritedWidget {
  final int count;

  const _CounterData({required this.count, required super.child});

  static _CounterData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_CounterData>();

  @override
  bool updateShouldNotify(_CounterData old) => count != old.count;
}

// ChangeNotifier demo
class _CounterNotifier extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class StateWidgetsScreen extends StatefulWidget {
  const StateWidgetsScreen({super.key});

  @override
  State<StateWidgetsScreen> createState() => _StateWidgetsScreenState();
}

class _StateWidgetsScreenState extends State<StateWidgetsScreen>
    with SingleTickerProviderStateMixin {
  // StatefulWidget counter
  int _counter = 0;

  // InheritedWidget
  int _inheritedCount = 0;

  // ValueNotifier
  final ValueNotifier<int> _valueNotifier = ValueNotifier<int>(0);

  // StreamBuilder
  late StreamController<int> _streamController;
  int _streamValue = 0;

  // FutureBuilder
  late Future<String> _future;

  // ChangeNotifier
  final _CounterNotifier _notifier = _CounterNotifier();

  // AnimatedBuilder
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<int>.broadcast();
    _startStream();
    _future = _loadData();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  void _startStream() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      _streamValue++;
      if (!_streamController.isClosed) {
        _streamController.add(_streamValue);
      }
    });
  }

  Future<String> _loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'Data loaded successfully! ✓';
  }

  @override
  void dispose() {
    _streamController.close();
    _valueNotifier.dispose();
    _notifier.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State & Async'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFD32F2F), Color(0xFFE57373)],
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(title: 'State Management'),
          WidgetCard(
            title: 'StatefulWidget Counter',
            widgetName: 'StatefulWidget',
            child: Column(
              children: [
                Text('Count: $_counter',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => setState(() => _counter--),
                      child: const Icon(Icons.remove),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () => setState(() => _counter++),
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'InheritedWidget',
            widgetName: 'InheritedWidget',
            child: _CounterData(
              count: _inheritedCount,
              child: Column(
                children: [
                  Builder(
                    builder: (ctx) {
                      final data = _CounterData.of(ctx);
                      return Text(
                        'InheritedWidget count: ${data?.count ?? 0}',
                        style: const TextStyle(fontSize: 18),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => setState(() => _inheritedCount++),
                    child: const Text('Increment InheritedWidget'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'ValueListenableBuilder',
            widgetName: 'ValueListenableBuilder',
            child: Column(
              children: [
                ValueListenableBuilder<int>(
                  valueListenable: _valueNotifier,
                  builder: (ctx, value, child) => Text(
                    'ValueNotifier: $value',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => _valueNotifier.value++,
                  child: const Text('Increment ValueNotifier'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'ListenableBuilder',
            widgetName: 'ListenableBuilder',
            child: Column(
              children: [
                ListenableBuilder(
                  listenable: _notifier,
                  builder: (ctx, child) => Text(
                    'ChangeNotifier: ${_notifier.count}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _notifier.increment,
                  child: const Text('Increment ChangeNotifier'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Async Builders'),
          WidgetCard(
            title: 'StreamBuilder',
            widgetName: 'StreamBuilder',
            child: StreamBuilder<int>(
              stream: _streamController.stream,
              builder: (ctx, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                return Column(
                  children: [
                    const Icon(Icons.timer, size: 40, color: Colors.red),
                    Text(
                      '${snapshot.data}s',
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const Text('Live timer via StreamBuilder'),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'FutureBuilder',
            widgetName: 'FutureBuilder',
            child: FutureBuilder<String>(
              future: _future,
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 12),
                      Text('Loading data...'),
                    ],
                  );
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red));
                }
                return Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green, size: 32),
                    const SizedBox(width: 12),
                    Expanded(child: Text(snapshot.data ?? '')),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Animation Builders'),
          WidgetCard(
            title: 'AnimatedBuilder (state demo)',
            widgetName: 'AnimatedBuilder',
            child: AnimatedBuilder(
              animation: _animController,
              builder: (ctx, child) => Transform.rotate(
                angle: _animController.value * 6.28,
                child: child,
              ),
              child: const Icon(Icons.refresh, size: 64, color: Colors.red),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Builder',
            widgetName: 'Builder',
            child: Builder(
              builder: (ctx) => ElevatedButton(
                onPressed: () => ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(content: Text('Correct context via Builder!')),
                ),
                child: const Text('Show SnackBar via Builder'),
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
