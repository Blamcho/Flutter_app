class Datos_Productos {
  String? id;
  String? nombre;
  String? descripcion;
  String? precio;
  String? fecha;
  String? hora;

  Datos_Productos({this.id, this.nombre, this.descripcion, this.precio, this.fecha, this.hora});

  factory Datos_Productos.fromJson(Map<String, dynamic> json) {
    return Datos_Productos(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      precio: json['precio'],
      fecha: json['fecha'],
      hora: json['hora'],
    );
  }
}
