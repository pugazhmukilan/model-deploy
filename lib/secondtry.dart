import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';


class Secondtry extends StatefulWidget {
  @override
  _SecondtryState createState() => _SecondtryState();
}

class _SecondtryState extends State<Secondtry> {
  Interpreter? interpreter;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    try {
      interpreter = await Interpreter.fromAsset('assets/model.tflite');
      print('Model loaded successfully');
    } catch (e) {
      print('Failed to load model: $e');
    }
  }

  Future<String> classifyImage(String imagePath) async {
    // Load and preprocess the image
    Uint8List imageBytes = (await rootBundle.load(imagePath)).buffer.asUint8List();
    // You might need to resize, normalize, or preprocess the image further depending on the requirements of your model

    // Perform inference
    var inputs = [imageBytes];
    var outputs = List.filled(1, <double>[]); // We expect a single output, a list of doubles
    interpreter!.run(inputs, outputs);

    // Post-process the output
    String result = utf8.decode(outputs[0].map((e) => e.round()).toList());
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Classification Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Example usage
            String result = await classifyImage('assets/leaf_1.jpg'); // Replace 'assets/image.jpg' with the path to your image
            print('Classification result: $result');
          },
          child: Text('Classify Image'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    interpreter?.close();
    super.dispose();
  }
}
