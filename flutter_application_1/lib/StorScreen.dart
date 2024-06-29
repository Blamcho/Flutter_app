import 'package:flutter/material.dart';
import 'package:flutter_application_1/listaProductos.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF171a21), // Color de fondo de Steam
        title: const Text('Tienda', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const lista_productos()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFF1b2838), // Color de fondo principal de Steam
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                _showGameDetails(context, 'Space Trails', 'Una emocionante aventura en un vasto mundo abierto.', 59.99, 'images/Logo.png');
              },
              child: _buildGameItem('Space Trails', 'Explora el espacio', 'images/Logo.1.png'),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                _showGameDetails(context, 'Bouncy Hallucination', 'Explora lo desconocido.', 49.99, 'images/BH 1.jpg');
              },
              child: _buildGameItem('Bouncy Hallucination', '', 'images/BH 1.jpg'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameItem(String title, String subtitle, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF2a475e), // Color de fondo de los items
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            height: 120.0,
          ),
          const SizedBox(height: 10.0),
          Text(
            title,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          if (subtitle.isNotEmpty) const SizedBox(height: 4.0),
          if (subtitle.isNotEmpty)
            Text(
              subtitle,
              style: const TextStyle(fontSize: 14.0, color: Color(0xFF66c0f4)),
            ),
        ],
      ),
    );
  }

  void _showGameDetails(BuildContext context, String title, String description, double price, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF1b2838), // Color de fondo de Steam
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  imagePath,
                  height: 200.0,
                ),
                const SizedBox(height: 10.0),
                Text(
                  title,
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 4.0),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14.0, color: Color(0xFF66c0f4)),
                ),
                const SizedBox(height: 10.0),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Color(0xFF66c0f4)),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar', style: TextStyle(color: Color(0xFF66c0f4))),
            ),
          ],
        );
      },
    );
  }
}