import 'package:fav_spots/providers/user_spots_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewSpotScreen extends ConsumerStatefulWidget {
  const AddNewSpotScreen({super.key});

  @override
  ConsumerState<AddNewSpotScreen> createState() {
    return _AddNewSpotScreenState();
  }
}

class _AddNewSpotScreenState extends ConsumerState<AddNewSpotScreen> {
  final _titleController = TextEditingController();

  void _saveSpot() {
    final enteredTitle = _titleController.text;

    //TODO show error dialog
    if (enteredTitle.isEmpty) {
      return;
    }

    ref.read(userSpotsProvider.notifier).addSpot(enteredTitle);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Spot'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _saveSpot,
              icon: const Icon(Icons.add),
              label: const Text('Add Spot'),
            ),
          ],
        ),
      ),
    );
  }
}
