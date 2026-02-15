
import 'package:flutter/material.dart';
import 'package:reg_form/new_screen.dart';

void main() {
  runApp(const MyApp5());
}

class MyApp5 extends StatelessWidget {
  const MyApp5({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TextStyleDemo(),

      routes: {'/back': (context) => const SecondPage()},
    );
  }
}

class TextStyleDemo extends StatelessWidget {
  const TextStyleDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Text Styling")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              "Flutter Text Styling",
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationThickness: 2,
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

            SizedBox(height: 10),

            // Caption
            Text(
              "Build beautiful UI with ease",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 10),

            Text(
              "Hello There",
              style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
            ),

            SizedBox(height: 20),

            // Paragraph
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        "Flutter allows us to design attractive user interfaces ",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text:
                        "using widgets. Text styling helps improve readability ",
                    style: TextStyle(color: Colors.green),
                  ),
                  TextSpan(
                    text: "and user experience in mobile applications.",
                    style: TextStyle(color: Colors.orange),
                  ),
                ],
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/back',
                  (route) => false,
                );
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
