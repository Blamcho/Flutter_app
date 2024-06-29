import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:dio/dio.dart';

class Fotos extends StatefulWidget {
  const Fotos({super.key});

  @override
  State<Fotos> createState() => _FotosState();
}

class _FotosState extends State<Fotos> {

  File? imagen;
  final ImagePicker picker = ImagePicker();

  Future seleccinar_imagen(op) async{

    XFile? pickedFile;
    if(op == 1){
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    }else{
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      if(pickedFile != null){
        //imagen = File(pickedFile.path);
        cortar(File(pickedFile.path));
      }
    });

  }

  Future cortar(picked) async{

    CroppedFile? cortado = await ImageCropper().cropImage(
      sourcePath: picked.path,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0)
    );

    if(cortado != null){
      setState(() {
        imagen = File(cortado.path);
        

      });
    }

  }

  Dio dio = Dio();

 Future<void> subirimagen() async {
  if (imagen == null) {
    print('No se ha seleccionado ninguna imagen');
    return;
  }

  try {
    String filename = imagen!.path.split('/').last;

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        imagen!.path, filename: filename
      )
    });

    Response response = await dio.post('https://api.tectorres.com/imagenes.php',
      data: formData
    );

    if(response.data == '1'){
      print('Se guardó la imagen');
    } else {
      print('Error: ${response.data}');
    }

  } catch(e) {
    print('Error al subir la imagen: ${e.toString()}');
  }
}

  seleccionar(){

    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                    seleccinar_imagen(1);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey)
                      )
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Text('Tomar una foto', style: TextStyle(
                              fontSize: 16
                          ),),
                        ),
                        Icon(Icons.camera_alt, color: Colors.blue,)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                    seleccinar_imagen(2);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Text('Tomar de galeria', style: TextStyle(
                              fontSize: 16
                          ),),
                        ),
                        Icon(Icons.image, color: Colors.blue,)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Cancelar', style: TextStyle(
                            fontSize: 16,
                          color: Colors.white
                        ),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Fotos'),
      ),*/
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                seleccionar();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue
              ),
              child: const Text('Tomar foto', style: TextStyle(
                color: Colors.white
              ),),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                subirimagen();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green
              ),
              child: const Text('Subir foto', style: TextStyle(
                  color: Colors.white
              ),),
            ),
            
          ],
        ),
      ),
    );
  }
}
