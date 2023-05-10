import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Enter your data!";

  void _resetFields() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _infoText = "Enter your data!";
    });
  }

  void calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      print(imc);
      if (imc < 18.5) {
        _infoText = "Under weight (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.5 && imc < 25) {
        _infoText = "Normal weight (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 25 && imc < 30) {
        _infoText = "Overweight (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 30 && imc < 35) {
        _infoText = "Grade 1 obesity ${imc.toStringAsPrecision(3)})";
      } else if (imc >= 35 && imc < 40) {
        _infoText = "Grade 2 obesity (${imc.toStringAsPrecision(3)})";
      } else {
        _infoText = "Grade 3 obesity (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI calculator"),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
        actions: [
          IconButton(onPressed: _resetFields, icon: const Icon(Icons.refresh))
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.all(50),
              child: Icon(
                Icons.person_outlined,
                size: 150,
                color: Colors.orangeAccent,
              ),
            ),
            Flexible(
              flex: 10,
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: TextFormField(
                  controller: weightController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your weight!";
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Weight (kg)",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black
                          .withOpacity(0.5), // Define o texto como opaco
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black, // Define a cor do texto
                  ),
                ),
              ),
            ),
            const Spacer(),
            Flexible(
              flex: 10,
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: TextFormField(
                  controller: heightController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your height";
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Height (Cm)",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState != null && _formKey.currentState!.validate()){
                    calculate();
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                    const Size(0, 50),
                  ),
                ),
                child: const Text('Calculate'),
              ),

            ),
            const Spacer(
              flex: 8,
            ),
            Text(
              _infoText,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.orangeAccent, fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
