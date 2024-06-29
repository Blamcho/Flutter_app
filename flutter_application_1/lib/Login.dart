import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/SignUpScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as https;
import 'package:flutter_application_1/HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void ingresar(username , password) async {
    try {
      var url = 'https://api.tectorres.com/Login.php';
      var response = await https.post(
        Uri.parse(url),
        
        body: {
          "Usuario": username,
          "Contrasena": password,
        },
      ).timeout( const Duration(seconds: 90));
      var datos  = json.decode(response.body);
      
      if (response.body != '0') {
         Navigator.pushNamed(context, '/Home',
            arguments: {"username": username, "email": datos["email"]});
        FocusScope.of(context).unfocus();
         Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context){
            return HomeScreen(username: datos["usuario"], email: datos["email"], password: '', String: '',);})); 
      } else {
        print("Usuario incorrecto");
      } 
    } on TimeoutException {
      print('Error de conexión');
    } on Error catch (e) {
      print('Error en el servidor');
      print(e.toString());
    }
  }

  Future<void> _saveUserData(String username, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('username', username);
    await prefs.setString('email', email);
  }

  void _resetPassword() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Restablecer Contraseña'),
          content: const Text('Hemos enviado un correo de verificación para restablecer tu contraseña.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF171a21), // Color de fondo de Steam
        title: const Text('Login Screen', style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Color(0xFF1b2838), // Color de fondo principal de Steam
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Color(0xFF66c0f4), // Azul de Steam
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Center(
                    child: Image.asset(
                      'images/LOGO3.jpg',
                      width: 120,
                      height: 120,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              TextField(
                controller: _usernameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Color(0xFF66c0f4)),
                  filled: true,
                  fillColor: Color(0xFF2a475e), // Color de fondo de input de Steam
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Color(0xFF66c0f4)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Color(0xFF66c0f4)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Color(0xFF66c0f4)),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Color(0xFF66c0f4)),
                  filled: true,
                  fillColor: Color(0xFF2a475e),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Color(0xFF66c0f4)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Color(0xFF66c0f4)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Color(0xFF66c0f4)),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  String username = _usernameController.text;
                  String password = _passwordController.text;

                  if (username != 'Abraham' && password != 'p1307') {
                    ingresar(username, password);
                    await _saveUserData(username, 'abraham@example.com');
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Text('Error'),
                          content: Text('Invalid username or password.'),
                        );
                      },
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF5c7e10)), // Verde de Steam
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: _resetPassword,
                child: Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(color: Color(0xFF66c0f4)),
                ),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpScreen()),
                  );
                },
                child: Text(
                  'Create Account',
                  style: TextStyle(color: Color(0xFF66c0f4)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}