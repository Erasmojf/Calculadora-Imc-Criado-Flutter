import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _infoText = 'Informe seus dados';
  void _resetField() {
    heightController.text = '';
    weightController.text = '';
    setState(() {
      _infoText = 'Informe seus dados';
    });
  }

  void _caculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoText = 'Esta abaixo do Peso (${imc.toStringAsPrecision(2)})';
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = 'Esta com o peso ideal (${imc.toStringAsPrecision(2)})';
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText =
            'Esta levimente acima do peso ideal (${imc.toStringAsPrecision(2)})';
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = 'Obesidade Grau I (${imc.toStringAsPrecision(2)})';
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = 'Obsidade Grau II (${imc.toStringAsPrecision(2)})';
      } else if (imc >= 40) {
        _infoText = 'Obsidade Grau III (${imc.toStringAsPrecision(2)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            'Cacular IMC',
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetField,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.person_outline,
                  size: 120,
                  color: Colors.green,
                ),
                TextFormField(
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Insira o seu peso';
                    }
                  },
                  keyboardType: TextInputType.number,
                  controller: weightController,
                  decoration: InputDecoration(
                    labelText: 'Peso (Kg)',
                    labelStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 22.0,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                TextFormField(
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Insira sua altura';
                    }
                  },
                  keyboardType: TextInputType.number,
                  controller: heightController,
                  decoration: InputDecoration(
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 22.0,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      color: Colors.green,
                      child: Text(
                        'Cacular',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          _caculate();
                        }
                      },
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ));
  }
}
