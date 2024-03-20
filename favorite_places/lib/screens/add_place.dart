import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _textController = TextEditingController();

  void _savePlace() {
    final enteredText = _textController.text;

    if (enteredText.isEmpty) {
      return;
    }

    ref.read(userPlacesProvider.notifier).addPlace(enteredText);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Place"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: "Title",
              ),
            ),
            const SizedBox(height: 10,)
            const ImageInput(),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text("Add Place"),
            ),
          ],
        ),
      ),
    );
  }
}
