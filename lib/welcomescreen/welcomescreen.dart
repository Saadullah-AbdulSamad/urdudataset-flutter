import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    // Delay the navigation after 2 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return; // Ensure the widget is still in the widget tree
      Navigator.pushReplacementNamed(context, '/FormScreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          // Welcome text placed in the center
          Expanded(
            child: Container(
              padding:
                  EdgeInsets.only(left: MediaQuery.of(context).size.width / 7),
              child: const Center(
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
              valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white), // Color of the spinner
            ),
          ),
          // The footer at the bottom
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(20.0),
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
