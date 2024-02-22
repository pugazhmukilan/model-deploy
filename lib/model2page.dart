import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class TextClassificationPage extends StatefulWidget {
  @override
  _TextClassificationPageState createState() => _TextClassificationPageState();
}

class _TextClassificationPageState extends State<TextClassificationPage> {
  Interpreter? _interpreter;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    _interpreter = await Interpreter.fromAsset('your_model.tflite');
    setState(() {}); // Trigger a rebuild once the model is loaded
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Classification'),
      ),
      body: _interpreter == null
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: ElevatedButton(
                onPressed: () {
                  // Example inference
                  List<List<double>> input = [[1.0, 2.0, 3.0]]; // Example input data
                  var output = List.filled(1, List.filled(3, 0.0));
                  _interpreter?.run(input, output);
                  print('Output: $output');
                },
                child: Text('Run Inference'),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }
}
