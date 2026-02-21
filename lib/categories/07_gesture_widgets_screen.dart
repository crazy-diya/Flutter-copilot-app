import 'package:flutter/material.dart';
import '../widgets/widget_card.dart';
import '../widgets/section_header.dart';

class GestureWidgetsScreen extends StatefulWidget {
  const GestureWidgetsScreen({super.key});

  @override
  State<GestureWidgetsScreen> createState() => _GestureWidgetsScreenState();
}

class _GestureWidgetsScreenState extends State<GestureWidgetsScreen> {
  String _gestureText = 'Try gestures!';
  String _pointerText = 'Pointer events';
  Color _hoverColor = Colors.blue.shade200;
  bool _absorb = false;
  bool _ignore = false;
  double _scrollOffset = 0;
  List<String> _items = List.generate(8, (i) => 'Item ${i + 1}');
  Offset _dragOffset = Offset.zero;
  bool _isDropped = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() => _scrollOffset = _scrollController.offset);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gesture Widgets'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF57C00), Color(0xFFFFB74D)],
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(title: 'Gesture Detection'),
          WidgetCard(
            title: 'GestureDetector',
            widgetName: 'GestureDetector',
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => setState(() => _gestureText = 'Tapped!'),
                  onDoubleTap: () => setState(() => _gestureText = 'Double Tapped!'),
                  onLongPress: () => setState(() => _gestureText = 'Long Pressed!'),
                  onPanUpdate: (d) => setState(() =>
                      _gestureText = 'Pan: (${d.delta.dx.toStringAsFixed(1)}, ${d.delta.dy.toStringAsFixed(1)})'),
                  child: Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange),
                    ),
                    child: Center(
                      child: Text(_gestureText, style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Tap, Double tap, Long press, or Pan'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'InkWell',
            widgetName: 'InkWell',
            child: Material(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: Text('Tap for Ripple Effect')),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'InkResponse',
            widgetName: 'InkResponse',
            child: Material(
              color: Colors.green.shade50,
              child: Center(
                child: InkResponse(
                  onTap: () {},
                  radius: 50,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.touch_app, size: 32),
                        Text('Custom Ripple'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Swipe & Drag'),
          WidgetCard(
            title: 'Dismissible',
            widgetName: 'Dismissible',
            child: SizedBox(
              height: 200,
              child: ListView(
                children: _items.map((item) => Dismissible(
                  key: Key(item),
                  onDismissed: (_) => setState(() => _items.remove(item)),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 16),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.blue,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.archive, color: Colors.white),
                  ),
                  child: ListTile(
                    title: Text(item),
                    subtitle: const Text('Swipe to dismiss'),
                  ),
                )).toList(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Draggable + DragTarget',
            widgetName: 'Draggable',
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Draggable<String>(
                      data: 'dragged-item',
                      feedback: Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Colors.deepPurple,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.star, color: Colors.white, size: 40),
                      ),
                      childWhenDragging: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                      ),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Colors.deepPurple,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.star, color: Colors.white, size: 40),
                      ),
                    ),
                    DragTarget<String>(
                      onAcceptWithDetails: (_) => setState(() => _isDropped = true),
                      builder: (ctx, candidates, rejected) => Container(
                        width: 100,
                        height: 80,
                        decoration: BoxDecoration(
                          color: candidates.isNotEmpty
                              ? Colors.green.shade200
                              : _isDropped
                                  ? Colors.green.shade300
                                  : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: Text(
                            _isDropped ? 'Dropped! ✓' : 'Drop here',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_isDropped)
                  TextButton(
                    onPressed: () => setState(() => _isDropped = false),
                    child: const Text('Reset'),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'LongPressDraggable',
            widgetName: 'LongPressDraggable',
            child: Center(
              child: LongPressDraggable<int>(
                data: 42,
                feedback: Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.drag_handle, color: Colors.white, size: 40),
                ),
                child: Container(
                  width: 100,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(child: Text('Long press\nto drag', textAlign: TextAlign.center)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Touch & Zoom'),
          WidgetCard(
            title: 'InteractiveViewer',
            widgetName: 'InteractiveViewer',
            child: SizedBox(
              height: 150,
              child: InteractiveViewer(
                child: Container(
                  color: Colors.teal.shade50,
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.pinch, size: 48, color: Colors.teal),
                        Text('Pinch to zoom!', style: TextStyle(fontSize: 16)),
                        Text('Also pan and rotate'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Listener',
            widgetName: 'Listener',
            child: Listener(
              onPointerDown: (e) => setState(() => _pointerText = 'Down at ${e.localPosition.dx.toStringAsFixed(0)}, ${e.localPosition.dy.toStringAsFixed(0)}'),
              onPointerUp: (e) => setState(() => _pointerText = 'Up'),
              onPointerMove: (e) => setState(() => _pointerText = 'Move: ${e.localPosition.dx.toStringAsFixed(0)}, ${e.localPosition.dy.toStringAsFixed(0)}'),
              child: Container(
                height: 80,
                color: Colors.purple.shade50,
                child: Center(child: Text(_pointerText)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'MouseRegion',
            widgetName: 'MouseRegion',
            child: MouseRegion(
              onEnter: (_) => setState(() => _hoverColor = Colors.green.shade300),
              onExit: (_) => setState(() => _hoverColor = Colors.blue.shade200),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 60,
                color: _hoverColor,
                child: const Center(child: Text('Hover over me! (Desktop/Web)')),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Pointer Interception'),
          WidgetCard(
            title: 'AbsorbPointer',
            widgetName: 'AbsorbPointer',
            child: Column(
              children: [
                AbsorbPointer(
                  absorbing: _absorb,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(_absorb ? 'I am disabled (AbsorbPointer)' : 'I am enabled'),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Switch(
                      value: _absorb,
                      onChanged: (v) => setState(() => _absorb = v),
                    ),
                    const Text('Enable AbsorbPointer'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'IgnorePointer',
            widgetName: 'IgnorePointer',
            child: Column(
              children: [
                IgnorePointer(
                  ignoring: _ignore,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(_ignore ? 'Ignored (IgnorePointer)' : 'Tappable'),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Switch(
                      value: _ignore,
                      onChanged: (v) => setState(() => _ignore = v),
                    ),
                    const Text('Enable IgnorePointer'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Scroll Control'),
          WidgetCard(
            title: 'ScrollController',
            widgetName: 'ScrollController',
            child: Column(
              children: [
                Text('Scroll offset: ${_scrollOffset.toStringAsFixed(0)}px'),
                const SizedBox(height: 8),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: 10,
                    itemBuilder: (ctx, i) => ListTile(title: Text('List item ${i + 1}')),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  ),
                  child: const Text('Scroll to Top'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'NotificationListener',
            widgetName: 'NotificationListener',
            child: _NotificationListenerDemo(),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _NotificationListenerDemo extends StatefulWidget {
  @override
  State<_NotificationListenerDemo> createState() =>
      _NotificationListenerDemoState();
}

class _NotificationListenerDemoState extends State<_NotificationListenerDemo> {
  double _offset = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Scroll offset: ${_offset.toStringAsFixed(0)}px'),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: NotificationListener<ScrollNotification>(
            onNotification: (n) {
              setState(() => _offset = n.metrics.pixels);
              return false;
            },
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (ctx, i) => ListTile(title: Text('Item ${i + 1}')),
            ),
          ),
        ),
      ],
    );
  }
}
