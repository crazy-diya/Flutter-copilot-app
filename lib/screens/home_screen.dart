import 'package:flutter/material.dart';
import '../categories/01_basic_widgets_screen.dart';
import '../categories/02_layout_widgets_screen.dart';
import '../categories/03_material_widgets_screen.dart';
import '../categories/04_cupertino_widgets_screen.dart';
import '../categories/05_animation_widgets_screen.dart';
import '../categories/06_navigation_widgets_screen.dart';
import '../categories/07_gesture_widgets_screen.dart';
import '../categories/08_painting_widgets_screen.dart';
import '../categories/09_sliver_widgets_screen.dart';
import '../categories/10_state_widgets_screen.dart';
import '../categories/11_utility_widgets_screen.dart';
import '../categories/12_input_widgets_screen.dart';
import '../categories/13_datetime_widgets_screen.dart';
import '../categories/14_bonus_widgets_screen.dart';

class _CategoryInfo {
  final String name;
  final IconData icon;
  final List<Color> colors;
  final int count;
  final Widget screen;

  const _CategoryInfo({
    required this.name,
    required this.icon,
    required this.colors,
    required this.count,
    required this.screen,
  });
}

class ShowcaseHomeScreen extends StatefulWidget {
  const ShowcaseHomeScreen({super.key});

  @override
  State<ShowcaseHomeScreen> createState() => _ShowcaseHomeScreenState();
}

class _ShowcaseHomeScreenState extends State<ShowcaseHomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  String _searchQuery = '';
  bool _fabIcon = false;
  late AnimationController _fabController;
  final TextEditingController _searchController = TextEditingController();

  static final List<_CategoryInfo> _categories = [
    _CategoryInfo(
      name: 'Basic Widgets',
      icon: Icons.widgets,
      colors: const [Color(0xFF1976D2), Color(0xFF42A5F5)],
      count: 15,
      screen: const BasicWidgetsScreen(),
    ),
    _CategoryInfo(
      name: 'Layout Widgets',
      icon: Icons.dashboard,
      colors: const [Color(0xFF303F9F), Color(0xFF7986CB)],
      count: 23,
      screen: const LayoutWidgetsScreen(),
    ),
    _CategoryInfo(
      name: 'Material Design',
      icon: Icons.design_services,
      colors: const [Color(0xFF7B1FA2), Color(0xFFBA68C8)],
      count: 47,
      screen: const MaterialWidgetsScreen(),
    ),
    _CategoryInfo(
      name: 'Cupertino (iOS)',
      icon: Icons.phone_iphone,
      colors: const [Color(0xFFE64A19), Color(0xFFFF8A65)],
      count: 15,
      screen: const CupertinoWidgetsScreen(),
    ),
    _CategoryInfo(
      name: 'Animations',
      icon: Icons.animation,
      colors: const [Color(0xFFC2185B), Color(0xFFF06292)],
      count: 19,
      screen: const AnimationWidgetsScreen(),
    ),
    _CategoryInfo(
      name: 'Navigation',
      icon: Icons.navigation,
      colors: const [Color(0xFF00796B), Color(0xFF4DB6AC)],
      count: 8,
      screen: const NavigationWidgetsScreen(),
    ),
    _CategoryInfo(
      name: 'Gestures',
      icon: Icons.touch_app,
      colors: const [Color(0xFFF57C00), Color(0xFFFFB74D)],
      count: 13,
      screen: const GestureWidgetsScreen(),
    ),
    _CategoryInfo(
      name: 'Painting & Effects',
      icon: Icons.brush,
      colors: const [Color(0xFF388E3C), Color(0xFF81C784)],
      count: 15,
      screen: const PaintingWidgetsScreen(),
    ),
    _CategoryInfo(
      name: 'Slivers',
      icon: Icons.view_stream,
      colors: const [Color(0xFF0097A7), Color(0xFF4DD0E1)],
      count: 11,
      screen: const SliverWidgetsScreen(),
    ),
    _CategoryInfo(
      name: 'State & Async',
      icon: Icons.sync,
      colors: const [Color(0xFFD32F2F), Color(0xFFE57373)],
      count: 8,
      screen: const StateWidgetsScreen(),
    ),
    _CategoryInfo(
      name: 'Utility Widgets',
      icon: Icons.build,
      colors: const [Color(0xFF5D4037), Color(0xFFA1887F)],
      count: 18,
      screen: const UtilityWidgetsScreen(),
    ),
    _CategoryInfo(
      name: 'Input Widgets',
      icon: Icons.input,
      colors: const [Color(0xFF0288D1), Color(0xFF4FC3F7)],
      count: 7,
      screen: const InputWidgetsScreen(),
    ),
    _CategoryInfo(
      name: 'Date & Time',
      icon: Icons.calendar_today,
      colors: const [Color(0xFF827717), Color(0xFFD4E157)],
      count: 6,
      screen: const DateTimeWidgetsScreen(),
    ),
    _CategoryInfo(
      name: 'Bonus Widgets',
      icon: Icons.star,
      colors: const [Color(0xFFF9A825), Color(0xFFFFD54F)],
      count: 15,
      screen: const BonusWidgetsScreen(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _fabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<_CategoryInfo> get _filtered {
    if (_searchQuery.isEmpty) return _categories;
    return _categories
        .where((c) =>
            c.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  void _onFabPressed() {
    setState(() => _fabIcon = !_fabIcon);
    if (_fabIcon) {
      _fabController.forward();
    } else {
      _fabController.reverse();
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Flutter Widget Showcase! 🎉'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeTab(),
          _buildFavoritesTab(),
          _buildSettingsTab(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFabPressed,
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _fabController,
        ),
      ),
    );
  }

  Widget _buildHomeTab() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text(
              'Flutter Widget Showcase',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF6750A4), Color(0xFF9C27B0)],
                ),
              ),
              child: const Center(
                child: Icon(Icons.flutter_dash,
                    size: 80, color: Colors.white70),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Search categories...',
              leading: const Icon(Icons.search),
              onChanged: (v) => setState(() => _searchQuery = v),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemCount: _filtered.length,
            itemBuilder: (context, index) {
              final cat = _filtered[index];
              return _CategoryCard(
                info: cat,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => cat.screen),
                ),
              );
            },
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 80)),
      ],
    );
  }

  Widget _buildFavoritesTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('No favorites yet', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 16),
        Text(
          'Settings',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Card(
          child: ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Version'),
            subtitle: const Text('1.0.0'),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.widgets),
            title: const Text('Total Widgets'),
            subtitle: const Text('220+ demos'),
          ),
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final _CategoryInfo info;
  final VoidCallback onTap;

  const _CategoryCard({required this.info, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: info.colors,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: info.colors[0].withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(info.icon, color: Colors.white, size: 32),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${info.count}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                info.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${info.count} widgets',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
