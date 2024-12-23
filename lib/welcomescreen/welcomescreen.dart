import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Delay the navigation after 2 seconds
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, '/FormScreen');
    });

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          // Welcome text placed in the center
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/7),
              child: Center(
                child: Text(
                  'Welcome to Urdu Data Collection',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // Color of the spinner
            ),
          ),
          // The footer at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Powered by (UET RCET)',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
