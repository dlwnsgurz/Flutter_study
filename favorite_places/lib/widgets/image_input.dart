import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onSelectImage});
  final void Function(File image) onSelectImage;
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? selectedImage;
  void takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 600);

    if (pickedImage == null) return;
    setState(() {
      selectedImage = File(pickedImage.path);
    });

    widget.onSelectImage(selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = TextButton.icon(
      onPressed: takePicture,
      icon: const Icon(Icons.camera),
      label: const Text("Take Picture"),
    );
    if (selectedImage != null) {
      mainContent = GestureDetector(
        onTap: takePicture,
        child: Image.file(
          selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.onPrimary),
      ),
      alignment: Alignment.center,
      height: 250,
      child: mainContent,
    );
  }
}
