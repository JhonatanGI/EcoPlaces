<?php

require '../config/db.php';

$sql = 'SELECT * FROM ecp_data';

    try{
        //inicializa clase cde conexion db
        $db = new db();
        //conectar a db
        $db = $db->conectar();
        //ejecucion de query
        $stm = $db->query($sql);
        $data = $stm->fetchAll(PDO::FETCH_OBJ);
         
        $db = null;
        //retorna la cadena de datos en formato json
        echo json_encode($data);

     }catch(PDOException $ex){
        echo '{"error": {"text": '.$ex->getMessage().'}';
     }
?>