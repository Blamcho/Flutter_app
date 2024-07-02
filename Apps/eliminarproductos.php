<?php
include('Conectar.php');

$id = mysqli_real_escape_string($conectar, $_POST['id']);

if($id != ''){

$consulta = mysqli_query($conectar, "SELECT * FROM productos WHERE id='$id' and visible='1'");
$verificar = mysqli_num_rows($consulta);
if ($verificar > 0){


    //$eliminar = mysqli_query($conectar, "DELETE FROM productos WHERE  id='$id' and visible='1'");
    $eliminar = mysqli_query($conectar, "UPDATE productos SET visible='0' WHERE id='$id' and 
    visible='1'");
    
    if($eliminar){
        echo '1';
    }else{
        echo  'Hubo Un error favor de reportarlo';
    }

}else{
    echo 'No se encontró el producto';
}


}

?>