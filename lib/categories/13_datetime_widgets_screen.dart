import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/widget_card.dart';
import '../widgets/section_header.dart';

class DateTimeWidgetsScreen extends StatefulWidget {
  const DateTimeWidgetsScreen({super.key});

  @override
  State<DateTimeWidgetsScreen> createState() => _DateTimeWidgetsScreenState();
}

class _DateTimeWidgetsScreenState extends State<DateTimeWidgetsScreen> {
  DateTime? _pickedDate;
  TimeOfDay? _pickedTime;
  DateTimeRange? _pickedRange;
  DateTime _calendarDate = DateTime.now();
  DateTime _cupertinoDate = DateTime.now();
  Duration _cupertinoTimer = Duration.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date & Time'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF827717), Color(0xFFD4E157)],
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(title: 'Material Date & Time'),
          WidgetCard(
            title: 'showDatePicker',
            widgetName: 'showDatePicker',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (date != null) setState(() => _pickedDate = date);
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Pick Date'),
                ),
                if (_pickedDate != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Selected: ${_pickedDate!.year}-${_pickedDate!.month.toString().padLeft(2, '0')}-${_pickedDate!.day.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'showTimePicker',
            widgetName: 'showTimePicker',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) setState(() => _pickedTime = time);
                  },
                  icon: const Icon(Icons.access_time),
                  label: const Text('Pick Time'),
                ),
                if (_pickedTime != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Selected: ${_pickedTime!.format(context)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'showDateRangePicker',
            widgetName: 'showDateRangePicker',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final range = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                      initialDateRange: DateTimeRange(
                        start: DateTime.now(),
                        end: DateTime.now().add(const Duration(days: 7)),
                      ),
                    );
                    if (range != null) setState(() => _pickedRange = range);
                  },
                  icon: const Icon(Icons.date_range),
                  label: const Text('Pick Date Range'),
                ),
                if (_pickedRange != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'From: ${_pickedRange!.start.month}/${_pickedRange!.start.day} '
                      'To: ${_pickedRange!.end.month}/${_pickedRange!.end.day}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'CalendarDatePicker',
            widgetName: 'CalendarDatePicker',
            child: CalendarDatePicker(
              initialDate: _calendarDate,
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
              onDateChanged: (d) => setState(() => _calendarDate = d),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Cupertino Date & Time'),
          WidgetCard(
            title: 'CupertinoDatePicker',
            widgetName: 'CupertinoDatePicker',
            child: SizedBox(
              height: 150,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                initialDateTime: _cupertinoDate,
                onDateTimeChanged: (d) => setState(() => _cupertinoDate = d),
                use24hFormat: false,
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'CupertinoTimerPicker',
            widgetName: 'CupertinoTimerPicker',
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                  child: CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.hms,
                    initialTimerDuration: _cupertinoTimer,
                    onTimerDurationChanged: (d) =>
                        setState(() => _cupertinoTimer = d),
                  ),
                ),
                Text(
                  'Timer: ${_cupertinoTimer.inHours}h '
                  '${_cupertinoTimer.inMinutes.remainder(60)}m '
                  '${_cupertinoTimer.inSeconds.remainder(60)}s',
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
