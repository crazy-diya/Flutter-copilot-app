import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/widget_card.dart';
import '../widgets/section_header.dart';

class CupertinoWidgetsScreen extends StatefulWidget {
  const CupertinoWidgetsScreen({super.key});

  @override
  State<CupertinoWidgetsScreen> createState() => _CupertinoWidgetsScreenState();
}

class _CupertinoWidgetsScreenState extends State<CupertinoWidgetsScreen> {
  bool _cupertinoSwitch = false;
  double _cupertinoSlider = 0.5;
  int _pickerIndex = 0;
  int _segmentIndex = 0;
  DateTime _selectedDate = DateTime.now();
  bool _cupertinoCheck = false;

  final List<String> _fruits = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cupertino (iOS)'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE64A19), Color(0xFFFF8A65)],
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(title: 'iOS Buttons'),
          WidgetCard(
            title: 'CupertinoButton',
            widgetName: 'CupertinoButton',
            child: CupertinoButton(
              onPressed: () {},
              child: const Text('iOS Button'),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'CupertinoButton.filled',
            widgetName: 'CupertinoButton.filled',
            child: CupertinoButton.filled(
              onPressed: () {},
              child: const Text('Filled iOS Button'),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'iOS Form Controls'),
          WidgetCard(
            title: 'CupertinoTextField',
            widgetName: 'CupertinoTextField',
            child: const CupertinoTextField(
              placeholder: 'Enter text (iOS style)',
              padding: EdgeInsets.all(12),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'CupertinoSwitch',
            widgetName: 'CupertinoSwitch',
            child: Row(
              children: [
                CupertinoSwitch(
                  value: _cupertinoSwitch,
                  onChanged: (v) => setState(() => _cupertinoSwitch = v),
                ),
                const SizedBox(width: 12),
                Text(_cupertinoSwitch ? 'ON' : 'OFF'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'CupertinoSlider',
            widgetName: 'CupertinoSlider',
            child: Column(
              children: [
                CupertinoSlider(
                  value: _cupertinoSlider,
                  onChanged: (v) => setState(() => _cupertinoSlider = v),
                ),
                Text('Value: ${(_cupertinoSlider * 100).toStringAsFixed(0)}%'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'CupertinoCheckbox',
            widgetName: 'CupertinoCheckbox',
            child: Row(
              children: [
                CupertinoCheckbox(
                  value: _cupertinoCheck,
                  onChanged: (v) => setState(() => _cupertinoCheck = v!),
                ),
                const SizedBox(width: 8),
                const Text('iOS Checkbox'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'iOS Pickers'),
          WidgetCard(
            title: 'CupertinoPicker',
            widgetName: 'CupertinoPicker',
            child: SizedBox(
              height: 120,
              child: CupertinoPicker(
                itemExtent: 32,
                onSelectedItemChanged: (i) => setState(() => _pickerIndex = i),
                children: _fruits.map((f) => Center(child: Text(f))).toList(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'CupertinoSegmentedControl',
            widgetName: 'CupertinoSegmentedControl',
            child: CupertinoSegmentedControl<int>(
              groupValue: _segmentIndex,
              onValueChanged: (v) => setState(() => _segmentIndex = v),
              children: const {
                0: Padding(padding: EdgeInsets.all(8), child: Text('Day')),
                1: Padding(padding: EdgeInsets.all(8), child: Text('Week')),
                2: Padding(padding: EdgeInsets.all(8), child: Text('Month')),
              },
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'CupertinoDatePicker',
            widgetName: 'CupertinoDatePicker',
            child: SizedBox(
              height: 150,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _selectedDate,
                onDateTimeChanged: (d) => setState(() => _selectedDate = d),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'iOS Indicators & Dialogs'),
          WidgetCard(
            title: 'CupertinoActivityIndicator',
            widgetName: 'CupertinoActivityIndicator',
            child: const Center(
              child: CupertinoActivityIndicator(radius: 20),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'CupertinoAlertDialog',
            widgetName: 'CupertinoAlertDialog',
            child: CupertinoButton(
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (ctx) => CupertinoAlertDialog(
                    title: const Text('iOS Alert'),
                    content: const Text('This is a Cupertino alert dialog.'),
                    actions: [
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancel'),
                      ),
                      CupertinoDialogAction(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Open iOS Alert'),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'CupertinoActionSheet',
            widgetName: 'CupertinoActionSheet',
            child: CupertinoButton(
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (ctx) => CupertinoActionSheet(
                    title: const Text('Choose Action'),
                    message: const Text('Select an option below'),
                    actions: [
                      CupertinoActionSheetAction(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Take Photo'),
                      ),
                      CupertinoActionSheetAction(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Choose from Gallery'),
                      ),
                    ],
                    cancelButton: CupertinoActionSheetAction(
                      isDestructiveAction: true,
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                  ),
                );
              },
              child: const Text('Open Action Sheet'),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'CupertinoListTile',
            widgetName: 'CupertinoListTile',
            child: const CupertinoListTile(
              leading: Icon(CupertinoIcons.person),
              title: Text('iOS List Tile'),
              subtitle: Text('Cupertino style'),
              trailing: Icon(CupertinoIcons.forward),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'CupertinoNavigationBar',
            widgetName: 'CupertinoNavigationBar',
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const CupertinoNavigationBar(
                middle: Text('iOS Navigation Bar'),
                leading: Text('Back'),
                trailing: Icon(CupertinoIcons.add),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'CupertinoContextMenu',
            widgetName: 'CupertinoContextMenu',
            child: Center(
              child: CupertinoContextMenu(
                actions: [
                  CupertinoContextMenuAction(
                    onPressed: () => Navigator.pop(context),
                    trailingIcon: CupertinoIcons.heart,
                    child: const Text('Like'),
                  ),
                  CupertinoContextMenuAction(
                    onPressed: () => Navigator.pop(context),
                    trailingIcon: CupertinoIcons.share,
                    child: const Text('Share'),
                  ),
                ],
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.hand_point_left, size: 32),
                        Text('Long press', textAlign: TextAlign.center),
                      ],
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
