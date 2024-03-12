import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:myappflutter/components/MyImagePickerApp.dart';

class GeminiWork extends StatelessWidget {
  const GeminiWork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generative Model Demo',
      home: MyGenerativePage(),
    );
  }
}

class MyGenerativePage extends StatefulWidget {
  final File? image; // Pass the image file as a parameter

  MyGenerativePage({Key? key, this.image}) : super(key: key);

  @override
  _MyGenerativePageState createState() => _MyGenerativePageState();
}

class _MyGenerativePageState extends State<MyGenerativePage> {
  Future<void> generateResponse() async {
    if (widget.image == null) {
      // Handle case where image is not selected
      return;
    }

    final model = GenerativeModel(
      model: 'gemini-pro-vision',
      apiKey: 'AIzaSyDQqEWt9KFtbEtSRYgipFkWO7t30nMKdKo',
    );
    const prompt = 'Do these look store-bought or homemade?';
    final imageBytes = await widget.image!.readAsBytes();

    final content = [
      Content.multi([
        TextPart(prompt),
        DataPart('image/png', imageBytes),
      ])
    ];

    final response = await model.generateContent(content);
    print(response.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generative Model Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: generateResponse,
          child: Text('Generate Response'),
        ),
      ),
    );
  }
}
