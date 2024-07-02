<?php
error_reporting(E_ALL);
error_reporting(-1);
ini_set('error_reporting', E_ALL);

    header("Content-type: application/json; charset=utf-8");
    include ('Conectar.php');

    $consulta = mysqli_query($conectar, "SELECT * FROM productos WHERE visible='1' ORDER BY nombre ASC");
    $verificar = mysqli_num_rows($consulta);
    $productos = array();
    

    if($verificar > 0){
        while($fila = mysqli_fetch_assoc($consulta)){
            array_push($productos, array('id' => $fila['id'],'nombre' => $fila['nombre'], 'descripcion'=> $fila['descripcion'],'precio' => $fila['precio']));
        } 
    }

    

echo json_encode($productos, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE |JSON_UNESCAPED_SLASHES);

?> 