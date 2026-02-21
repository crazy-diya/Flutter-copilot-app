import 'package:flutter/material.dart';
import '../widgets/widget_card.dart';
import '../widgets/section_header.dart';

class InputWidgetsScreen extends StatefulWidget {
  const InputWidgetsScreen({super.key});

  @override
  State<InputWidgetsScreen> createState() => _InputWidgetsScreenState();
}

class _InputWidgetsScreenState extends State<InputWidgetsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  String _autocompleteResult = '';
  String _formResult = '';

  static const List<String> _fruits = [
    'Apple', 'Apricot', 'Banana', 'Blueberry', 'Cherry',
    'Date', 'Elderberry', 'Fig', 'Grape', 'Kiwi',
    'Lemon', 'Mango', 'Orange', 'Papaya', 'Peach',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Widgets'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0288D1), Color(0xFF4FC3F7)],
            ),
          ),
        ),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(title: 'TextField Variants'),
          WidgetCard(
            title: 'TextField',
            widgetName: 'TextField',
            child: Column(
              children: [
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Outlined',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 12),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Filled',
                    filled: true,
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 12),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Underline',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.visibility),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Form & Validation'),
          WidgetCard(
            title: 'TextFormField',
            widgetName: 'TextFormField',
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Email required';
                    if (!v.contains('@')) return 'Invalid email';
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'Form with Validation',
            widgetName: 'Form',
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name *',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => (v == null || v.isEmpty)
                        ? 'Name is required'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocus,
                    decoration: const InputDecoration(
                      labelText: 'Email *',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Email required';
                      if (!v.contains('@')) return 'Invalid email format';
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() => _formResult =
                            'Form valid! Name: ${_nameController.text}');
                      }
                    },
                    child: const Text('Submit Form'),
                  ),
                  if (_formResult.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(_formResult,
                        style: const TextStyle(color: Colors.green)),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SectionHeader(title: 'Autocomplete'),
          WidgetCard(
            title: 'Autocomplete',
            widgetName: 'Autocomplete',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Autocomplete<String>(
                  optionsBuilder: (textEditingValue) {
                    if (textEditingValue.text.isEmpty) return const [];
                    return _fruits.where((fruit) => fruit
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase()));
                  },
                  onSelected: (selection) =>
                      setState(() => _autocompleteResult = selection),
                  fieldViewBuilder:
                      (ctx, controller, focusNode, onSubmitted) =>
                          TextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      labelText: 'Type a fruit...',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.local_florist),
                    ),
                  ),
                ),
                if (_autocompleteResult.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text('Selected: $_autocompleteResult',
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold)),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'RawAutocomplete',
            widgetName: 'RawAutocomplete',
            child: RawAutocomplete<String>(
              optionsBuilder: (textEditingValue) => textEditingValue.text.isEmpty
                  ? const Iterable<String>.empty()
                  : _fruits.where((f) => f
                      .toLowerCase()
                      .startsWith(textEditingValue.text.toLowerCase())),
              optionsViewBuilder: (ctx, onSelected, options) => Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4,
                  child: SizedBox(
                    width: 200,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (ctx, i) => ListTile(
                        title: Text(options.elementAt(i)),
                        onTap: () => onSelected(options.elementAt(i)),
                      ),
                    ),
                  ),
                ),
              ),
              fieldViewBuilder:
                  (ctx, controller, focusNode, onSubmitted) =>
                      TextField(
                controller: controller,
                focusNode: focusNode,
                decoration: const InputDecoration(
                  labelText: 'RawAutocomplete',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          WidgetCard(
            title: 'AutofillGroup',
            widgetName: 'AutofillGroup',
            child: AutofillGroup(
              child: Column(
                children: const [
                  TextField(
                    autofillHints: [AutofillHints.email],
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 12),
                  TextField(
                    autofillHints: [AutofillHints.password],
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
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
