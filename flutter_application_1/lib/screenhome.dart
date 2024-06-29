import 'package:flutter/material.dart';

void main() {
 
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
late String usuario;
 late final String username;
  late final String email;

  MyApp({super.key});

 


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Screen App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the Home Screen!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Acción a realizar al presionar el botón
              },
              child: const Text('Click Me'),
            ),
          ],
        ),
      ),
    );
  }
}