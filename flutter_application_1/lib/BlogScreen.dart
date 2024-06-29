import 'package:flutter/material.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF171a21), // Color de fondo de Steam
        title: const Text('Blog', style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Color(0xFF1b2838), // Color de fondo principal de Steam
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Color(0xFF171a21), // Color de fondo del banner de Steam
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/LOGO3.jpg', // Ruta de la imagen del logo
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Torres Games',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Una empresa y estudio de desarrollo de videojuegos\n'
                    'fundada el 15 de agosto del 2021 por Abraham Torres',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF66c0f4), // Azul claro de Steam
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Últimas Publicaciones',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  _buildBlogPost(
                    'SpaceTraills',
                    'lucha y sobrevive 1...',
                    'images/Logo.1.png',
                  ),
                  const SizedBox(height: 12.0),
                  _buildBlogPost(
                    'BouncyHallucinatio',
                    'Explra un mudo desconocido',
                    'images/BH 1.jpg',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlogPost(String title, String description, String imagePath) {
    return Card(
      color: Color(0xFF2a475e), // Color de fondo de los items en Steam
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            imagePath,
            height: 200.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF66c0f4), // Azul claro de Steam
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}