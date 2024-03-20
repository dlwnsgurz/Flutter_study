import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.onPrimary),
      ),
      alignment: Alignment.center,
      height: 250,
      child: TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.camera),
          label: const Text("Take Picture")),
    );
  }
}
