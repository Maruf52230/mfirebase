import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';

class send extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firestore Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage1 extends StatefulWidget {
  @override
  _MyHomePage1State createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _capitalController = TextEditingController();
  TextEditingController _flagController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String country = _countryController.text.trim();
      String capital = _capitalController.text.trim();
      String flag = _flagController.text.trim();

      // Add data to Firestore
      await FirebaseFirestore.instance.collection('country').add({
        'name': country,
        'capital': capital,
        'flag': flag,
      });

      // Clear the text fields
      _countryController.clear();
      _capitalController.clear();
      _flagController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data added to Firestore')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Country'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _countryController,
                decoration: InputDecoration(labelText: 'Country Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a country name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _capitalController,
                decoration: InputDecoration(labelText: 'Capital'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a capital';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _flagController,
                decoration: InputDecoration(labelText: 'Flag'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a flag';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _countryController.dispose();
    _capitalController.dispose();
    _flagController.dispose();
    super.dispose();
  }
}
