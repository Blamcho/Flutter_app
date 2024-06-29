import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

// ignore: must_be_immutable
class editar extends StatefulWidget {

  String? id = '';
  String? nombre = '';
  String? descripcion = '';
  String? precio = '';

  editar(this.id, this.nombre, this.descripcion, this.precio,{super.key});

  @override
  State<editar> createState() => _editarState();
}

class _editarState extends State<editar> {

  var c_nombre = TextEditingController();
  var c_descripcion = TextEditingController();
  var c_precio = TextEditingController();

  String nombre = '';
  String descripcion = '';
  String precio = '';

  Future <void> guardar() async{
    var url = Uri.https("api.tectorres.com", "EditarProductos.php");

    var response = await https.post(url, body: {
      'nombre' : nombre,
      'descripcion' : descripcion,
      'precio' : precio,
      'id':widget.id!,
    });

    print('Respuesta:${response.body}');

    if(response.body == '1'){

      Navigator.of(context).pop();

    }else{
      print(response.body);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      c_nombre.text = widget.nombre!;
      c_descripcion.text = widget.descripcion!;
      c_precio.text = widget.precio!;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar productos', style: TextStyle(color: Colors.white),),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 4, 87, 155),
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
                guardar();

              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[900]),
              child: const Text('Guardar cambios', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
