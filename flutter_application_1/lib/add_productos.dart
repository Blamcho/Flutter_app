import 'package:flutter/material.dart';
import 'package:http/http.dart' as https ;

class add_productos extends StatefulWidget {



  const add_productos({super.key});

  @override
  State<add_productos> createState() => _add_productosState();
}

class _add_productosState extends State<add_productos> {

  var c_nombre = TextEditingController();
  var c_descripcion = TextEditingController();
  var c_precio = TextEditingController();

  String nombre = '';
  String descripcion = '';
  String precio = '';

  Future <void> agregar() async{
    var  url = Uri.https("api.tectorres.com","agregarproductos.php");

    var response = await https.post(url, body: {
        'nombre' : nombre,
        'descripcion' : descripcion,
        'precio' : precio
    });

    print('Respuesta:${response.body}');

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('agregar productos', style: TextStyle(color: Colors.white),),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: c_nombre,
              decoration: const InputDecoration(
                  hintText: 'nombre'
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: c_descripcion,
              decoration: const InputDecoration(
                  hintText: 'descripcion'
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: c_precio,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: 'precio'
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: (){

                nombre = c_nombre.text;
                descripcion = c_descripcion.text;
                precio = c_precio.text;
                agregar();

              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[900]),
              child: const Text('agregar', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}