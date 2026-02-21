import 'package:flutter/material.dart';
import '../widgets/widget_card.dart';
import '../widgets/section_header.dart';

class BasicWidgetsScreen extends StatefulWidget {
  const BasicWidgetsScreen({super.key});

  @override
  State<BasicWidgetsScreen> createState() => _BasicWidgetsScreenState();
}

class _BasicWidgetsScreenState extends State<BasicWidgetsScreen> {
  bool _visible = true;
  bool _offstage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Widgets'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(title: 'Text & Rich Text'),
          WidgetCard(
            title: 'Text',
            widgetName: 'Text',
            child: const Text(
              'Hello Flutter!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'RichText',
            widgetName: 'RichText',
            child: RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 18, color: Colors.black),
                children: [
                  TextSpan(text: 'Flutter '),
                  TextSpan(
                    text: 'is ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  TextSpan(
                    text: 'awesome!',
                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.pink),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Icons & Images'),
          WidgetCard(
            title: 'Icon',
            widgetName: 'Icon',
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.star, color: Colors.amber, size: 40),
                Icon(Icons.favorite, color: Colors.red, size: 40),
                Icon(Icons.flutter_dash, color: Colors.blue, size: 40),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Image.network',
            widgetName: 'Image.network',
            child: Image.network(
              'https://picsum.photos/300/150',
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 120,
                  color: Colors.grey.shade200,
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 48, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Layout Basics'),
          WidgetCard(
            title: 'Container',
            widgetName: 'Container',
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue),
              ),
              child: const Text('Styled Container',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'SizedBox',
            widgetName: 'SizedBox',
            child: Column(
              children: [
                Container(width: 100, height: 40, color: Colors.blue.shade300,
                    child: const Center(child: Text('Box 1'))),
                const SizedBox(height: 16),
                Container(width: 100, height: 40, color: Colors.green.shade300,
                    child: const Center(child: Text('Box 2'))),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Padding',
            widgetName: 'Padding',
            child: Container(
              color: Colors.orange.shade100,
              child: const Padding(
                padding: EdgeInsets.all(24),
                child: Text('Text with all-around padding'),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Center',
            widgetName: 'Center',
            child: Container(
              height: 60,
              color: Colors.purple.shade50,
              child: const Center(
                child: Text('Centered Text',
                    style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Align',
            widgetName: 'Align',
            child: Container(
              height: 80,
              color: Colors.teal.shade50,
              child: const Align(
                alignment: Alignment.topRight,
                child: Icon(Icons.star, color: Colors.teal, size: 32),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'FittedBox',
            widgetName: 'FittedBox',
            child: SizedBox(
              width: 150,
              height: 50,
              child: FittedBox(
                fit: BoxFit.contain,
                child: const Text('Very Large Text That Fits',
                    style: TextStyle(fontSize: 48)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Avatars & Placeholders'),
          WidgetCard(
            title: 'CircleAvatar',
            widgetName: 'CircleAvatar',
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.deepPurple,
                  child: Text('AB',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.person, color: Colors.white, size: 30),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Placeholder',
            widgetName: 'Placeholder',
            child: const SizedBox(
              height: 80,
              child: Placeholder(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Visibility'),
          WidgetCard(
            title: 'Opacity',
            widgetName: 'Opacity',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Opacity(opacity: 1.0,
                    child: Container(width: 60, height: 60, color: Colors.blue,
                        child: const Center(child: Text('100%', style: TextStyle(color: Colors.white))))),
                Opacity(opacity: 0.5,
                    child: Container(width: 60, height: 60, color: Colors.blue,
                        child: const Center(child: Text('50%', style: TextStyle(color: Colors.white))))),
                Opacity(opacity: 0.2,
                    child: Container(width: 60, height: 60, color: Colors.blue,
                        child: const Center(child: Text('20%', style: TextStyle(color: Colors.white))))),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Visibility',
            widgetName: 'Visibility',
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _visible = !_visible),
                  child: Text(_visible ? 'Hide Widget' : 'Show Widget'),
                ),
                const SizedBox(height: 8),
                Visibility(
                  visible: _visible,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.amber.shade200,
                    child: const Text('I am visible!'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Offstage',
            widgetName: 'Offstage',
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _offstage = !_offstage),
                  child: Text(_offstage ? 'Show (offstage=false)' : 'Hide (offstage=true)'),
                ),
                const SizedBox(height: 8),
                Offstage(
                  offstage: _offstage,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.green.shade200,
                    child: const Text('I am offstage!'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
