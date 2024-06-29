import 'package:flutter/material.dart';

class Youtube extends StatefulWidget {
  const Youtube({super.key});

  @override
  State<Youtube> createState() => _YoutubeState();
}

class _YoutubeState extends State<Youtube> {

  menu(){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.access_time),
                title: const Text('Ver más tarde'),
                onTap: (){
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.copy),
                title: const Text('Guardar en lista'),
                onTap: (){
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Editar'),
                onTap: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          Image.asset('images/usuario.png'),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset('images/BH 1.jpg'),
                  ),
                ),
              ),
              const Expanded(
                flex: 8,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Momentos Inolvidables'),
                      Text('Views:100k')
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                      child: const Icon(Icons.more_vert),
                    onTap: (){
                        menu();
                    },
                  ),
                ),
              ),
            ],
          )
          
        ],
      ),
    );
  }
}
