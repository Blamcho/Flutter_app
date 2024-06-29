import 'package:flutter/material.dart';
import 'package:flutter_application_1/EditProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = '';
  String _lastName = '';
  String _email = '';
  String _phoneNumber = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Cargar los datos del usuario al iniciar la pantalla
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('name') ?? '';
      _lastName = prefs.getString('lastName') ?? '';
      _email = prefs.getString('email') ?? '';
      _phoneNumber = prefs.getString('phoneNumber') ?? '';
      _password = prefs.getString('password') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('images/usuario.1.png'), 
              ),
            ),
            const SizedBox(height: 20.0),
            _buildProfileInfo('Nombre', _username),
            _buildProfileInfo('Apellidos', _lastName),
            _buildProfileInfo('Correo', _email),
            _buildProfileInfo('Número Telefónico', _phoneNumber),
            _buildProfileInfo('Contraseña', _password, showDivider: false),
            const SizedBox(height: 40.0),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final updatedData = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfileScreen(_username, _lastName, _email, _phoneNumber, _password)),
                  );

                  if (updatedData != null) {
                    
                    setState(() {
                      _username = updatedData['username'];
                      _lastName = updatedData['lastName'];
                      _email = updatedData['email'];
                      _phoneNumber = updatedData['phoneNumber'];
                      _password = updatedData['password'];
                    });
                  }
                },
                child: const Text(
                  'Editar Perfil',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String title, String value, {bool showDivider = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$title: $value',
          style: const TextStyle(fontSize: 16.0),
        ),
        if (showDivider) const Divider(color: Colors.grey),
      ],
    );
  }
}
