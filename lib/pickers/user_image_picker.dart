import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker(
      {required this.pickImagFn, required this.deviceSize, Key? key})
      : super(key: key);
  final double deviceSize;
  final void Function(File pickedImage) pickImagFn;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  void pickImage() async {
    // ignore: invalid_use_of_visible_for_testing_member
    final pickedImageFile = await ImagePicker.platform.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 150,
        maxWidth: 150);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
      widget.pickImagFn(_pickedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: pickImage,
      child: CircleAvatar(
        backgroundImage: _pickedImage != null ? FileImage(_pickedImage!) : null,
        radius: widget.deviceSize/2,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
