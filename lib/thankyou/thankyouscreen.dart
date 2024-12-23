import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urdudatasetcollection/form/formscreen.dart';

class ThankyouScreen extends StatefulWidget {
  const ThankyouScreen({super.key});

  @override
  _ThankyouScreenState createState() => _ThankyouScreenState();
}

class _ThankyouScreenState extends State<ThankyouScreen> {
  bool drawingComplete = false; // To simulate the drawing completion
  bool isSaving = false; // To simulate saving process

  // Function to simulate drawing completion
  void markDrawingComplete() {
    setState(() {
      drawingComplete = true;
      isSaving = true; // Start saving process
    });

    // Display the thank you message for 2 seconds, then navigate to FormScreen
    Future.delayed(Duration(seconds: 2), () {
      // Navigate to FormScreen and remove all previous screens from the stack
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => FormScreen()), // Replace with your home screen widget
            (Route<dynamic> route) => false, // This removes all previous routes
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thank You"),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: drawingComplete
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 100.0,
            ),
            SizedBox(height: 20),
            Text(
              "تمام اردو حروف کامیابی کے ساتھ محفوظ ہو گئے ہیں!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              "شکریہ! آپ کی محنت کا شکریہ ادا کرتے ہیں",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSaving
                ? CircularProgressIndicator(
              color: Colors.black87,
            )
                : Container(),
            SizedBox(height: 20),
            Text(
              "آپ کا اردو حروف کی ڈرائنگ محفوظ ہونے کا انتظار کر رہے ہیں...",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: markDrawingComplete,
              child: Text("محفوظ کریں"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
