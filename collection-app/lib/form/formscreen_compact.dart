import 'dart:math';

import 'package:flutter/material.dart';
import 'package:urdudatasetcollection/drawing/drawingscreen.dart';

class CompactFormScreen extends StatefulWidget {
  const CompactFormScreen({super.key});

  @override
  State<CompactFormScreen> createState() => _CompactFormScreenState();
}

class _CompactFormScreenState extends State<CompactFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController regNumberController = TextEditingController();
  String? _wordsValue;



  @override
  void dispose() {
    nameController.dispose();
    regNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

    // Set a default value for _wordsValue (can be any value from the 'words' list)


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Urdu Data Collection',
            style: TextStyle(color: Colors.white)),
        leading: const Icon(Icons.local_florist, color: Colors.white),
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            margin: EdgeInsets.all(min(screenSize.width / 10, 100)),
            padding: const EdgeInsets.all(30),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Enter Details", style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  Focus(
                    onFocusChange: (hasFocus) {
                      if (!hasFocus &&
                          (nameController.text.isEmpty ||
                              nameController.text.trim().isEmpty)) {
                        nameController.text = 'Hafiz Abdul Samad';
                      }
                    },
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Enter Full Name (*)',
                        hintText: 'Hafiz Abdul Samad',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Full Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Focus(
                    onFocusChange: (hasFocus) {
                      if (!hasFocus &&
                          (regNumberController.text.isEmpty ||
                              regNumberController.text.trim().isEmpty)) {
                        regNumberController.text = '2021-bscs-433';
                      }
                    },
                    child: TextFormField(
                      controller: regNumberController,
                      decoration: InputDecoration(
                        labelText: screenSize.width / 10 < 40
                            ? 'Enter your Reg#'
                            : 'Enter your registration number (*)',
                        hintText: '2021-bscs-433',
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your registration number';
                        }
                        final regex =
                            RegExp(r'20[12]\d-[a-zA-Z]{2}|[a-zA-Z]{4}-\d{3}');
                        if (!regex.hasMatch(value)) {
                          return 'Please enter a valid registration number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.black87),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DrawingScreen(
                              userID: regNumberController.text,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
