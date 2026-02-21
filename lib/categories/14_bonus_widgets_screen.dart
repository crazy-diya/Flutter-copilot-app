import 'package:flutter/material.dart';
import '../widgets/widget_card.dart';
import '../widgets/section_header.dart';

class BonusWidgetsScreen extends StatefulWidget {
  const BonusWidgetsScreen({super.key});

  @override
  State<BonusWidgetsScreen> createState() => _BonusWidgetsScreenState();
}

class _BonusWidgetsScreenState extends State<BonusWidgetsScreen> {
  // ReorderableListView
  List<String> _reorderItems = ['Task A', 'Task B', 'Task C', 'Task D', 'Task E'];

  // AnimatedList
  final GlobalKey<AnimatedListState> _animListKey = GlobalKey<AnimatedListState>();
  final List<String> _animItems = ['Item 1', 'Item 2', 'Item 3'];

  // ExpansionPanelList
  final List<_PanelItem> _panels = [
    _PanelItem('Panel 1', 'Content for panel 1', false),
    _PanelItem('Panel 2', 'Content for panel 2', false),
    _PanelItem('Panel 3', 'Content for panel 3', false),
  ];

  // DataTable sort
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  final List<Map<String, dynamic>> _tableData = [
    {'name': 'Alice', 'age': 25, 'city': 'NYC'},
    {'name': 'Bob', 'age': 30, 'city': 'LA'},
    {'name': 'Charlie', 'age': 22, 'city': 'Chicago'},
    {'name': 'Diana', 'age': 28, 'city': 'Houston'},
  ];

  // Keyboard listener
  String _keyEvent = 'Press a key';

  // AnimatedGrid
  final GlobalKey<AnimatedGridState> _animGridKey = GlobalKey<AnimatedGridState>();
  final List<Color> _gridColors = [
    Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple, Colors.teal,
  ];

  // Overlay
  OverlayEntry? _overlayEntry;

  // FocusTraversal
  final FocusNode _focus1 = FocusNode();
  final FocusNode _focus2 = FocusNode();
  final FocusNode _focus3 = FocusNode();

  @override
  void dispose() {
    _overlayEntry?.remove();
    _focus1.dispose();
    _focus2.dispose();
    _focus3.dispose();
    super.dispose();
  }

  void _addAnimItem() {
    final index = _animItems.length;
    _animItems.add('Item ${index + 1}');
    _animListKey.currentState?.insertItem(index);
  }

  void _removeAnimItem() {
    if (_animItems.isEmpty) return;
    final index = _animItems.length - 1;
    final removed = _animItems.removeAt(index);
    _animListKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: Card(child: ListTile(title: Text(removed))),
      ),
    );
  }

  void _addGridItem() {
    final index = _gridColors.length;
    _gridColors.add(Colors.primaries[index % Colors.primaries.length]);
    _animGridKey.currentState?.insertItem(index);
  }

  void _removeGridItem() {
    if (_gridColors.isEmpty) return;
    final index = _gridColors.length - 1;
    final removed = _gridColors.removeAt(index);
    _animGridKey.currentState?.removeItem(
      index,
      (context, animation) => ScaleTransition(
        scale: animation,
        child: Container(color: removed),
      ),
    );
  }

  void _showOverlay(BuildContext context) {
    _overlayEntry?.remove();
    _overlayEntry = OverlayEntry(
      builder: (ctx) => Positioned(
        top: 100,
        left: 50,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Custom Overlay!',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    _overlayEntry?.remove();
                    _overlayEntry = null;
                  },
                  child: const Text('Dismiss',
                      style: TextStyle(color: Colors.white70)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bonus Widgets'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF9A825), Color(0xFFFFD54F)],
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(title: 'Lists & Grids'),
          WidgetCard(
            title: 'ReorderableListView',
            widgetName: 'ReorderableListView',
            child: SizedBox(
              height: 200,
              child: ReorderableListView(
                shrinkWrap: true,
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) newIndex--;
                    final item = _reorderItems.removeAt(oldIndex);
                    _reorderItems.insert(newIndex, item);
                  });
                },
                children: _reorderItems
                    .map((item) => ListTile(
                          key: Key(item),
                          leading: const Icon(Icons.drag_handle),
                          title: Text(item),
                          trailing: const Icon(Icons.drag_indicator),
                        ))
                    .toList(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'AnimatedList',
            widgetName: 'AnimatedList',
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _addAnimItem,
                      icon: const Icon(Icons.add),
                      label: const Text('Add'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _removeAnimItem,
                      icon: const Icon(Icons.remove),
                      label: const Text('Remove'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 160,
                  child: AnimatedList(
                    key: _animListKey,
                    initialItemCount: _animItems.length,
                    itemBuilder: (ctx, i, animation) => SizeTransition(
                      sizeFactor: animation,
                      child: Card(
                        child: ListTile(title: Text(_animItems[i])),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'ExpansionPanelList',
            widgetName: 'ExpansionPanelList',
            child: ExpansionPanelList(
              elevation: 1,
              expandedHeaderPadding: EdgeInsets.zero,
              expansionCallback: (i, isExpanded) {
                setState(() => _panels[i].isExpanded = !isExpanded);
              },
              children: _panels
                  .map((panel) => ExpansionPanel(
                        headerBuilder: (ctx, isExpanded) => ListTile(
                          title: Text(panel.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        body: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(panel.content),
                        ),
                        isExpanded: panel.isExpanded,
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Data Tables'),
          WidgetCard(
            title: 'DataTable',
            widgetName: 'DataTable',
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                sortColumnIndex: _sortColumnIndex,
                sortAscending: _sortAscending,
                columns: [
                  DataColumn(
                    label: const Text('Name'),
                    onSort: (i, asc) => setState(() {
                      _sortColumnIndex = i;
                      _sortAscending = asc;
                      _tableData.sort((a, b) => asc
                          ? (a['name'] as String).compareTo(b['name'] as String)
                          : (b['name'] as String)
                              .compareTo(a['name'] as String));
                    }),
                  ),
                  DataColumn(
                    label: const Text('Age'),
                    numeric: true,
                    onSort: (i, asc) => setState(() {
                      _sortColumnIndex = i;
                      _sortAscending = asc;
                      _tableData.sort((a, b) => asc
                          ? (a['age'] as int).compareTo(b['age'] as int)
                          : (b['age'] as int).compareTo(a['age'] as int));
                    }),
                  ),
                  const DataColumn(label: Text('City')),
                ],
                rows: _tableData
                    .map((row) => DataRow(cells: [
                          DataCell(Text(row['name'] as String)),
                          DataCell(Text('${row['age']}')),
                          DataCell(Text(row['city'] as String)),
                        ]))
                    .toList(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'PaginatedDataTable',
            widgetName: 'PaginatedDataTable',
            child: PaginatedDataTable(
              header: const Text('Employees'),
              rowsPerPage: 3,
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Age'), numeric: true),
                DataColumn(label: Text('City')),
              ],
              source: _TableDataSource(_tableData),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Overlay & Menus'),
          WidgetCard(
            title: 'Overlay + OverlayEntry',
            widgetName: 'Overlay',
            child: ElevatedButton(
              onPressed: () => _showOverlay(context),
              child: const Text('Show Custom Overlay'),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'MenuBar',
            widgetName: 'MenuBar',
            child: MenuBar(
              children: [
                SubmenuButton(
                  menuChildren: [
                    MenuItemButton(
                      onPressed: () {},
                      child: const Text('New'),
                    ),
                    MenuItemButton(
                      onPressed: () {},
                      child: const Text('Open'),
                    ),
                    const Divider(),
                    MenuItemButton(
                      onPressed: () {},
                      child: const Text('Exit'),
                    ),
                  ],
                  child: const Text('File'),
                ),
                SubmenuButton(
                  menuChildren: [
                    MenuItemButton(
                        onPressed: () {}, child: const Text('Copy')),
                    MenuItemButton(
                        onPressed: () {}, child: const Text('Paste')),
                  ],
                  child: const Text('Edit'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'PopupMenuButton with dividers',
            widgetName: 'PopupMenuButton',
            child: PopupMenuButton<String>(
              onSelected: (_) {},
              itemBuilder: (ctx) => [
                const PopupMenuItem(
                    value: 'edit',
                    child: ListTile(
                        leading: Icon(Icons.edit), title: Text('Edit'))),
                const PopupMenuItem(
                    value: 'share',
                    child: ListTile(
                        leading: Icon(Icons.share), title: Text('Share'))),
                const PopupMenuDivider(),
                const PopupMenuItem(
                    value: 'delete',
                    child: ListTile(
                        leading: Icon(Icons.delete, color: Colors.red),
                        title: Text('Delete'))),
              ],
              child: const Chip(
                label: Text('Open Menu'),
                avatar: Icon(Icons.menu),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Input & Focus'),
          WidgetCard(
            title: 'Key Event Listener',
            widgetName: 'Focus/KeyEvent',
            child: Focus(
              onKeyEvent: (node, event) {
                if (event is KeyDownEvent) {
                  setState(
                      () => _keyEvent = 'Key: ${event.logicalKey.keyLabel}');
                }
                return KeyEventResult.ignored;
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber),
                ),
                child: Column(
                  children: [
                    Text(_keyEvent, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    const Text('(Tap here then press keyboard keys)',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'FocusTraversalGroup',
            widgetName: 'FocusTraversalGroup',
            child: FocusTraversalGroup(
              policy: OrderedTraversalPolicy(),
              child: Column(
                children: [
                  FocusTraversalOrder(
                    order: const NumericFocusOrder(1),
                    child: TextField(
                      focusNode: _focus1,
                      decoration: const InputDecoration(
                        labelText: 'Field 1 (Tab first)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  FocusTraversalOrder(
                    order: const NumericFocusOrder(3),
                    child: TextField(
                      focusNode: _focus2,
                      decoration: const InputDecoration(
                        labelText: 'Field 3 (Tab third)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  FocusTraversalOrder(
                    order: const NumericFocusOrder(2),
                    child: TextField(
                      focusNode: _focus3,
                      decoration: const InputDecoration(
                        labelText: 'Field 2 (Tab second)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Use Tab key to traverse (order: 1 → 2 → 3)',
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Animated Widgets'),
          WidgetCard(
            title: 'AnimatedGrid',
            widgetName: 'AnimatedGrid',
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _addGridItem,
                      icon: const Icon(Icons.add),
                      label: const Text('Add'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _removeGridItem,
                      icon: const Icon(Icons.remove),
                      label: const Text('Remove'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 200,
                  child: AnimatedGrid(
                    key: _animGridKey,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                    ),
                    initialItemCount: _gridColors.length,
                    itemBuilder: (ctx, i, animation) => ScaleTransition(
                      scale: animation,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _gridColors[i],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text('${i + 1}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'SelectionArea',
            widgetName: 'SelectionArea',
            child: const SelectionArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SelectionArea wraps all children.',
                      style: TextStyle(fontSize: 16)),
                  Text('This entire area is selectable!'),
                  Text('Click and drag to select text across widgets.'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Scrollbar variants',
            widgetName: 'Scrollbar',
            child: SizedBox(
              height: 120,
              child: Scrollbar(
                thumbVisibility: true,
                trackVisibility: true,
                thickness: 8,
                child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (ctx, i) => ListTile(
                    leading: Icon(Icons.circle,
                        color:
                            Colors.primaries[i % Colors.primaries.length]),
                    title: Text('Scrollbar item ${i + 1}'),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'TextScaler demo',
            widgetName: 'TextScaler',
            child: const _TextScalerDemo(),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _PanelItem {
  String title;
  String content;
  bool isExpanded;

  _PanelItem(this.title, this.content, this.isExpanded);
}

class _TableDataSource extends DataTableSource {
  final List<Map<String, dynamic>> data;

  _TableDataSource(this.data);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final row = data[index];
    return DataRow(cells: [
      DataCell(Text(row['name'] as String)),
      DataCell(Text('${row['age']}')),
      DataCell(Text(row['city'] as String)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

class _TextScalerDemo extends StatefulWidget {
  const _TextScalerDemo();

  @override
  State<_TextScalerDemo> createState() => _TextScalerDemoState();
}

class _TextScalerDemoState extends State<_TextScalerDemo> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: _scale,
          min: 0.5,
          max: 2.0,
          divisions: 15,
          label: _scale.toStringAsFixed(1),
          onChanged: (v) => setState(() => _scale = v),
        ),
        MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(_scale),
          ),
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.amber.shade50,
            child: Text(
              'Dynamic Text Scale: ${_scale.toStringAsFixed(1)}x',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
