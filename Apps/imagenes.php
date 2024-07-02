<?php
        $flie =$_FILES["file"]["tpm_name"];
        $letras = "qwertyuiopassdfghjklzxcvbnmQWERTTYUIOPASDFGHJKLZXCVBNM1234567890";

        $codigo = '';   

        for($i = 0; $i < 30;    $i++) {
            $codigo .= $letras[rand(0, strlen($letras)-1)];

            $nuevo_nombre = $codigo.'.jpg';
            $ruta = '../fotos/'.$nuevo_nombre;

            $copiar = move_uploaded_file($file, $ruta);

            if($copiar){

                echo '1';
                
            } else{

                echo 'Hubo un Error     ';
            }

        }


?>