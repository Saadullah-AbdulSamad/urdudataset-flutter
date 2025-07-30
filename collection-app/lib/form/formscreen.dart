import 'package:flutter/material.dart';
import 'package:urdudatasetcollection/drawing/drawingscreen.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _gender, _dominantHand = 'Right', _writingHand = 'Right';
  String registrationNumber = '';
  String? _selectedCountry = 'Pakistan',
      _selectedCity,
      _selectedQualification = 'Undergraduate',_wordsValue;
  List<String> _cities = []; // List of cities based on selected country

  // Example country and city data
  Map<String, List<String>> countryCities = {
    'Pakistan': [
      'Lahore', 'Faisalabad', 'Rawalpindi', 'Multan', 'Gujranwala', 'Bahawalpur', 'Sargodha', 'Sialkot', 'Sheikhupura',
      'Jhelum', 'Kasur', 'Mianwali', 'Rahim Yar Khan', 'Dera Ghazi Khan', 'Vehari', 'Karachi', 'Hyderabad', 'Sukkur',
      'Larkana', 'Nawabshah', 'Mirpur Khas', 'Jacobabad', 'Khairpur', 'Peshawar', 'Abbottabad', 'Mardan', 'Swat (Mingora)',
      'Dera Ismail Khan', 'Kohat', 'Bannu', 'Mansehra', 'Quetta', 'Gwadar', 'Turbat', 'Khuzdar', 'Sibi', 'Lasbela',
      'Chaman', 'Panjgur', 'Muzaffarabad', 'Mirpur', 'Rawalakot', 'Bagh', 'Kotli', 'Bhimber', 'Gilgit', 'Skardu',
      'Hunza', 'Chilas', 'Ghanche', 'Islamabad'
    ],
    'India': [
      'Delhi', 'Mumbai', 'Bangalore', 'Chennai', 'Kolkata', 'Hyderabad', 'Ahmedabad', 'Pune', 'Jaipur', 'Lucknow',
      'Kanpur', 'Nagpur', 'Indore', 'Thane', 'Bhopal', 'Visakhapatnam', 'Patna', 'Vadodara', 'Ghaziabad', 'Ludhiana',
      'Agra', 'Nashik', 'Faridabad', 'Meerut', 'Rajkot', 'Kalyan', 'Varanasi', 'Srinagar', 'Amritsar', 'Allahabad',
      'Ranchi', 'Coimbatore', 'Gwalior', 'Jodhpur', 'Chandigarh', 'Guwahati', 'Solapur', 'Hubli-Dharwad', 'Mysore',
      'Tiruchirappalli', 'Bareilly', 'Aligarh', 'Jalandhar', 'Bhubaneswar', 'Salem', 'Warangal', 'Guntur', 'Bhiwandi'
    ],
    'USA': ['New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix', 'Philadelphia', 'San Antonio', 'San Diego', 'Dallas', 'San Jose'],
    'Canada': ['Toronto', 'Vancouver', 'Montreal', 'Calgary', 'Ottawa', 'Edmonton', 'Quebec City', 'Winnipeg', 'Hamilton', 'Kitchener']
  };
  List<String> qualifications = [
    'High School',
    'Undergraduate',
    'Graduate',
    'Postgraduate',
    'PhD'
  ];List<String> words = [
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
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Enter your full Name (*)',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
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
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Age (*)',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Phone No.',
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 38, right: 38),
                  child: Column(
                    children: [
                      const Text('Country', style: TextStyle(fontSize: 15)),
                      DropdownButtonFormField<String>(
                        value: _selectedCountry,
                        decoration: const InputDecoration(
                          labelText: 'Select your Country (*)',
                        ),
                        items: countryCities.keys.map((country) {
                          return DropdownMenuItem<String>(
                            value: country,
                            child: Text(country),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCountry = value;
                            _selectedCity = countryCities[value]
                                ?[0]; // Reset city when country changes
                            _cities =
                                value != null ? countryCities[value]! : [];
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a country';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 38, right: 38),
                  child: Column(
                    children: [
                      const Text('City', style: TextStyle(fontSize: 15)),
                      DropdownButtonFormField<String>(
                        value: _selectedCity,
                        decoration: const InputDecoration(
                          labelText: 'Select your City (*)',
                        ),
                        items: _cities.map((city) {
                          return DropdownMenuItem<String>(
                            value: city,
                            child: Text(city),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCity = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a city';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
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
                Container(
                  padding: const EdgeInsets.only(left: 38, right: 38),
                  child: Column(
                    children: [
                      const Text('Qualification',
                          style: TextStyle(fontSize: 15)),
                      DropdownButtonFormField<String>(
                        value: _selectedQualification,
                        decoration: const InputDecoration(
                          labelText: 'Select your Qualification (*)',
                        ),
                        items: qualifications.map((qualification) {
                          return DropdownMenuItem<String>(
                            value: qualification,
                            child: Text(qualification),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedQualification = value;
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
                const Text('Gender', style: TextStyle(fontSize: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Radio(
                      value: 'Male',
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),
                    const Text('Male'),
                    Radio(
                      value: 'Female',
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value;
                        });
                      },
                    ),
                    const Text('Female'),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Dominant Hand', style: TextStyle(fontSize: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Radio(
                      value: 'Right',
                      groupValue: _dominantHand,
                      onChanged: (value) {
                        setState(() {
                          _dominantHand = value;
                        });
                      },
                    ),
                    const Text('Right'),
                    Radio(
                      value: 'Left',
                      groupValue: _dominantHand,
                      onChanged: (value) {
                        setState(() {
                          _dominantHand = value;
                        });
                      },
                    ),
                    const Text('Left'),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Writing Hand', style: TextStyle(fontSize: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Radio(
                      value: 'Right',
                      groupValue: _writingHand,
                      onChanged: (value) {
                        setState(() {
                          _writingHand = value;
                        });
                      },
                    ),
                    const Text('Right'),
                    Radio(
                      value: 'Left',
                      groupValue: _writingHand,
                      onChanged: (value) {
                        setState(() {
                          _writingHand = value;
                        });
                      },
                    ),
                    const Text('Left'),
                  ],
                ),
                const SizedBox(height: 40),
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
