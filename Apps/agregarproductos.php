<?php



include ('Conectar.php');

$nombre = mysqli_real_escape_string($conectar, $_POST['nombre']);
$descripcion = mysqli_real_escape_string($conectar, $_POST['descripcion']);
$precio = mysqli_real_escape_string($conectar, $_POST['precio']);

//echo $nombre.'--'.$descripcion.'--'.$precio;

date_default_timezone_set('America/Mexico_City');
$fecha = date("Y-m-d");
$hora = date("g:i a");

if($nombre == '' or $descripcion == '' or $precio == ''){
    echo 'Debes de llenar todos los campos';
}else{
    $consulta = mysqli_query($conectar, "SELECT * FROM productos WHERE nombre = '$nombre' and visible ='1' ");
    $verificar = mysqli_num_rows($consulta);

    if($verificar > 0){
        echo 'ese producto ya existe, cambia el nombre';
    }else{
        if (!is_numeric($precio)){
            echo 'El precio debe de ser un numero';
        }else{
            $insertar = mysqli_query($conectar, "INSERT INTO productos (nombre, descripcion, precio, fecha, hora, visible) VALUES ('$nombre','$descripcion','$precio','$fecha','$hora','1' )");

            if($insertar){
                echo '1';
            }else{
                echo 'Hubo un error, favor de reportarlo';
            }
        }
    }
}

?>