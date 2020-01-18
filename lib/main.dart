import 'package:flutter/material.dart';
import 'dart:math';

void main(){
  runApp(MaterialApp(
    home: Home()
    ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _infoText = "Informe os seus dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text)/100;
      double imc = weight/pow(height, 2);

      String imcPrecision = imc.toStringAsPrecision(2);

      if(imc < 18.6){
        _infoText = "Abaixo do peso (IMC $imcPrecision)";
      } else if(imc >= 18.6 && imc < 24.9){
        _infoText = "Peso ideal (IMC $imcPrecision)";
      } else if(imc >= 24.9 && imc < 29.9){
        _infoText = "Levemente acima do peso (IMC $imcPrecision)";
      } else if(imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade grau I (IMC $imcPrecision)";
      } else if(imc >= 34.9 && imc < 39.9){
        _infoText = "Obesidade grau II (IMC $imcPrecision)";
      } else {
        _infoText = "Obesidade grau III (IMC $imcPrecision)";
      }      
    });
    
  }

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe os seus dados";
      _formKey = GlobalKey<FormState>();
    });    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          ),
        ],
      ),
      backgroundColor:Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(Icons.person_outline, size: 120, color: Colors.green),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Peso (Kg)',
              labelStyle: TextStyle(color: Colors.green)
            ),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontSize: 18.0),
            controller: weightController,
            validator: (value){
              if(value.isEmpty){
                return "Insira seu peso!";
              }
            },
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Altura (cm)',
              labelStyle: TextStyle(color: Colors.green)
            ),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontSize: 18.0),
            controller: heightController,
            validator: (value){
              if(value.isEmpty){
                return "Insira sua altura!";
              }
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Container(
            height: 50.0,
            child: RaisedButton(
              textColor: Colors.white,                
              onPressed: (){
                if(_formKey.currentState.validate()){
                  _calculate();
                }
              },
              child: Text('Calcular', style: TextStyle(fontSize: 18.0),),
              color: Colors.green,
            ),
          ),
          ),
          Text(_infoText,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.green, fontSize: 18.0),
          )
        ],
      ),
        ),
      )
    );
  }
}