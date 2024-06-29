import 'package:flutter/material.dart';
import 'package:flutter_application_1/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();

  bool _isFormComplete = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nombreController.addListener(_checkFormCompletion);
    _apellidosController.addListener(_checkFormCompletion);
    _emailController.addListener(_checkFormCompletion);
    _telefonoController.addListener(_checkFormCompletion);
    _contrasenaController.addListener(_checkFormCompletion);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidosController.dispose();
    _emailController.dispose();
    _telefonoController.dispose();
    _contrasenaController.dispose();
    super.dispose();
  }

  void _checkFormCompletion() {
    setState(() {
      _isFormComplete = _nombreController.text.isNotEmpty &&
          _apellidosController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _telefonoController.text.isNotEmpty &&
          _contrasenaController.text.isNotEmpty;
    });
  }

  Future<void> _registerUser() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('https://api.tectorres.com/registro.php');
    try {
      final response = await http.post(
        url,
        body: {
          'nombre': _nombreController.text,
          'apellidos': _apellidosController.text,
          'email': _emailController.text,
          'telefono': _telefonoController.text,
          'contrasena': _contrasenaController.text,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['respuesta'] == '1') {
          // Registro exitoso
          await _saveFormData();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                username: _nombreController.text,
                email: _emailController.text,
                password: '',
                String: '',
              ),
            ),
          );
        } else {
          // Error en el registro
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseData['mensaje'])),
          );
        }
      } else {
        throw Exception('Error en la conexión con el servidor');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveFormData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombre', _nombreController.text);
    await prefs.setString('apellidos', _apellidosController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('telefono', _telefonoController.text);
    await prefs.setString('contrasena', _contrasenaController.text);
  }

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrarse'),
      ),
      body: GestureDetector(
        onTap: _hideKeyboard,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _apellidosController,
                  decoration: const InputDecoration(
                    labelText: 'Apellidos',
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Correo Electrónico',
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _telefonoController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Número Telefónico',
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _contrasenaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                  ),
                ),
                const SizedBox(height: 40.0),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: (_isFormComplete && !_isLoading) ? _registerUser : null,
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Registrarse',
                            style: TextStyle(fontSize: 18.0),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}