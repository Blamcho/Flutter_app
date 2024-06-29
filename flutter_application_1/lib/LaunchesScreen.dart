import 'package:flutter/material.dart';

class LaunchesScreen extends StatelessWidget {
  const LaunchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lanzamientos'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.blueGrey[900], // Fondo azul oscuro para el banner
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/Logo.1.png', // Ruta de la imagen del juego
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Traills Space',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Traills Space es un juego basado en el videojuego inspirado en la franquicia de Tron desarrollado para dispositivos móviles que será lanzado el próximo 15 de junio del 2024.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Implementa la lógica para realizar acciones relacionadas con el lanzamiento del juego
              },
              child: const Text('Preordenar'),
            ),
          ],
        ),
      ),
    );
  }
}
