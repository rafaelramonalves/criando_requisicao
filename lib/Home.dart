import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _resultado="";
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço web"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
           TextField(
            decoration: InputDecoration(
              labelText: "Digite o número do cep",
              icon: Icon(Icons.looks_one)
            ) ,
            keyboardType: TextInputType.number,
             controller: controller,
           ),
            RaisedButton(
              child: Text("Clique aqui"),
              onPressed: recuperarCep,
            ),
            Text(_resultado),
          ],
        ),
      ),
    );
  }

  recuperarCep() async {
    String CEP=controller.text;
    String url="http://viacep.com.br/ws/$CEP/json/";
    http.Response response;
    response = await http.get(url);
    print("Codigo de retorno: ${response.statusCode.toString()}");

    Map<String,dynamic> retornoUrl = json.decode(response.body);
    String logradouro = retornoUrl["logradouro"];
    String complemento = retornoUrl["complemento"];
    String bairro = retornoUrl["bairro"];
    String localidade = retornoUrl["localidade"];

    print("~ Endereço ~\n"
        "Logradouro: $logradouro \n"
        "Complemento: $complemento \n"
        "Bairro: $bairro \n"
        "Localidade: $localidade");

   // print("Resposta: ${response.body}");
    setState(() {
      _resultado = "~ Endereço ~\n"
          "Logradouro: $logradouro \n"
          "Complemento: ${complemento.isEmpty ? "Sem complemento" : "$complemento"} \n"
          "Bairro: $bairro \n"
          "Localidade: $localidade";
    });
  }
}
