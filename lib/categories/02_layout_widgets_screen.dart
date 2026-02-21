import 'package:flutter/material.dart';
import '../widgets/widget_card.dart';
import '../widgets/section_header.dart';

class LayoutWidgetsScreen extends StatefulWidget {
  const LayoutWidgetsScreen({super.key});

  @override
  State<LayoutWidgetsScreen> createState() => _LayoutWidgetsScreenState();
}

class _LayoutWidgetsScreenState extends State<LayoutWidgetsScreen> {
  int _indexedStackIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout Widgets'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF303F9F), Color(0xFF7986CB)],
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(title: 'Row & Column'),
          WidgetCard(
            title: 'Row',
            widgetName: 'Row',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(width: 60, height: 60, color: Colors.red.shade300,
                    child: const Center(child: Text('1', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                Container(width: 60, height: 60, color: Colors.green.shade300,
                    child: const Center(child: Text('2', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                Container(width: 60, height: 60, color: Colors.blue.shade300,
                    child: const Center(child: Text('3', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Column',
            widgetName: 'Column',
            child: Column(
              children: [
                Container(width: double.infinity, height: 40, color: Colors.red.shade300,
                    child: const Center(child: Text('1', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                const SizedBox(height: 4),
                Container(width: double.infinity, height: 40, color: Colors.green.shade300,
                    child: const Center(child: Text('2', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                const SizedBox(height: 4),
                Container(width: double.infinity, height: 40, color: Colors.blue.shade300,
                    child: const Center(child: Text('3', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Stack + Positioned',
            widgetName: 'Stack',
            child: SizedBox(
              height: 120,
              child: Stack(
                children: [
                  Container(width: 100, height: 100, color: Colors.blue.shade200),
                  const Positioned(
                    left: 30,
                    top: 30,
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: ColoredBox(color: Colors.green),
                    ),
                  ),
                  const Positioned(
                    left: 60,
                    top: 60,
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: ColoredBox(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Wrap',
            widgetName: 'Wrap',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                8,
                (i) => Chip(label: Text('Chip ${i + 1}')),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Flex',
            widgetName: 'Flex',
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(height: 40, color: Colors.purple.shade300,
                      child: const Center(child: Text('flex:2', style: TextStyle(color: Colors.white)))),
                ),
                const SizedBox(width: 4),
                Flexible(
                  flex: 1,
                  child: Container(height: 40, color: Colors.orange.shade300,
                      child: const Center(child: Text('flex:1', style: TextStyle(color: Colors.white)))),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Expanded',
            widgetName: 'Expanded',
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(height: 40, color: Colors.teal.shade300,
                      child: const Center(child: Text('flex:2', style: TextStyle(color: Colors.white)))),
                ),
                const SizedBox(width: 4),
                Expanded(
                  flex: 1,
                  child: Container(height: 40, color: Colors.pink.shade300,
                      child: const Center(child: Text('flex:1', style: TextStyle(color: Colors.white)))),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Flexible',
            widgetName: 'Flexible',
            child: Row(
              children: [
                Flexible(
                  child: Container(height: 40, color: Colors.indigo.shade300,
                      child: const Center(child: Text('Flexible', style: TextStyle(color: Colors.white)))),
                ),
                const SizedBox(width: 4),
                Container(width: 80, height: 40, color: Colors.cyan.shade300,
                    child: const Center(child: Text('Fixed', style: TextStyle(color: Colors.white)))),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Spacer',
            widgetName: 'Spacer',
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.blue.shade100,
                  child: const Text('Left'),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.green.shade100,
                  child: const Text('Right'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Grids & Lists'),
          WidgetCard(
            title: 'GridView.count',
            widgetName: 'GridView.count',
            child: SizedBox(
              height: 200,
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  9,
                  (i) => Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.primaries[i % Colors.primaries.length].shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text('${i + 1}',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'GridView.builder',
            widgetName: 'GridView.builder',
            child: SizedBox(
              height: 150,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemCount: 8,
                itemBuilder: (context, i) => Container(
                  decoration: BoxDecoration(
                    color: Colors.teal.shade200,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text('${i + 1}',
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'ListView',
            widgetName: 'ListView',
            child: SizedBox(
              height: 120,
              child: ListView(
                children: const [
                  ListTile(leading: Icon(Icons.star), title: Text('Item 1')),
                  ListTile(leading: Icon(Icons.star), title: Text('Item 2')),
                  ListTile(leading: Icon(Icons.star), title: Text('Item 3')),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'ListView.builder',
            widgetName: 'ListView.builder',
            child: SizedBox(
              height: 120,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, i) => ListTile(
                  leading: CircleAvatar(child: Text('${i + 1}')),
                  title: Text('Item ${i + 1}'),
                  subtitle: const Text('Subtitle'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'SingleChildScrollView',
            widgetName: 'SingleChildScrollView',
            child: SizedBox(
              height: 100,
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    6,
                    (i) => Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: Colors.blue.shade100,
                      child: Center(child: Text('Row ${i + 1}')),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'IndexedStack',
            widgetName: 'IndexedStack',
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    3,
                    (i) => ElevatedButton(
                      onPressed: () =>
                          setState(() => _indexedStackIndex = i),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _indexedStackIndex == i
                            ? Colors.deepPurple
                            : null,
                        foregroundColor: _indexedStackIndex == i
                            ? Colors.white
                            : null,
                      ),
                      child: Text('Page ${i + 1}'),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 60,
                  child: IndexedStack(
                    index: _indexedStackIndex,
                    children: [
                      Container(color: Colors.red.shade100,
                          child: const Center(child: Text('Page 1 content'))),
                      Container(color: Colors.green.shade100,
                          child: const Center(child: Text('Page 2 content'))),
                      Container(color: Colors.blue.shade100,
                          child: const Center(child: Text('Page 3 content'))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Sizing & Constraints'),
          WidgetCard(
            title: 'LayoutBuilder',
            widgetName: 'LayoutBuilder',
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.amber.shade100,
                  child: Text(
                    'Max width: ${constraints.maxWidth.toStringAsFixed(0)}px\n'
                    'Layout: ${constraints.maxWidth > 300 ? "Wide" : "Narrow"}',
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'FractionallySizedBox',
            widgetName: 'FractionallySizedBox',
            child: Align(
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Container(
                  height: 40,
                  color: Colors.deepOrange.shade300,
                  child: const Center(
                    child: Text('50% width',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'IntrinsicHeight',
            widgetName: 'IntrinsicHeight',
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: Container(
                          color: Colors.blue.shade100,
                          padding: const EdgeInsets.all(8),
                          child: const Text('Short'))),
                  const SizedBox(width: 4),
                  Expanded(
                      child: Container(
                          color: Colors.green.shade100,
                          padding: const EdgeInsets.all(8),
                          child: const Text(
                              'Longer text\nthat wraps\nto multiple lines'))),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'AspectRatio',
            widgetName: 'AspectRatio',
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.indigo.shade200,
                child: const Center(
                  child: Text('16:9 Box',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'ConstrainedBox',
            widgetName: 'ConstrainedBox',
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
              child: Container(
                color: Colors.cyan.shade200,
                padding: const EdgeInsets.all(12),
                child: const Text('Min 100, Max 200 width'),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'LimitedBox',
            widgetName: 'LimitedBox',
            child: LimitedBox(
              maxWidth: 180,
              child: Container(
                color: Colors.lime.shade300,
                padding: const EdgeInsets.all(12),
                child: const Text('LimitedBox: max 180px'),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'OverflowBox',
            widgetName: 'OverflowBox',
            child: SizedBox(
              height: 80,
              child: OverflowBox(
                maxWidth: 300,
                child: Container(
                  width: 280,
                  height: 60,
                  color: Colors.purple.shade200,
                  child: const Center(
                    child: Text('OverflowBox: wider than parent',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Table & Flow'),
          WidgetCard(
            title: 'Table',
            widgetName: 'Table',
            child: Table(
              border: TableBorder.all(color: Colors.grey),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.blue.shade100),
                  children: const [
                    Padding(padding: EdgeInsets.all(8), child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
                    Padding(padding: EdgeInsets.all(8), child: Text('Age', style: TextStyle(fontWeight: FontWeight.bold))),
                    Padding(padding: EdgeInsets.all(8), child: Text('City', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
                const TableRow(children: [
                  Padding(padding: EdgeInsets.all(8), child: Text('Alice')),
                  Padding(padding: EdgeInsets.all(8), child: Text('25')),
                  Padding(padding: EdgeInsets.all(8), child: Text('NYC')),
                ]),
                const TableRow(children: [
                  Padding(padding: EdgeInsets.all(8), child: Text('Bob')),
                  Padding(padding: EdgeInsets.all(8), child: Text('30')),
                  Padding(padding: EdgeInsets.all(8), child: Text('LA')),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Flow',
            widgetName: 'Flow',
            child: SizedBox(
              height: 100,
              child: Flow(
                delegate: _SimpleFlowDelegate(),
                children: List.generate(
                  5,
                  (i) => Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.primaries[i * 2 % Colors.primaries.length],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text('${i + 1}',
                          style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _SimpleFlowDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    double x = 0;
    for (int i = 0; i < context.childCount; i++) {
      final size = context.getChildSize(i);
      if (size != null) {
        context.paintChild(i,
            transform: Matrix4.translationValues(x, 0, 0));
        x += size.width + 8;
      }
    }
  }

  @override
  bool shouldRepaint(_SimpleFlowDelegate oldDelegate) => false;
}
