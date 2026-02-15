
import 'package:flutter/material.dart';
import 'package:reg_form/new_screen.dart';

void main() {
  runApp(const MyApp2());
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FormScreen(),
      routes: {'/back': (context) => const SecondPage()},
    );
  }
}

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController _nameController = TextEditingController();
  String returnedData = "";

  Future<void> _goToResultScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(name: _nameController.text),
      ),
    );

    if (result != null) {
      setState(() {
        returnedData = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Screen")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Enter your name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _goToResultScreen,
              child: const Text("Submit"),
            ),
            const SizedBox(height: 20),
            Text(
              "Returned Data: $returnedData",
              style: const TextStyle(fontSize: 16),
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

class ResultScreen extends StatelessWidget {
  final String name;

  const ResultScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Result Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hello, $name!",
              style: const TextStyle(
                fontSize: 22,
                color: Colors.red,
                decoration: TextDecoration.underline,
              ),
            ),
            TextField(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, "Confirmed: $name");
              },
              child: const Text("Confirm & Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}
