
import 'package:flutter/material.dart';
import 'package:reg_form/datapassing.dart';
import 'package:reg_form/lib/animation.dart';
import 'package:reg_form/styling.dart';
import 'package:reg_form/theme.dart';
import 'namedrouting.dart';

void main() {
  runApp(const MyApp1());
}

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
      routes: {'/back': (context) => FirstPage()},
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FirstPage'), backgroundColor: Colors.blue),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.black,
          ),

          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return SecondPage();
                },
              ),
            );
          },
          child: Text('ClickMe'),
        ),
      ),
      backgroundColor: Colors.red,
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Page'), backgroundColor: Colors.cyan),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return MyApp();
                    },
                  ),
                );
              },
              child: Text('Named Routing'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return MyApp2();
                    },
                  ),
                );
              },
              child: Text('Data Passing'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return MyApp3();
                    },
                  ),
                );
              },
              child: Text('Animation'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return MyApp4();
                    },
                  ),
                );
              },
              child: Text('Theme'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return MyApp5();
                    },
                  ),
                );
              },
              child: Text('Styling'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Click Me'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return NewPage();
                    },
                  ),
                );
              },
              child: Text('Text'),
            ),
          ],
        ),
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Newscreen')),
      body: Center(
        child: Column(
          children: [
            Text(
              'hello',
              style: TextStyle(
                color: Colors.red,
                decoration: TextDecoration.underline,
                decorationThickness: 2,
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
              child: Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}
