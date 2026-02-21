import 'package:flutter/material.dart';
import '../widgets/widget_card.dart';
import '../widgets/section_header.dart';

class NavigationWidgetsScreen extends StatelessWidget {
  const NavigationWidgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Widgets'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00796B), Color(0xFF4DB6AC)],
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(title: 'Navigator'),
          WidgetCard(
            title: 'Navigator.push',
            widgetName: 'Navigator.push',
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const _SamplePage(title: 'Pushed Page'),
                  ),
                );
              },
              child: const Text('Push New Page'),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Navigator.pushNamed',
            widgetName: 'Navigator.pushNamed',
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const _SamplePage(title: 'Named Route Page'),
                  ),
                );
              },
              child: const Text('Push Named Route (simulated)'),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Navigator.pushReplacement',
            widgetName: 'Navigator.pushReplacement',
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const _SamplePage(title: 'Replacement Page'),
                  ),
                );
              },
              child: const Text('Push Replacement'),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'PageView'),
          WidgetCard(
            title: 'PageView',
            widgetName: 'PageView',
            child: SizedBox(
              height: 120,
              child: PageView(
                children: [
                  Container(
                    color: Colors.blue.shade200,
                    child: const Center(child: Text('Page 1', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                  ),
                  Container(
                    color: Colors.green.shade200,
                    child: const Center(child: Text('Page 2', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                  ),
                  Container(
                    color: Colors.orange.shade200,
                    child: const Center(child: Text('Page 3', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'PageView.builder',
            widgetName: 'PageView.builder',
            child: SizedBox(
              height: 120,
              child: PageView.builder(
                itemCount: 5,
                itemBuilder: (context, i) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.primaries[i % Colors.primaries.length].shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text('Page ${i + 1}',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Back & Routes'),
          WidgetCard(
            title: 'PopScope',
            widgetName: 'PopScope',
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const _PopScopePage()),
                );
              },
              child: const Text('Open PopScope Page'),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'PageRouteBuilder',
            widgetName: 'PageRouteBuilder',
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) =>
                        const _SamplePage(title: 'Custom Transition'),
                    transitionsBuilder: (_, anim, __, child) =>
                        FadeTransition(opacity: anim, child: child),
                    transitionDuration: const Duration(milliseconds: 600),
                  ),
                );
              },
              child: const Text('Custom Fade Transition'),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'MaterialPageRoute',
            widgetName: 'MaterialPageRoute',
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const _SamplePage(title: 'Material Page Route'),
                  ),
                );
              },
              child: const Text('Slide Transition'),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _SamplePage extends StatelessWidget {
  final String title;
  const _SamplePage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PopScopePage extends StatelessWidget {
  const _PopScopePage();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Confirm Exit'),
              content: const Text('Are you sure you want to go back?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Stay'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.pop(context);
                  },
                  child: const Text('Leave'),
                ),
              ],
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('PopScope Demo')),
        body: const Center(
          child: Text('Press back to see PopScope in action'),
        ),
      ),
    );
  }
}
