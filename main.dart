import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main () async
{
  runApp(MaterialApp(
    home: Page(),
  ));
}

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {

  final idController = TextEditingController();
  int ID;
  String Nome = "Sem país com este ID";
  String Capital = "Sem Capital";

  void BuscarPais(String id) async
  {
    if(id == null || id == "")
      {
        setState(() {
          Nome = "Sem país com este ID";
          Capital = "Sem Capital";
        });
      }
    else{
      List<dynamic> data = await GetData(id);
      setState(() {
        Nome = data[0]["name"];
        Capital = data[0]["capital"];
      });
    }
  }

  Future<List<dynamic>> GetData(String ID) async
  {
    http.Response resposta = await http.get("http://192.168.100.15:3000/countries/$ID");
    return json.decode(resposta.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Países", style: TextStyle(fontSize: 23.0),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 60.0, top: 10.0, right: 60.0, bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: idController,
                decoration: InputDecoration(
                  labelText: "Insira ID",
                  labelStyle: TextStyle(color: Colors.black26, fontSize: 24.0),
                ),
                style: TextStyle(fontSize: 25.0),
                keyboardType: TextInputType.number,
                onChanged: BuscarPais,
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
                child: Text(
                  "Nome: $Nome",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 22.0),
                ),
              ),
              Text(
                "Capital: $Capital",
                style: TextStyle(color: Colors.blueGrey, fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
