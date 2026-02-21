import 'package:flutter/material.dart';
import '../widgets/widget_card.dart';
import '../widgets/section_header.dart';

class MaterialWidgetsScreen extends StatefulWidget {
  const MaterialWidgetsScreen({super.key});

  @override
  State<MaterialWidgetsScreen> createState() => _MaterialWidgetsScreenState();
}

class _MaterialWidgetsScreenState extends State<MaterialWidgetsScreen>
    with SingleTickerProviderStateMixin {
  bool _checkboxValue = true;
  bool _switchValue = false;
  int _radioValue = 1;
  double _sliderValue = 0.3;
  RangeValues _rangeValues = const RangeValues(0.2, 0.8);
  int _stepperIndex = 0;
  String _dropdownValue = 'Option A';
  bool _filterSelected = false;
  String _choiceSelected = 'Day';
  Set<String> _segmentSelected = {'Day'};
  int _navBarIndex = 0;
  double _progressValue = 0.6;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Design'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF7B1FA2), Color(0xFFBA68C8)],
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(title: 'App Structure'),
          WidgetCard(
            title: 'AppBar Preview',
            widgetName: 'AppBar',
            child: AppBar(
              title: const Text('Sample AppBar'),
              leading: const Icon(Icons.menu),
              actions: const [Icon(Icons.search), SizedBox(width: 8), Icon(Icons.more_vert), SizedBox(width: 8)],
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              elevation: 4,
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Card',
            widgetName: 'Card',
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Card Title', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 8),
                    const Text('This is a Material Card with elevation and rounded corners.'),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: () {}, child: const Text('Cancel')),
                        const SizedBox(width: 8),
                        ElevatedButton(onPressed: () {}, child: const Text('OK')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'List Tiles'),
          WidgetCard(
            title: 'ListTile',
            widgetName: 'ListTile',
            child: const ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text('John Doe'),
              subtitle: Text('Flutter Developer'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'ExpansionTile',
            widgetName: 'ExpansionTile',
            child: const ExpansionTile(
              leading: Icon(Icons.info),
              title: Text('Expand to see details'),
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('This is the expanded content of the ExpansionTile widget.'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'CheckboxListTile',
            widgetName: 'CheckboxListTile',
            child: CheckboxListTile(
              value: _checkboxValue,
              onChanged: (v) => setState(() => _checkboxValue = v!),
              title: const Text('Enable notifications'),
              subtitle: const Text('Receive updates'),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'SwitchListTile',
            widgetName: 'SwitchListTile',
            child: SwitchListTile(
              value: _switchValue,
              onChanged: (v) => setState(() => _switchValue = v),
              title: const Text('Dark Mode'),
              subtitle: const Text('Toggle dark theme'),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'RadioListTile',
            widgetName: 'RadioListTile',
            child: Column(
              children: [1, 2, 3].map((v) => RadioListTile<int>(
                value: v,
                groupValue: _radioValue,
                onChanged: (val) => setState(() => _radioValue = val!),
                title: Text('Option $v'),
              )).toList(),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Buttons'),
          WidgetCard(
            title: 'ElevatedButton',
            widgetName: 'ElevatedButton',
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.send),
              label: const Text('Submit'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'TextButton',
            widgetName: 'TextButton',
            child: TextButton(onPressed: () {}, child: const Text('Text Button')),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'OutlinedButton',
            widgetName: 'OutlinedButton',
            child: OutlinedButton(onPressed: () {}, child: const Text('Outlined Button')),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'IconButton',
            widgetName: 'IconButton',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'FilledButton',
            widgetName: 'FilledButton',
            child: Wrap(
              spacing: 12,
              children: [
                FilledButton(onPressed: () {}, child: const Text('Filled')),
                FilledButton.tonal(onPressed: () {}, child: const Text('Tonal')),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'SegmentedButton',
            widgetName: 'SegmentedButton',
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'Day', label: Text('Day')),
                ButtonSegment(value: 'Week', label: Text('Week')),
                ButtonSegment(value: 'Month', label: Text('Month')),
              ],
              selected: _segmentSelected,
              onSelectionChanged: (s) => setState(() => _segmentSelected = s),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'FloatingActionButton',
            widgetName: 'FloatingActionButton',
            child: Wrap(
              spacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                FloatingActionButton.small(onPressed: () {}, child: const Icon(Icons.add)),
                FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
                FloatingActionButton.extended(onPressed: () {}, label: const Text('Add'), icon: const Icon(Icons.add)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Chips'),
          WidgetCard(
            title: 'Chip',
            widgetName: 'Chip',
            child: Wrap(
              spacing: 8,
              children: [
                Chip(
                  avatar: const CircleAvatar(child: Text('A')),
                  label: const Text('Alice'),
                  onDeleted: () {},
                ),
                Chip(
                  avatar: const CircleAvatar(child: Text('B')),
                  label: const Text('Bob'),
                  onDeleted: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'ActionChip',
            widgetName: 'ActionChip',
            child: ActionChip(
              avatar: const Icon(Icons.flash_on),
              label: const Text('Quick Action'),
              onPressed: () {},
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'FilterChip',
            widgetName: 'FilterChip',
            child: FilterChip(
              label: const Text('Filter Option'),
              selected: _filterSelected,
              onSelected: (v) => setState(() => _filterSelected = v),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'ChoiceChip',
            widgetName: 'ChoiceChip',
            child: Wrap(
              spacing: 8,
              children: ['Day', 'Week', 'Month'].map((s) => ChoiceChip(
                label: Text(s),
                selected: _choiceSelected == s,
                onSelected: (v) { if (v) setState(() => _choiceSelected = s); },
              )).toList(),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'InputChip',
            widgetName: 'InputChip',
            child: InputChip(
              label: const Text('flutter@example.com'),
              avatar: const Icon(Icons.email),
              onDeleted: () {},
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Dropdowns'),
          WidgetCard(
            title: 'DropdownButton',
            widgetName: 'DropdownButton',
            child: DropdownButton<String>(
              value: _dropdownValue,
              items: ['Option A', 'Option B', 'Option C']
                  .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                  .toList(),
              onChanged: (v) => setState(() => _dropdownValue = v!),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'DropdownMenu',
            widgetName: 'DropdownMenu',
            child: DropdownMenu<String>(
              label: const Text('Select'),
              initialSelection: 'Flutter',
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: 'Flutter', label: 'Flutter'),
                DropdownMenuEntry(value: 'Dart', label: 'Dart'),
                DropdownMenuEntry(value: 'Firebase', label: 'Firebase'),
              ],
              onSelected: (_) {},
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Form Controls'),
          WidgetCard(
            title: 'Checkbox',
            widgetName: 'Checkbox',
            child: Row(
              children: [
                Checkbox(
                  value: _checkboxValue,
                  onChanged: (v) => setState(() => _checkboxValue = v!),
                ),
                const Text('Accept Terms'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Switch',
            widgetName: 'Switch',
            child: Row(
              children: [
                Switch.adaptive(
                  value: _switchValue,
                  onChanged: (v) => setState(() => _switchValue = v),
                ),
                const SizedBox(width: 8),
                Text(_switchValue ? 'ON' : 'OFF'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Radio',
            widgetName: 'Radio',
            child: Column(
              children: [1, 2, 3].map((v) => Row(
                children: [
                  Radio<int>(
                    value: v,
                    groupValue: _radioValue,
                    onChanged: (val) => setState(() => _radioValue = val!),
                  ),
                  Text('Radio $v'),
                ],
              )).toList(),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Slider',
            widgetName: 'Slider',
            child: Column(
              children: [
                Slider(
                  value: _sliderValue,
                  onChanged: (v) => setState(() => _sliderValue = v),
                  divisions: 10,
                  label: (_sliderValue * 100).toStringAsFixed(0),
                ),
                Text('Value: ${(_sliderValue * 100).toStringAsFixed(0)}%'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'RangeSlider',
            widgetName: 'RangeSlider',
            child: Column(
              children: [
                RangeSlider(
                  values: _rangeValues,
                  onChanged: (v) => setState(() => _rangeValues = v),
                  labels: RangeLabels(
                    (_rangeValues.start * 100).toStringAsFixed(0),
                    (_rangeValues.end * 100).toStringAsFixed(0),
                  ),
                ),
                Text('${(_rangeValues.start * 100).toStringAsFixed(0)}% - ${(_rangeValues.end * 100).toStringAsFixed(0)}%'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Stepper',
            widgetName: 'Stepper',
            child: Stepper(
              currentStep: _stepperIndex,
              onStepTapped: (i) => setState(() => _stepperIndex = i),
              onStepContinue: () {
                if (_stepperIndex < 2) setState(() => _stepperIndex++);
              },
              onStepCancel: () {
                if (_stepperIndex > 0) setState(() => _stepperIndex--);
              },
              steps: const [
                Step(title: Text('Step 1'), content: Text('Enter your name')),
                Step(title: Text('Step 2'), content: Text('Enter your email')),
                Step(title: Text('Step 3'), content: Text('Confirm details')),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Dividers & Tooltips'),
          WidgetCard(
            title: 'Divider + VerticalDivider',
            widgetName: 'Divider',
            child: Column(
              children: [
                const Divider(thickness: 2, color: Colors.blue),
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Left'),
                      const VerticalDivider(thickness: 2, color: Colors.red),
                      const Text('Right'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Tooltip',
            widgetName: 'Tooltip',
            child: const Tooltip(
              message: 'This is a tooltip!',
              child: Icon(Icons.info, size: 40, color: Colors.blue),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Badge',
            widgetName: 'Badge',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Badge(label: const Text('3'), child: const Icon(Icons.notifications, size: 36)),
                Badge(label: const Text('99+'), child: const Icon(Icons.mail, size: 36)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Banner',
            widgetName: 'Banner',
            child: SizedBox(
              height: 80,
              child: Banner(
                message: 'NEW',
                location: BannerLocation.topEnd,
                color: Colors.red,
                child: Container(
                  color: Colors.grey.shade100,
                  child: const Center(child: Text('Banner Container')),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Progress Indicators'),
          WidgetCard(
            title: 'CircularProgressIndicator',
            widgetName: 'CircularProgressIndicator',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CircularProgressIndicator(),
                CircularProgressIndicator(value: _progressValue),
                Text('${(_progressValue * 100).toStringAsFixed(0)}%'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'LinearProgressIndicator',
            widgetName: 'LinearProgressIndicator',
            child: Column(
              children: [
                const LinearProgressIndicator(),
                const SizedBox(height: 12),
                LinearProgressIndicator(value: _progressValue),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'RefreshIndicator',
            widgetName: 'RefreshIndicator',
            child: SizedBox(
              height: 150,
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 1));
                },
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, i) => ListTile(title: Text('Pull to refresh - Item ${i + 1}')),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Dialogs & Sheets'),
          WidgetCard(
            title: 'SnackBar',
            widgetName: 'SnackBar',
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Hello from SnackBar!'),
                    action: SnackBarAction(label: 'UNDO', onPressed: () {}),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('Show SnackBar'),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'AlertDialog',
            widgetName: 'Dialog',
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Alert Dialog'),
                    content: const Text('This is an AlertDialog.'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                      ElevatedButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK')),
                    ],
                  ),
                );
              },
              child: const Text('Open AlertDialog'),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'SimpleDialog',
            widgetName: 'SimpleDialog',
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => SimpleDialog(
                    title: const Text('Choose Option'),
                    children: [
                      SimpleDialogOption(onPressed: () => Navigator.pop(ctx), child: const Text('Option A')),
                      SimpleDialogOption(onPressed: () => Navigator.pop(ctx), child: const Text('Option B')),
                      SimpleDialogOption(onPressed: () => Navigator.pop(ctx), child: const Text('Option C')),
                    ],
                  ),
                );
              },
              child: const Text('Open SimpleDialog'),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'BottomSheet',
            widgetName: 'BottomSheet',
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (ctx) => SizedBox(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Modal Bottom Sheet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        ElevatedButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
                      ],
                    ),
                  ),
                );
              },
              child: const Text('Open BottomSheet'),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'DraggableScrollableSheet',
            widgetName: 'DraggableScrollableSheet',
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (ctx) => DraggableScrollableSheet(
                    expand: false,
                    initialChildSize: 0.4,
                    minChildSize: 0.2,
                    maxChildSize: 0.8,
                    builder: (ctx, sc) => ListView.builder(
                      controller: sc,
                      itemCount: 20,
                      itemBuilder: (c, i) => ListTile(title: Text('Item ${i + 1}')),
                    ),
                  ),
                );
              },
              child: const Text('Open DraggableScrollableSheet'),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'PopupMenuButton',
            widgetName: 'PopupMenuButton',
            child: PopupMenuButton<String>(
              onSelected: (v) {},
              itemBuilder: (ctx) => [
                const PopupMenuItem(value: 'Edit', child: Text('Edit')),
                const PopupMenuItem(value: 'Delete', child: Text('Delete')),
                const PopupMenuItem(value: 'Share', child: Text('Share')),
              ],
              child: Chip(
                label: const Text('Open Menu'),
                avatar: const Icon(Icons.arrow_drop_down),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Tabs & Navigation'),
          WidgetCard(
            title: 'TabBar + TabBarView',
            widgetName: 'TabBar',
            child: SizedBox(
              height: 150,
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    tabs: const [Tab(text: 'Tab 1'), Tab(text: 'Tab 2'), Tab(text: 'Tab 3')],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Container(color: Colors.blue.shade50, child: const Center(child: Text('Tab 1 Content'))),
                        Container(color: Colors.green.shade50, child: const Center(child: Text('Tab 2 Content'))),
                        Container(color: Colors.red.shade50, child: const Center(child: Text('Tab 3 Content'))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'NavigationBar',
            widgetName: 'NavigationBar',
            child: NavigationBar(
              selectedIndex: _navBarIndex,
              onDestinationSelected: (i) => setState(() => _navBarIndex = i),
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
                NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'NavigationRail',
            widgetName: 'NavigationRail',
            child: SizedBox(
              height: 200,
              child: Row(
                children: [
                  NavigationRail(
                    selectedIndex: _navBarIndex,
                    onDestinationSelected: (i) => setState(() => _navBarIndex = i),
                    labelType: NavigationRailLabelType.all,
                    destinations: const [
                      NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
                      NavigationRailDestination(icon: Icon(Icons.search), label: Text('Search')),
                      NavigationRailDestination(icon: Icon(Icons.person), label: Text('Profile')),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.grey.shade100,
                      child: const Center(child: Text('Main Content Area')),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Drawer',
            widgetName: 'Drawer',
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => Dialog(
                    child: SizedBox(
                      width: 280,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const DrawerHeader(
                            decoration: BoxDecoration(color: Colors.deepPurple),
                            child: Center(
                              child: Text('Drawer Header', style: TextStyle(color: Colors.white, fontSize: 18)),
                            ),
                          ),
                          const ListTile(leading: Icon(Icons.home), title: Text('Home')),
                          const ListTile(leading: Icon(Icons.settings), title: Text('Settings')),
                          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: const Text('Open Drawer Preview'),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'SelectionArea',
            widgetName: 'SelectionArea',
            child: const SelectionArea(
              child: Text(
                'Select this text by clicking and dragging!',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'SearchBar',
            widgetName: 'SearchBar',
            child: SearchBar(
              hintText: 'Search...',
              leading: const Icon(Icons.search),
              trailing: [
                IconButton(icon: const Icon(Icons.mic), onPressed: () {}),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
