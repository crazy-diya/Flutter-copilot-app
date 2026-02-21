import 'package:flutter/material.dart';
import '../widgets/widget_card.dart';
import '../widgets/section_header.dart';

class UtilityWidgetsScreen extends StatefulWidget {
  const UtilityWidgetsScreen({super.key});

  @override
  State<UtilityWidgetsScreen> createState() => _UtilityWidgetsScreenState();
}

class _UtilityWidgetsScreenState extends State<UtilityWidgetsScreen> {
  final ScrollController _scrollbarController = ScrollController();

  @override
  void dispose() {
    _scrollbarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Utility Widgets'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF5D4037), Color(0xFFA1887F)],
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(title: 'Builder Widgets'),
          WidgetCard(
            title: 'Builder',
            widgetName: 'Builder',
            child: Builder(
              builder: (ctx) => ElevatedButton(
                onPressed: () => ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(content: Text('Context-correct SnackBar!')),
                ),
                child: const Text('Show SnackBar (Builder)'),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'StatefulBuilder',
            widgetName: 'StatefulBuilder',
            child: ElevatedButton(
              onPressed: () {
                int count = 0;
                showDialog(
                  context: context,
                  builder: (ctx) => StatefulBuilder(
                    builder: (ctx2, setDialogState) => AlertDialog(
                      title: const Text('StatefulBuilder Dialog'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Count: $count',
                              style: const TextStyle(fontSize: 20)),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () =>
                                setDialogState(() => count++),
                            child: const Text('Increment'),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx2),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: const Text('Open Dialog with StatefulBuilder'),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'OrientationBuilder',
            widgetName: 'OrientationBuilder',
            child: OrientationBuilder(
              builder: (ctx, orientation) => Container(
                padding: const EdgeInsets.all(16),
                color: orientation == Orientation.portrait
                    ? Colors.blue.shade100
                    : Colors.green.shade100,
                child: Text(
                  'Orientation: ${orientation.name.toUpperCase()}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Device Info'),
          WidgetCard(
            title: 'MediaQuery',
            widgetName: 'MediaQuery',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Screen: ${mq.size.width.toStringAsFixed(0)} × ${mq.size.height.toStringAsFixed(0)}'),
                Text('Pixel ratio: ${mq.devicePixelRatio.toStringAsFixed(1)}'),
                Text('Text scale: ${mq.textScaler.scale(1.0).toStringAsFixed(2)}'),
                Text('Padding: ${mq.padding}'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Theming & Direction'),
          WidgetCard(
            title: 'Theme Override',
            widgetName: 'Theme',
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context)
                    .colorScheme
                    .copyWith(primary: Colors.orange),
              ),
              child: Builder(
                builder: (ctx) => ElevatedButton(
                  onPressed: () {},
                  child: const Text('Locally Orange Button'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Directionality',
            widgetName: 'Directionality',
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.purple.shade50,
                child: const Row(
                  children: [
                    Icon(Icons.arrow_forward),
                    SizedBox(width: 8),
                    Text('RTL text direction (right to left)'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Accessibility'),
          WidgetCard(
            title: 'Semantics',
            widgetName: 'Semantics',
            child: Semantics(
              label: 'This is a semantic label for screen readers',
              button: true,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue),
                ),
                child: const Text('Semantics: labeled for accessibility'),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'MergeSemantics',
            widgetName: 'MergeSemantics',
            child: MergeSemantics(
              child: Row(
                children: [
                  const Icon(Icons.favorite, color: Colors.red),
                  const SizedBox(width: 8),
                  const Text('Liked (merged into one semantic node)'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'ExcludeSemantics',
            widgetName: 'ExcludeSemantics',
            child: ExcludeSemantics(
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.grey.shade200,
                child: const Text('This text is excluded from accessibility tree'),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Overflow & Sizing'),
          WidgetCard(
            title: 'OverflowBox',
            widgetName: 'OverflowBox',
            child: SizedBox(
              height: 60,
              child: OverflowBox(
                maxWidth: 320,
                child: Container(
                  width: 300,
                  height: 50,
                  color: Colors.orange.shade200,
                  child: const Center(child: Text('OverflowBox: wider than parent')),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'UnconstrainedBox',
            widgetName: 'UnconstrainedBox',
            child: UnconstrainedBox(
              child: Container(
                width: 300,
                height: 50,
                color: Colors.teal.shade200,
                child: const Center(child: Text('UnconstrainedBox sizing')),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'KeyedSubtree',
            widgetName: 'KeyedSubtree',
            child: KeyedSubtree(
              key: const ValueKey('keyed-subtree'),
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.purple.shade100,
                child: const Text('KeyedSubtree with ValueKey'),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Text & Scroll'),
          WidgetCard(
            title: 'Scrollbar',
            widgetName: 'Scrollbar',
            child: SizedBox(
              height: 100,
              child: Scrollbar(
                controller: _scrollbarController,
                thumbVisibility: true,
                child: ListView.builder(
                  controller: _scrollbarController,
                  itemCount: 10,
                  itemBuilder: (ctx, i) => ListTile(title: Text('Scrollbar item ${i + 1}')),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'SelectableText',
            widgetName: 'SelectableText',
            child: const SelectableText(
              'This text can be selected and copied!',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Baseline',
            widgetName: 'Baseline',
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                const Text('Small', style: TextStyle(fontSize: 14)),
                const SizedBox(width: 8),
                const Text('Medium', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                const Text('Large', style: TextStyle(fontSize: 28)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'FractionallySizedBox',
            widgetName: 'FractionallySizedBox',
            child: Align(
              child: FractionallySizedBox(
                widthFactor: 0.7,
                child: Container(
                  height: 40,
                  color: Colors.brown.shade300,
                  child: const Center(
                    child: Text('70% of parent', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'NotificationListener (custom)',
            widgetName: 'NotificationListener',
            child: _CustomNotificationDemo(),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _CustomNotification extends Notification {
  final String message;
  const _CustomNotification(this.message);
}

class _CustomNotificationDemo extends StatefulWidget {
  @override
  State<_CustomNotificationDemo> createState() =>
      _CustomNotificationDemoState();
}

class _CustomNotificationDemoState extends State<_CustomNotificationDemo> {
  String _notification = 'No notification yet';

  @override
  Widget build(BuildContext context) {
    return NotificationListener<_CustomNotification>(
      onNotification: (n) {
        setState(() => _notification = n.message);
        return true;
      },
      child: Column(
        children: [
          Text(_notification),
          const SizedBox(height: 8),
          Builder(
            builder: (ctx) => ElevatedButton(
              onPressed: () => const _CustomNotification('Custom notification fired!')
                  .dispatch(ctx),
              child: const Text('Fire Notification'),
            ),
          ),
        ],
      ),
    );
  }
}
