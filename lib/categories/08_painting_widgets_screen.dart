import 'dart:ui';
import 'package:flutter/material.dart';
import '../widgets/widget_card.dart';
import '../widgets/section_header.dart';

class PaintingWidgetsScreen extends StatelessWidget {
  const PaintingWidgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painting & Effects'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF388E3C), Color(0xFF81C784)],
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(title: 'Custom Paint'),
          WidgetCard(
            title: 'CustomPaint',
            widgetName: 'CustomPaint',
            child: SizedBox(
              height: 120,
              child: CustomPaint(
                painter: _ShapesPainter(),
                child: Container(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Clipping'),
          WidgetCard(
            title: 'ClipRect',
            widgetName: 'ClipRect',
            child: ClipRect(
              child: Align(
                alignment: Alignment.topLeft,
                widthFactor: 0.6,
                child: Container(
                  width: 150,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Colors.blue, Colors.purple]),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(child: Text('Clipped!', style: TextStyle(color: Colors.white))),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'ClipRRect',
            widgetName: 'ClipRRect',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Container(
                height: 80,
                color: Colors.teal.shade400,
                child: const Center(child: Text('Rounded Corners', style: TextStyle(color: Colors.white, fontSize: 18))),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'ClipOval',
            widgetName: 'ClipOval',
            child: Center(
              child: ClipOval(
                child: Container(
                  width: 100,
                  height: 80,
                  color: Colors.pink.shade300,
                  child: const Center(child: Text('Oval', style: TextStyle(color: Colors.white, fontSize: 18))),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'ClipPath',
            widgetName: 'ClipPath',
            child: Center(
              child: ClipPath(
                clipper: _TriangleClipper(),
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.deepOrange.shade300,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Decoration & Filters'),
          WidgetCard(
            title: 'DecoratedBox',
            widgetName: 'DecoratedBox',
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6A1B9A), Color(0xFFE91E63)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Padding(
                padding: EdgeInsets.all(24),
                child: Text('Gradient Background',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'BackdropFilter',
            widgetName: 'BackdropFilter',
            child: Stack(
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Colors.blue, Colors.purple]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(child: Text('Background', style: TextStyle(color: Colors.white, fontSize: 18))),
                ),
                Positioned(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Container(
                        height: 40,
                        color: Colors.white.withOpacity(0.2),
                        child: const Center(child: Text('Blur overlay', style: TextStyle(color: Colors.white))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'ColorFiltered',
            widgetName: 'ColorFiltered',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 60,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [Colors.red, Colors.blue, Colors.green]),
                      ),
                    ),
                    const Text('Original'),
                  ],
                ),
                Column(
                  children: [
                    ColorFiltered(
                      colorFilter: const ColorFilter.matrix([
                        0.2126, 0.7152, 0.0722, 0, 0,
                        0.2126, 0.7152, 0.0722, 0, 0,
                        0.2126, 0.7152, 0.0722, 0, 0,
                        0,      0,      0,      1, 0,
                      ]),
                      child: Container(
                        width: 80,
                        height: 60,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [Colors.red, Colors.blue, Colors.green]),
                        ),
                      ),
                    ),
                    const Text('Grayscale'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'ShaderMask',
            widgetName: 'ShaderMask',
            child: Center(
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Colors.purple, Colors.blue, Colors.pink],
                ).createShader(bounds),
                blendMode: BlendMode.srcIn,
                child: const Text(
                  'Gradient Text!',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Transforms'),
          WidgetCard(
            title: 'Transform.rotate',
            widgetName: 'Transform.rotate',
            child: Center(
              child: Transform.rotate(
                angle: 0.5,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.amber,
                  child: const Text('Rotated Box', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Transform.scale',
            widgetName: 'Transform.scale',
            child: Center(
              child: Transform.scale(
                scale: 1.3,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.cyan.shade300,
                  child: const Text('Scaled 1.3x'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Transform.translate',
            widgetName: 'Transform.translate',
            child: Stack(
              children: [
                Container(height: 60, color: Colors.grey.shade100),
                Transform.translate(
                  offset: const Offset(30, 10),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.deepPurple.shade200,
                    child: const Text('Translated', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'PhysicalModel',
            widgetName: 'PhysicalModel',
            child: Center(
              child: PhysicalModel(
                color: Colors.white,
                elevation: 8,
                borderRadius: BorderRadius.circular(16),
                shadowColor: Colors.purple,
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('PhysicalModel', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'RepaintBoundary',
            widgetName: 'RepaintBoundary',
            child: RepaintBoundary(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('This widget is isolated in its own layer\nfor rendering optimization.'),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'CircleAvatar with image',
            widgetName: 'CircleAvatar',
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue,
                  child: Text('AB', style: TextStyle(color: Colors.white, fontSize: 24)),
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/100'),
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

class _ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Circle
    paint.color = Colors.blue.shade300;
    canvas.drawCircle(const Offset(50, 60), 40, paint);

    // Rectangle
    paint.color = Colors.green.shade300;
    canvas.drawRect(const Rect.fromLTWH(110, 20, 80, 80), paint);

    // Line
    final linePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    canvas.drawLine(const Offset(210, 20), const Offset(300, 100), linePaint);

    // Triangle
    paint.color = Colors.orange.shade300;
    final path = Path()
      ..moveTo(320, 100)
      ..lineTo(350, 20)
      ..lineTo(380, 100)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ShapesPainter oldDelegate) => false;
}

class _TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_TriangleClipper old) => false;
}
