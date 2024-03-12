import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyImagePickerApp extends StatefulWidget {
  @override
  _MyImagePickerAppState createState() => _MyImagePickerAppState();
}

class _MyImagePickerAppState extends State<MyImagePickerApp> {
  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Image Picker Example'),
        ),
        body: Center(
          child: GestureDetector(
            onTap: _getImage,
            child: Container(
              width: 200,
              height: 200,
              color: Colors.grey[200],
              child: _image != null
                  ? Image.file(
                      _image!,
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      Icons.camera_alt,
                      size: 100,
                      color: Colors.grey[400],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
