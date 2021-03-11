import 'dart:io';

import 'package:crud/data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _nameDeviceController = TextEditingController();
  final _eventController = TextEditingController();
  Uri _url = Uri.parse('https://apiproductorcesar.azurewebsites.net/api/Data');

  Future<String> _sendData() async {
    Data data = Data(
      eventDescription: _eventController.text,
      nameDevice: _nameDeviceController.text,
      eventDate: DateTime.now(),
    );
    final response = await http.post(
      _url,
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: dataToJson(data),
    );
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('CRUD'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //Campos
              TextField(
                controller: _nameDeviceController,
                decoration: InputDecoration(
                  labelText: 'NameDevice',
                ),
              ),
              TextField(
                controller: _eventController,
                decoration: InputDecoration(
                  labelText: 'Event',
                ),
              ),
              //Boton de enviar
              ElevatedButton(
                child: Text("Enviar Datos"),
                onPressed: () async {
                  String respuesta = await _sendData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(respuesta),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
