import 'package:flutter/material.dart';

class SliverWidgetsScreen extends StatefulWidget {
  const SliverWidgetsScreen({super.key});

  @override
  State<SliverWidgetsScreen> createState() => _SliverWidgetsScreenState();
}

class _SliverWidgetsScreenState extends State<SliverWidgetsScreen> {
  final GlobalKey<AnimatedListState> _animatedListKey =
      GlobalKey<AnimatedListState>();
  final List<String> _animatedItems = ['Item 1', 'Item 2', 'Item 3'];

  void _addAnimatedItem() {
    final index = _animatedItems.length;
    _animatedItems.add('Item ${index + 1}');
    _animatedListKey.currentState?.insertItem(index);
  }

  void _removeAnimatedItem() {
    if (_animatedItems.isEmpty) return;
    final index = _animatedItems.length - 1;
    final removed = _animatedItems.removeAt(index);
    _animatedListKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: ListTile(title: Text(removed)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              title: const Text('Sliver Widgets'),
              expandedHeight: 180,
              pinned: true,
              floating: false,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'Slivers',
                  style: TextStyle(color: Colors.white),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF0097A7), Color(0xFF4DD0E1)],
                    ),
                  ),
                ),
              ),
              foregroundColor: Colors.white,
              bottom: TabBar(
                tabs: const [
                  Tab(text: 'Lists'),
                  Tab(text: 'Grids'),
                  Tab(text: 'Headers'),
                  Tab(text: 'Animated'),
                ],
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white60,
              ),
            ),
          ],
          body: TabBarView(
            children: [
              _buildListsTab(),
              _buildGridsTab(),
              _buildHeadersTab(),
              _buildAnimatedTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListsTab() {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text('SliverList', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, i) => ListTile(
              leading: CircleAvatar(child: Text('${i + 1}')),
              title: Text('SliverList Item ${i + 1}'),
              subtitle: const Text('Lazy loading sliver list'),
            ),
            childCount: 10,
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text('SliverFixedExtentList', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 48,
          delegate: SliverChildBuilderDelegate(
            (ctx, i) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              color: i.isEven ? Colors.cyan.shade100 : Colors.teal.shade100,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text('Fixed extent item ${i + 1}'),
              ),
            ),
            childCount: 8,
          ),
        ),
        const SliverFillRemaining(
          hasScrollBody: false,
          child: SizedBox(height: 20),
        ),
      ],
    );
  }

  Widget _buildGridsTab() {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text('SliverGrid', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          delegate: SliverChildBuilderDelegate(
            (ctx, i) => Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.primaries[i % Colors.primaries.length].shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text('${i + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            childCount: 18,
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(
            child: Text('SliverPadding wrapping a SliverList',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) => Card(child: ListTile(title: Text('Padded sliver item ${i + 1}'))),
              childCount: 4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeadersTab() {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _StickyHeaderDelegate(
            child: Container(
              color: Colors.cyan.shade700,
              child: const Center(
                child: Text('Pinned Sticky Header',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ),
            minExtent: 50,
            maxExtent: 80,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, i) => ListTile(
              title: Text('Item below sticky header ${i + 1}'),
            ),
            childCount: 6,
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _StickyHeaderDelegate(
            child: Container(
              color: Colors.teal.shade700,
              child: const Center(
                child: Text('Second Sticky Header',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ),
            minExtent: 50,
            maxExtent: 80,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, i) => ListTile(title: Text('More items ${i + 1}')),
            childCount: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('SliverAnimatedList Demo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _addAnimatedItem,
                icon: const Icon(Icons.add),
                label: const Text('Add'),
              ),
              ElevatedButton.icon(
                onPressed: _removeAnimatedItem,
                icon: const Icon(Icons.remove),
                label: const Text('Remove'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: AnimatedList(
              key: _animatedListKey,
              initialItemCount: _animatedItems.length,
              itemBuilder: (ctx, i, animation) => SizeTransition(
                sizeFactor: animation,
                child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.animation, color: Colors.teal),
                    title: Text(_animatedItems[i]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  @override
  final double minExtent;
  @override
  final double maxExtent;

  _StickyHeaderDelegate({
    required this.child,
    required this.minExtent,
    required this.maxExtent,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) => false;
}
