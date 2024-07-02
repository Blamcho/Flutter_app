<?php

    include('Conectar.php');

    $nombre = mysqli_real_escape_string($conectar, $_POST['nombre']);
    $descripcion = mysqli_real_escape_string($conectar, $_POST['descripcion']);
    $precio = mysqli_real_escape_string($conectar, $_POST['precio']);
    $id = mysqli_real_escape_string($conectar, $_POST['id']);

    if($nombre == '' or $descripcion == '' or $precio == '' or $id == ''){
        echo 'Debes de verificar todos los datos';
    }else{
        $consulta = mysqli_query($conectar, "SELECT * FROM productos WHERE nombre='$nombre' and visible ='1' andid!='$id' ");
        $verificar = mysqli_num_rows($consulta);

        if ($verificar > 0){
            echo 'No puedes colocar ese nombre de producto, ya existe otro con ese nombre';
        }else{
            $editar = mysqli_query($conectar, "UPDATE productos SET nombre='$nombre', descripcion='$descripcion', precio='$precio' WHERE id='$id' ");

            if ($editar){
                echo '1';
            }else{
                echo 'Hubo un error favor de reportarlo';
            }
        }
    }
?>