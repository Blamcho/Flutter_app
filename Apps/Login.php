<?php

 //echo json_encode($_POST);
    // die();
    include('Conectar.php');
    $usuario = mysqli_real_escape_string($conectar, $_POST['Usuario']);
    $pass = mysqli_real_escape_string($conectar, $_POST['Contrasena']);
     $email = mysqli_real_escape_string($conectar, $_POST['email']);

    // echo $usuario . '--' . $pass;

    $mensaje = array();
    $mensaje = array('respuesta' => '0', 'mensaje' => 'Usuario o contraseña incorrecta');
    // $mensaje["data"] = [$usuario,$pass];
    if($usuario == '' or $pass == ''){

        $mensaje = array('respuesta' => '0', 'mensaje' => 'Debes de llenar todos los datos');

    }else{
        try {
            
            $sql = "SELECT * FROM usuarios WHERE nombre='$usuario' and password='$pass'";
            // $mensaje["sql"] = $sql;
            $consulta = mysqli_query($conectar, $sql);
            $vertificar = mysqli_num_rows($consulta);
    
            if($vertificar > 0){
    
                $datos = mysqli_fetch_assoc($consulta);
    
                $mensaje = array('respuesta' => '1', 'id' => $datos['id'], 'usuario' => $datos['nombre'] , 'email' => $datos['email']);
    
            }
        } catch (\Exception $e) {
            //throw $th;
            $mensaje["error"] = $e->getMessage();
        }

    }

    echo json_encode($mensaje, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);

?>
