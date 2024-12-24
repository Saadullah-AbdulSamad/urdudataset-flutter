import 'package:flutter/material.dart';
import 'package:urdudatasetcollection/drawing/drawingscreen.dart';

class CompactFormScreen extends StatefulWidget {
  const CompactFormScreen({super.key});

  @override
  State<CompactFormScreen> createState() => _CompactFormScreenState();
}

class _CompactFormScreenState extends State<CompactFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String registrationNumber = '';
  String? _wordsValue;
  List<String> words = [
    '1 letter',
    '3 letters',
    '2 letters',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Urdu Data Collection',
            style: TextStyle(color: Colors.white)),
        leading: const Icon(Icons.local_florist, color: Colors.white),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  initialValue: registrationNumber,
                  decoration: const InputDecoration(
                    labelText: 'Enter your registration number (*)',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your registration number';
                    }
                    final regex = RegExp(r'20[12]\d-[a-zA-Z]{2}-\d{3}');
                    if (!regex.hasMatch(value)) {
                      return 'Please enter a valid registration number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    registrationNumber = value;
                  },
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 38, right: 38),
                  child: Column(
                    children: [
                      const Text('Select option (*)',
                          style: TextStyle(fontSize: 15)),
                      DropdownButtonFormField<String>(
                        value: _wordsValue,
                        decoration: const InputDecoration(
                          labelText: 'Select one option (*)',
                        ),
                        items: words.map((words) {
                          return DropdownMenuItem<String>(
                            value: words,
                            child: Text(words),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _wordsValue = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your qualification';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Validate form before navigation
                    if (_formKey.currentState!.validate()) {
                      // All fields are filled, navigate
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DrawingScreen(
                            userID: registrationNumber,
                            words: _wordsValue,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
