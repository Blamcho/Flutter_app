import 'dart:convert';
//import 'dart:html';
import 'package:flutter_application_1/EditarProductoScreen.dart';
import 'add_productos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'datos_productos.dart';

class lista_productos extends StatefulWidget {
  const lista_productos({super.key});

  @override
  State<lista_productos> createState() => _lista_productosState();
}

class _lista_productosState extends State<lista_productos> {


  List<Datos_Productos> datos = [];
  bool loading = true;

  Future<List<Datos_Productos>> tomar_datos() async {

    var url = Uri.https('api.tectorres.com', 'verproductos.php');

    var response = await https.post(url).timeout(const Duration(seconds: 90));

    print(response.body);

    var datos = jsonDecode(response.body);

    

    List<Datos_Productos> registros = [];


    for (datos in datos){
      registros.add(Datos_Productos.fromJson(datos));
    }

    return registros;
  }

  mostrar_alerta(id, nombre){
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text('ALERTA!!'),
          content: SingleChildScrollView(
            child: Text('${'Realmente quieres eliminar: ' +nombre}?'),
          ),
          actions: [
            TextButton(
              onPressed: (){
                confirmar_eliminar(id);
              },
              child: const Text('Eliminar', style: TextStyle(color: Colors.red),),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar', style: TextStyle(color: Colors.blueAccent),),
            )
          ],
        );
      });
  }

  Future<void>  confirmar_eliminar(id) async{

    var url = Uri.https('api.tectorres.com', 'eliminarproductos.php');

    var response = await https.post(url, body: {
      'id' : id
    }).timeout(const Duration(seconds: 90));

    Navigator.of(context).pop();

    print(response.body);

    if(response.body == '1'){

      setState(() {
        datos = [];
        loading = true;
        tomar_datos().then((value){
          setState(() {
            datos.addAll(value);
            loading = false;
          });
        });
      });

    }else{
      print(response.body);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tomar_datos().then((value){
      setState(() {
        datos.addAll(value);
        loading = false;
        print(datos);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de productos', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue[900],
      ),
      body:  loading  == true ?

      const Center(
        child: CircularProgressIndicator(color: Colors.blueAccent,),
      )

      : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: datos.length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color:Colors.grey, width: 1)
                    )
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(datos[index].nombre!, style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                          ),),
                      ),
                      GestureDetector(
                          child: const Icon(Icons.edit, color: Colors.green,),
                        onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context){ //print(datos[index]);
                                  return editar(datos[index].id!, datos[index].nombre!,
                                  datos[index].descripcion??"", datos[index].precio!);
                                }
                                )).then((value){

                                  setState(() {
                                    datos = [];
                                    loading = true;
                                    tomar_datos().then((value){
                                      setState(() {
                                        datos.addAll(value);
                                        loading = false;
                                      });
                                    });
                                  });
                            });
                        },
                      ),
                      const SizedBox(width: 10,),
                      GestureDetector(
                          child: const Icon(Icons.delete, color: Colors.red,),
                        onTap: (){
                            mostrar_alerta(datos[index].id, datos[index].nombre);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: (){

          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context){
                return const add_productos();
              }
          )).then((value){
            setState(() {
              datos = [];
              loading = true;
              tomar_datos().then((value){
                setState(() {
                  datos.addAll(value);
                  loading = false;
                });
              });
            });
          });

        },
        backgroundColor: Colors.blue[900],
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}