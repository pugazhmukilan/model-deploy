import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
late var value;
class deploy extends StatefulWidget {
  const deploy({super.key});

  @override
  State<deploy> createState() => _deployState();
}

class _deployState extends State<deploy> {

  Future loadmodel()async{
    //TODO:load the model here
    var modelFile = 'assets/model.tflite';

    var labelsFile = 'assets/labels.txt';

    await Tflite.loadModel(

    model: modelFile,

    labels: labelsFile,

  );
  }


  void predictmodel(String path)async{
    //TODO:prediect the mdoel here
    var output = await Tflite.runModelOnImage(

    path: path,

    numResults: 2,

    threshold: 0.5,

);
  print("=============PREDICTION===============");
  print('Predicted: ${output![0]['label']}');
  print("=============PREDICTION===============");
  value = output[0]['label'];
  setState(() {
    
  });
  }


  @override
  void initState(){
    super.initState();
    loadmodel();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(title:const Text("Model deployment"),
      ),

      body:Column(
        children: [
          ElevatedButton(
            onPressed: (){
              //CALL THE PREDICT FUNCTION ADN LOADING MODELS ALL OTHER THINDS GERE
              predictmodel("assets/leaf_1.jpg");
            },
            child:const Text("predict")
          ),



          Container(
            color:Colors.grey,
            child: Text(value.isempty? "no value":value,style:const TextStyle(fontFamily: "inter",fontWeight: FontWeight.w200,fontSize:10)),
          )
        ],
      ),
    );
  }
}