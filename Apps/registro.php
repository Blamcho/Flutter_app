<?php
include('Conectar.php');

// Get and sanitize input data
$nombre = mysqli_real_escape_string($conectar, $_POST['nombre']);
$apellidos = mysqli_real_escape_string($conectar, $_POST['apellidos']);
$email = mysqli_real_escape_string($conectar, $_POST['email']);
$telefono = mysqli_real_escape_string($conectar, $_POST['telefono']);
$contrasena = mysqli_real_escape_string($conectar, $_POST['contrasena']);

$mensaje = array();
$mensaje = array('respuesta' => '0', 'mensaje' => 'Error en el registro');

// Check if all fields are filled
if ($nombre == '' || $apellidos == '' || $email == '' || $telefono == '' || $contrasena == '') {
    $mensaje = array('respuesta' => '0', 'mensaje' => 'Debes llenar todos los campos');
} else {
    try {
        // Check if email already exists
        $checkEmail = "SELECT * FROM usuarios WHERE email='$email'";
        $checkResult = mysqli_query($conectar, $checkEmail);
        
        if (mysqli_num_rows($checkResult) > 0) {
            $mensaje = array('respuesta' => '0', 'mensaje' => 'El email ya está registrado');
        } else {
            // Insert new user
            $sql = "INSERT INTO usuarios (nombre, apellidos, email, telefono, password) 
                    VALUES ('$nombre', '$apellidos', '$email', '$telefono', '$contrasena')";
            
            if (mysqli_query($conectar, $sql)) {
                $id = mysqli_insert_id($conectar);
                $mensaje = array('respuesta' => '1', 'mensaje' => 'Registro exitoso', 'id' => $id);
            } else {
                $mensaje = array('respuesta' => '0', 'mensaje' => 'Error al registrar: ' . mysqli_error($conectar));
            }
        }
    } catch (Exception $e) {
        $mensaje["error"] = $e->getMessage();
    }
}

echo json_encode($mensaje, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
?>