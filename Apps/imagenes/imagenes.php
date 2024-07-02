<?php

var_dump($_FILES);

if(isset($_FILES["file"])) {
    $file = $_FILES["file"]["tmp_name"];
    $letras = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890";
    
    $codigo = '';
    for($i = 0; $i < 30; $i++) {
        $codigo .= $letras[rand(0, strlen($letras)-1)];
    }
    
    $nuevo_nombre = $codigo . '.jpg';
    $ruta = '../fotos/' . $nuevo_nombre;
    
    if(move_uploaded_file($file, $ruta)) {
        echo '1';
    } else {
        echo 'Hubo un Error: ' . error_get_last()['message'];
    }
} else {
    echo 'No se recibió ningún archivo';
}
?>