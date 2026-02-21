import 'package:flutter/material.dart';
import '../widgets/widget_card.dart';
import '../widgets/section_header.dart';

class AnimationWidgetsScreen extends StatefulWidget {
  const AnimationWidgetsScreen({super.key});

  @override
  State<AnimationWidgetsScreen> createState() => _AnimationWidgetsScreenState();
}

class _AnimationWidgetsScreenState extends State<AnimationWidgetsScreen>
    with TickerProviderStateMixin {
  // AnimatedContainer
  bool _expanded = false;
  // AnimatedOpacity
  bool _visible = true;
  // AnimatedAlign
  bool _aligned = false;
  // AnimatedPadding
  bool _paddingExpanded = false;
  // AnimatedSize
  bool _sized = false;
  // AnimatedSwitcher counter
  int _counter = 0;
  // AnimatedCrossFade
  bool _showFirst = true;
  // AnimatedPositioned
  bool _moved = false;
  // AnimatedDefaultTextStyle
  bool _bigText = false;
  // AnimatedIcon
  bool _menuOpen = false;
  // HeroPage nav
  // ScaleTransition
  late AnimationController _scaleController;
  late Animation<double> _scaleAnim;
  // FadeTransition
  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;
  // SlideTransition
  late AnimationController _slideController;
  late Animation<Offset> _slideAnim;
  // RotationTransition
  late AnimationController _rotationController;
  // SizeTransition
  late AnimationController _sizeController;
  late Animation<double> _sizeAnim;
  // AnimatedBuilder rotation
  late AnimationController _buildController;
  // CurvedAnimation
  late AnimationController _curvedController;
  late Animation<double> _curvedAnim;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat(reverse: true);
    _scaleAnim = Tween<double>(begin: 0.8, end: 1.2).animate(_scaleController);

    _fadeController = AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat(reverse: true);
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);

    _slideController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))
      ..repeat(reverse: true);
    _slideAnim = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _slideController, curve: Curves.easeInOut));

    _rotationController = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat();

    _sizeController = AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat(reverse: true);
    _sizeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(_sizeController);

    _buildController = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat();

    _curvedController = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _curvedAnim = CurvedAnimation(parent: _curvedController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _rotationController.dispose();
    _sizeController.dispose();
    _buildController.dispose();
    _curvedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Widgets'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFC2185B), Color(0xFFF06292)],
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(title: 'Implicit Animations'),
          WidgetCard(
            title: 'AnimatedContainer',
            widgetName: 'AnimatedContainer',
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => setState(() => _expanded = !_expanded),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    width: _expanded ? 200 : 100,
                    height: _expanded ? 100 : 50,
                    color: _expanded ? Colors.deepPurple : Colors.blue,
                    child: const Center(
                        child: Text('Tap me!',
                            style: TextStyle(color: Colors.white))),
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Tap to expand/collapse'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'AnimatedOpacity',
            widgetName: 'AnimatedOpacity',
            child: Column(
              children: [
                AnimatedOpacity(
                  opacity: _visible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    width: 100,
                    height: 50,
                    color: Colors.pink,
                    child: const Center(
                        child: Text('Fade', style: TextStyle(color: Colors.white))),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _visible = !_visible),
                  child: Text(_visible ? 'Fade Out' : 'Fade In'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'AnimatedAlign',
            widgetName: 'AnimatedAlign',
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                  child: AnimatedAlign(
                    alignment: _aligned ? Alignment.centerRight : Alignment.centerLeft,
                    duration: const Duration(milliseconds: 600),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.teal,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _aligned = !_aligned),
                  child: const Text('Move'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'AnimatedPadding',
            widgetName: 'AnimatedPadding',
            child: Column(
              children: [
                AnimatedPadding(
                  padding: EdgeInsets.all(_paddingExpanded ? 24 : 4),
                  duration: const Duration(milliseconds: 400),
                  child: Container(color: Colors.orange, height: 40,
                      child: const Center(child: Text('Padding', style: TextStyle(color: Colors.white)))),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _paddingExpanded = !_paddingExpanded),
                  child: const Text('Change Padding'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'AnimatedSize',
            widgetName: 'AnimatedSize',
            child: Column(
              children: [
                AnimatedSize(
                  duration: const Duration(milliseconds: 400),
                  child: Container(
                    width: _sized ? 200 : 80,
                    height: _sized ? 80 : 40,
                    color: Colors.indigo,
                    child: const Center(child: Text('Resize', style: TextStyle(color: Colors.white))),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _sized = !_sized),
                  child: const Text('Animate Size'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'AnimatedSwitcher',
            widgetName: 'AnimatedSwitcher',
            child: Column(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    '$_counter',
                    key: ValueKey<int>(_counter),
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _counter++),
                  child: const Text('Increment'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'AnimatedCrossFade',
            widgetName: 'AnimatedCrossFade',
            child: Column(
              children: [
                AnimatedCrossFade(
                  firstChild: Container(
                    height: 60,
                    color: Colors.blue.shade200,
                    child: const Center(child: Text('First Widget')),
                  ),
                  secondChild: Container(
                    height: 60,
                    color: Colors.pink.shade200,
                    child: const Center(child: Text('Second Widget')),
                  ),
                  crossFadeState: _showFirst
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 500),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _showFirst = !_showFirst),
                  child: const Text('Toggle'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'AnimatedPositioned',
            widgetName: 'AnimatedPositioned',
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Stack(
                    children: [
                      Container(color: Colors.grey.shade100),
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 600),
                        left: _moved ? 200 : 10,
                        top: _moved ? 40 : 10,
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.deepOrange,
                          child: const Center(child: Text('Box', style: TextStyle(color: Colors.white))),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _moved = !_moved),
                  child: const Text('Move'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'AnimatedDefaultTextStyle',
            widgetName: 'AnimatedDefaultTextStyle',
            child: Column(
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 500),
                  style: TextStyle(
                    fontSize: _bigText ? 32 : 16,
                    fontWeight: FontWeight.bold,
                    color: _bigText ? Colors.red : Colors.blue,
                  ),
                  child: const Text('Animated Text Style'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _bigText = !_bigText),
                  child: const Text('Toggle Size'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'TweenAnimationBuilder',
            widgetName: 'TweenAnimationBuilder',
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.8, end: 1.2),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              builder: (ctx, value, child) => Transform.scale(scale: value, child: child),
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(color: Colors.purple, shape: BoxShape.circle),
                child: const Center(child: Icon(Icons.star, color: Colors.white, size: 40)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Explicit Animations'),
          WidgetCard(
            title: 'AnimatedBuilder',
            widgetName: 'AnimatedBuilder',
            child: AnimatedBuilder(
              animation: _buildController,
              builder: (ctx, child) => Transform.rotate(
                angle: _buildController.value * 6.28,
                child: child,
              ),
              child: const Icon(Icons.settings, size: 64, color: Colors.teal),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Hero',
            widgetName: 'Hero',
            child: Column(
              children: [
                Hero(
                  tag: 'hero-demo',
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
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const _HeroDestinationPage(),
                      ),
                    );
                  },
                  child: const Text('Tap Hero to Navigate'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'FadeTransition',
            widgetName: 'FadeTransition',
            child: FadeTransition(
              opacity: _fadeAnim,
              child: Container(
                width: 100,
                height: 60,
                color: Colors.blue,
                child: const Center(child: Text('Fading', style: TextStyle(color: Colors.white))),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'ScaleTransition',
            widgetName: 'ScaleTransition',
            child: ScaleTransition(
              scale: _scaleAnim,
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.favorite, color: Colors.white, size: 40),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'SlideTransition',
            widgetName: 'SlideTransition',
            child: SlideTransition(
              position: _slideAnim,
              child: Container(
                width: 120,
                height: 50,
                color: Colors.orange,
                child: const Center(child: Text('Sliding', style: TextStyle(color: Colors.white))),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'RotationTransition',
            widgetName: 'RotationTransition',
            child: RotationTransition(
              turns: _rotationController,
              child: const Icon(Icons.refresh, size: 64, color: Colors.red),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'SizeTransition',
            widgetName: 'SizeTransition',
            child: SizeTransition(
              sizeFactor: _sizeAnim,
              child: Container(
                height: 60,
                color: Colors.teal.shade300,
                child: const Center(child: Text('Size Transition', style: TextStyle(color: Colors.white))),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'AnimatedIcon',
            widgetName: 'AnimatedIcon',
            child: Column(
              children: [
                AnimatedIcon(
                  icon: AnimatedIcons.play_pause,
                  progress: _menuOpen
                      ? const AlwaysStoppedAnimation<double>(1.0)
                      : const AlwaysStoppedAnimation<double>(0.0),
                  size: 64,
                  color: Colors.deepPurple,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _menuOpen = !_menuOpen),
                  child: Text(_menuOpen ? 'Pause' : 'Play'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'CurvedAnimation',
            widgetName: 'CurvedAnimation',
            child: AnimatedBuilder(
              animation: _curvedAnim,
              builder: (ctx, child) => Row(
                children: [
                  const Text('0%'),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: LinearProgressIndicator(value: _curvedAnim.value),
                    ),
                  ),
                  const Text('100%'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _HeroDestinationPage extends StatelessWidget {
  const _HeroDestinationPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Destination')),
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: 'hero-demo',
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.star, color: Colors.white, size: 100),
            ),
          ),
        ),
      ),
    );
  }
}
