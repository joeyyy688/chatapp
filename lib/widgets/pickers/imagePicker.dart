import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key}) : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  // set _imageFile(PickedFile? value) {
  //   _imageFileList = value == null ? null : [value];
  // }

  Future<void> _pickImage() async {
    PickedFile? pickedImage =
        await _picker.getImage(source: ImageSource.gallery);
    final File pickedImageFile = File(pickedImage!.path);
    setState(() {
      _imageFile = pickedImageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            backgroundImage:
                _imageFile != null ? FileImage(File(_imageFile!.path)) : null,
          ),
          TextButton.icon(
              onPressed: () {
                _pickImage();
              },
              icon: Icon(Icons.image),
              label: Text('Add image')),
        ],
      ),
    );
  }
}
