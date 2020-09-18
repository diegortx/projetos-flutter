import 'package:flutter/material.dart';
void main(){
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields(){

    weightController.text = "";
    heightController.text = "";
    setState(() {
      _textInfo = "Informe seus dados";
    });
  }

 void _calculate(){
   setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);

      if(imc < 18.6){
        _textInfo = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if ( imc >= 18.6 && imc < 29.9){
         _textInfo = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      }else if ( imc >= 29.9 && imc < 34.9){
         _textInfo = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      }else if ( imc >= 34.9 && imc < 39.9){
         _textInfo = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      }else if ( imc >= 40 ){
         _textInfo = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
      
   });
 } 

  String _textInfo = "Informe seus dados";
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title          : Text('Calculadora IMC'),
        centerTitle    : true,
        backgroundColor: Colors.green,
        actions        : [
          IconButton(icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body           : SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child  : Form(
          key  : _formKey,
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children          : [
        Icon(Icons.person_outline, size: 120, color: Colors.green),
        TextFormField(keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText : 'Peso (kg)',
            labelStyle: TextStyle(color: Colors.green)
          ),
          textAlign : TextAlign.center,
          style     : TextStyle(color: Colors.green, fontSize: 25),
          controller: weightController,
          validator : (value) {
            if(value.isEmpty){
              return "Insira seu peso!";
            }
          },
        ),
        TextFormField(keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText : 'Altura (cm)',
            labelStyle: TextStyle(color: Colors.green)
          ),
          textAlign : TextAlign.center,
          style     : TextStyle(color: Colors.green, fontSize: 25),
          controller: heightController,
          validator : (value) {
            if(value.isEmpty){
              return "Insira sua altura!";
            }
          },
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child  : Container(
          height: 50,
          child : RaisedButton(
            onPressed: () {
              if(_formKey.currentState.validate()){
                _calculate(); 
              }
            },
            child    : Text('Calcular',
            style: TextStyle(color: Colors.white , fontSize: 25),),
            color: Colors.green,
          ),
        ),
        ),
        Text(
          _textInfo,
          textAlign: TextAlign.center,
          style    : TextStyle(color: Colors.green, fontSize: 25), )
      ],
      ),
        ),
      ),
    );
  }
}
