<?php

//clase enecargada de realizar la conexion con la base de datos en mysql
class  db
{
    //declaracion de variables que sirven para la cadena de conexion a DB
    private $dbhost = 'localhost';
    private $dbuser = 'root';
    private $dbpass = '';
    private $dbname = 'ecoplace';

    public static function conectar(){
        try
        {
            //$cn = new PDO("mysql:host=localhost;dbname=ecoplace","Administrator_ecp","3590Place");
            $_string_cn = "mysql:host=localhost;dbname=ecoplace";
            $cn = new PDO($_string_cn, 'root', '');
            $cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            return $cn;
            
        } catch (PDOException $ex){
            echo '{"error": {"text": '.$ex->getMessage().'}';
        }     
    }
}
// $con = db::conectar();

?>